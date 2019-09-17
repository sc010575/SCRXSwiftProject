//
//  MovieListTableViewCell.swift
//  TheMovieRx
//
//  Created by Suman Chatterjee on 08/12/2018.
//  Copyright © 2018 Suman Chatterjee. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import AlamofireImage

class MovieListTableViewCell: UITableViewCell,ImageDisplayable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

//    var disposable = SingleAssignmentDisposable()
//    let imageDownloader = ImageDownloader()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
    }

    func downloadAndDisplay(url stringUrl: String) {
        activityIndicator.startAnimating()
        downloadAndDisplay(stringUrl, in: posterImage) {
            self.activityIndicator.stopAnimating()
        }
    }

//    func downloadAndDisplay(url stringUrl: String) {
//        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(stringUrl)") else { return }
//        let request = URLRequest(url: url)
//        activityIndicator.startAnimating()
//        imageDownloader.download(request) { response in
//            print(response.request)
//            print(response.response)
//            debugPrint(response.result)
//
//            if let image = response.result.value {
//                self.posterImage.image = image
//                self.activityIndicator.stopAnimating()
//            }
//
//        }
//
//    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
