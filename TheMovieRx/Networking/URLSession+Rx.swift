import Foundation
import RxCocoa
import RxSwift

struct Cache {
    static var internalCache = [String: Data]()
    
    static func clear() {
        Cache.internalCache.removeAll()
    }
}

extension ObservableType where E == (HTTPURLResponse, Data) {
    func cache() -> Observable<E> {
        return self.do(onNext: { (response, data) in
            if let url = response.url?.absoluteString, 200 ..< 300 ~=
                response.statusCode {
                Cache.internalCache[url] = data
            }
        })
    }
}

public enum RxURLSessionError: Error {
    case unknown
    case invalidResponse(response: URLResponse)
    case requestFailed(response: HTTPURLResponse, data: Data?)
    case deserializationFailed
}

extension Reactive where Base: URLSession {

    func response(request: URLRequest) -> Observable<(HTTPURLResponse, Data)> {
        return Observable.create { observer in
            let task = self.base.dataTask(with: request) { data, response, error in

                guard let response = response, let data = data else {
                    observer.on(.error(error ?? RxURLSessionError.unknown))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    observer.on(.error(RxURLSessionError.invalidResponse(response:
                            response)))
                    return
                }
                observer.onNext((httpResponse, data))
                observer.on(.completed)
            }
            task.resume()
            return Disposables.create(with: task.cancel)
        }
    }
    func data(request: URLRequest) -> Observable<Data> {

        if let url = request.url?.absoluteString, let data = Cache.internalCache[url] {
            return Observable.just(data)
        }

        return response(request: request).cache().map { (response, data) -> Data in
            if 200 ..< 300 ~= response.statusCode {
                return data
            } else {
                throw RxURLSessionError.requestFailed(response: response, data:
                        data)
            }
        }
    }

    func string(request: URLRequest) -> Observable<String> {
        return data(request: request).map { data in
            return String(data: data, encoding: .utf8) ?? ""
        }
    }
    
    func image(request: URLRequest) -> Observable<UIImage> {
        return data(request: request).map { d in
            return UIImage(data: d) ?? UIImage()
        }
    }
    

    func movie(request: URLRequest) -> Observable<Movie> {
        return data(request: request).map { data in
            return ParseJson.parse(data: data) ?? Movie.emptyMovie
        }
    }
    func movieDetail(request: URLRequest) -> Observable<MovieDetail> {
        return data(request: request).map { data in
            return ParseJson.parse(data: data) ?? MovieDetail.emptyMovieDetails
        }
    }

}
