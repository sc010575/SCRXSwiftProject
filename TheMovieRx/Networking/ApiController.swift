import Foundation
import RxSwift
import RxCocoa

class ApiController: ApiResource {

    init() {
        Logging.URLRequests = { request in
            return true
        }
    }

    func loadFor(_ movieRequestType: MovieQueryType) -> Observable<Movie> {
        if let request = self.movieTypeRequest(requestType: movieRequestType) {
            return URLSession.shared.rx.movie(request: request)
        } else {
            return Observable.empty()
        }
    }

    func loadFor(_ movieId: Int) -> Observable<MovieDetail> {
        if let request = self.movieDetailRequest(id: movieId) {
            return URLSession.shared.rx.movieDetail(request: request)
        } else {
            return Observable.empty()
        }
    }
}
