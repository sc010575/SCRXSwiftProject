//
//  MovieDetailViewController.swift
//  TheMovieRx
//
//  Created by Suman Chatterjee on 16/12/2018.
//  Copyright © 2018 Suman Chatterjee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailViewController: UIViewController {

    var movieTitle:String?
    var viewModel:MovieDetailViewModel!
    let bag = DisposeBag()

//    @IBOutlet weak var navigationTitle: UILabel!
    @IBOutlet weak var progressBar: CircularProgressView!
    @IBOutlet weak var posterView: PosterView!
    @IBOutlet weak var overviewLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let title = movieTitle else { return }
        self.title = title
//        navigationTitle.text = title
        viewModel.movieDriver.drive(onNext: { movieDetail in
            self.overviewLabel.text = movieDetail.overview
            self.posterView.downloadAndDisplay(url: movieDetail.backdropPath)
            self.setupProgress(with: Double(movieDetail.voteAverage * 10))
        })
        .disposed(by: bag)
        viewModel.loadMovieDetail()
    }
    
    @IBAction func onTapExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func setupProgress(with progress:Double) {
        progressBar.labelSize = 10
        progressBar.safePercent = Int(progress)
        progressBar.setProgress(to: Double(progress * 0.01), withAnimation: true)
    }
}
