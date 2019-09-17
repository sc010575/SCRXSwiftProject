//
//  MovieListViewController.swift
//  TheMovieRx
//
//  Created by Suman Chatterjee on 08/12/2018.
//  Copyright © 2018 Suman Chatterjee. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

private extension String {
    func firstCharacterUpperCase() -> String? {
        if self.count == 0 { return self }
        return prefix(1).uppercased() + dropFirst().lowercased()
    }
}
class MovieListViewController: UIViewController {

    var viewModel: MovieListVMProtocal!
    let bag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") as? MovieListTableViewCell
            cell?.overviewLabel.text = "\(element.description)"
            cell?.downloadAndDisplay(url: element.posterUrl)
            cell?.titleLabel.text = element.title
            cell?.releaseDateLabel.text = element.formattedReleaseDate()
            return cell ?? UITableViewCell()
        }
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.movieRequestType.rawValue.firstCharacterUpperCase() ?? "Results"

        tableView.estimatedRowHeight = 150
        viewModel.results
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)

        viewModel.loadMovie()
        
        let running = viewModel.results.map{_ in false }
            .startWith(true)
            .asDriver(onErrorJustReturn: false)

        running
            .drive(tableView.rx.isHidden)
            .disposed(by: bag)

        tableView.rx
            .setDelegate(self)
            .disposed(by: bag)
        
        running
            .skip(1)
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: bag)

        viewModel.errorHandle.asObservable()
            .skip(1)
            .bind { error in
                self.showError(error, bag: self.bag)
            }.disposed(by: bag)
        
        tableView.rx
            .itemSelected
            .map { indexPath in
                return (indexPath, self.dataSource[indexPath])
            }
            .subscribe(onNext: { pair in
                self.performSegue(withIdentifier: "MoveToDetails", sender: pair.1)
            })
            .disposed(by: bag)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.clear()
        super.viewWillDisappear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let customData = sender as? CustomData else { return}
        
        if segue.identifier == "MoveToDetails" {
            guard let navVC = segue.destination as? UINavigationController,
                let detailVC = navVC.visibleViewController as? MovieDetailViewController else { return }
            
            let viewModel = MovieDetailViewModel(customData.id)
            detailVC.viewModel = viewModel
            detailVC.movieTitle = "\(customData.title) (\(customData.releaseDate.prefix(4)))"
        }
    }
    
    @IBAction func onTapClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

