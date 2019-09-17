import Foundation
import RxSwift
import RxCocoa
import RxBlocking

@testable import TheMovieRx

class ApiControllerMock: ApiController {
    let scheduler = ConcurrentDispatchQueueScheduler(qos: .default)

    override func loadFor(_ movieRequestType: MovieQueryType) -> Observable<Movie> {
        if let request = self.movieTypeRequest(requestType: movieRequestType) {
            let s = URLSession.shared.rx.movie(request: request).asObservable().observeOn(scheduler).toBlocking(timeout: 1.0).materialize()

            switch s {
            case .completed(elements: let elements):
                return Observable.from(elements)
            case .failed(_, error: let error):
                return Observable.error(error)
            }
        } else {
            return Observable.empty()
        }
    }
}
