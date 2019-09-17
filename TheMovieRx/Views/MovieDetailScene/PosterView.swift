//
//  PosterView.swift
//  TheMovieRx
//
//  Created by Suman Chatterjee on 18/12/2018.
//  Copyright © 2018 Suman Chatterjee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol FromNibLoadable {
    func loadViewFromNib()
}

extension FromNibLoadable where Self: UIView {

    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            return
        }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
}

protocol ImageDisplayable {
    func downloadAndDisplay(_ UrlString: String, in imageView: UIImageView, completion: (() -> Void)?)
}

extension ImageDisplayable {
    func downloadAndDisplay(_ UrlString: String, in imageView: UIImageView, completion: (() -> Void)? = nil) {
        let disposable = SingleAssignmentDisposable()
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(UrlString)") else { return }
        let request = URLRequest(url: url)
        let s = URLSession.shared.rx.image(request: request).asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { uiImage in
                imageView.image = uiImage
                completion?()
            })
        disposable.setDisposable(s)
    }
}
class PosterView: UIView, FromNibLoadable, ImageDisplayable {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    func downloadAndDisplay(url stringUrl: String) {
        activityIndicator.startAnimating()
        downloadAndDisplay(stringUrl, in: posterImageView) {
            self.activityIndicator.stopAnimating()
        }
    }
}
