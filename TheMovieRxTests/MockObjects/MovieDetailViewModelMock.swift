import Foundation
import RxSwift
import RxCocoa
import RxBlocking

@testable import TheMovieRx

class MovieDetailViewModelMock: MovieDetailViewModel {
    
    let scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    override func loadMovieDetail() {

        let movieDetail = MovieDetail(backdropPath: "/5A2bMlLfJrAfX9bqAibOL2gCruF.jpg", overview: "Test Overview", budget: 10, homepage: "A Homepage", originalTitle: "A Title", releaseDate: "10/10/2018", voteAverage: 6.5, voteCount: 650, productionCompanies: [])
        let s = Observable.of(movieDetail).asObservable()
            .observeOn(scheduler).toBlocking(timeout: 1.0).materialize()
        
        switch s {
        case .completed(elements: let elements):
            let detail = elements.compactMap { return $0 }
            self.publishDetails.onNext(detail.first!)
            self.publishDetails.onCompleted()
        case .failed(_, error: _): break
        }
    }
}

