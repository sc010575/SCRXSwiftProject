import Foundation
import RxSwift
import RxCocoa
@testable import TheMovieRx

class MovieListViewModelMock : MovieListVMProtocal {

    var apiController: ApiController
    var movieRequestType: MovieQueryType
    var movieObservable = PublishSubject<Movie>()
    var results = PublishSubject<[SectionOfCustomData]>()
    var errorHandle: Variable<Error>
    var loadMovieCalled:Bool = false
    var bag =  DisposeBag()
    

    init(_ apiController: ApiController, requestType: MovieQueryType) {
        self.apiController = apiController
        self.movieRequestType = requestType
        self.errorHandle = Variable<Error>(RxURLSessionError.unknown)
    }

    
    func loadMovie() {
        loadMovieCalled = true
    }

    func clear() {
        Cache.clear()
    }    
}
