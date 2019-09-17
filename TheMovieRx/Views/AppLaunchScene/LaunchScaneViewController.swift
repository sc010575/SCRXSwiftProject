//
//  LaunchScaneViewController.swift
//  TheMovieRx
//
//  Created by Suman Chatterjee on 06/12/2018.
//  Copyright © 2018 Suman Chatterjee. All rights reserved.
//

import UIKit

@IBDesignable
class MovieChoiceButton: UIButton {

    var queryType: MovieQueryType = .none

    @IBInspectable var backGroundColor: UIColor = .clear {
        didSet {
            backgroundColor = backGroundColor
        }
    }

    @IBInspectable var corner: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = corner
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
        }
    }
}

class LaunchScaneViewController: UIViewController {

    @IBOutlet weak var popularButton: MovieChoiceButton! {
        didSet {
            popularButton.queryType = .popular
        }
    }

    @IBOutlet weak var topRatedButton: MovieChoiceButton! {
        didSet {
            topRatedButton.queryType = .topRated
        }
    }

    @IBOutlet weak var upCommingButton: MovieChoiceButton! {
        didSet {
            upCommingButton.queryType = .upcoming
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoveToMovieList" {
            guard let navVC = segue.destination as? UINavigationController,let vc = navVC.visibleViewController as? MovieListViewController, let queryType = sender as? MovieQueryType  else { return }
            let viewModel = MovieListViewModel(ApiController(), requestType: queryType)
            vc.viewModel = viewModel
        }
        
    }
    @IBAction func onTapChoiceButton(_ sender: Any) {

        guard let button = sender as? MovieChoiceButton else { return }
        let queryType = button.queryType
        performSegue(withIdentifier: "MoveToMovieList", sender: queryType)
    }

}
