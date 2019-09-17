//
//  MovieListViewModel.swift
//  TheMovieRx
//
//  Created by Suman Chatterjee on 08/12/2018.
//  Copyright © 2018 Suman Chatterjee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct CustomData {
    var id:Int
    var description: String
    var posterUrl: String
    var title: String
    var releaseDate: String

    func formattedReleaseDate() -> String? {

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: releaseDate) {
            return dateFormatterPrint.string(from: date)
        }
        return nil
    }
}

struct SectionOfCustomData {
    var header: MovieQueryType
    var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    typealias Item = CustomData

    var identity: MovieQueryType {
        return header
    }

    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}

protocol MovieListVMProtocal {
    var apiController: ApiController { get }
    var movieRequestType: MovieQueryType { get }
    var results: PublishSubject<[SectionOfCustomData]> { get }
    var errorHandle: Variable<Error> { get }
    var bag:DisposeBag { get }
    func loadMovie()
    func clear()
}

final class MovieListViewModel: MovieListVMProtocal {
    private(set) var apiController: ApiController
    private(set) var movieRequestType: MovieQueryType
    var results = PublishSubject<[SectionOfCustomData]>()
    var errorHandle: Variable<Error>

    let disposaple = SingleAssignmentDisposable()
    let bag = DisposeBag()
    init(_ apiController: ApiController, requestType: MovieQueryType) {
        self.apiController = apiController
        self.movieRequestType = requestType
        self.errorHandle = Variable<Error>(RxURLSessionError.unknown)
    }

    func loadMovie() {
        let s = apiController.loadFor(movieRequestType).asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { movie in
                self.results.onNext(self.prepareSectionData(movie.results))
                self.results.onCompleted()
            }, onError: { error in
                    self.errorHandle.value = error
                })
        disposaple.setDisposable(s)
    }
    
    func clear() {
        self.results.disposed(by: bag)
        Cache.clear()
    }
}

private extension MovieListViewModel {
    func prepareSectionData(_ results: [Result]) -> [SectionOfCustomData] {
        return results.map {
            SectionOfCustomData(header: movieRequestType, items: [CustomData(id:$0.id, description: $0.overview, posterUrl: $0.posterPath, title: $0.title, releaseDate: $0.releaseDate)])
        }
    }
}
