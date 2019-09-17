import Quick
import Nimble
import RxSwift
import RxBlocking

@testable import TheMovieRx
class ApiControllerTest: QuickSpec {
    var server: MockServer!
    var apiController = ApiController()
    let scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    override func spec() {
        describe("ApiResource Test") {
            context("When call load movie with a movie id") {
                beforeEach {
                    self.server = MockServer()
                }

                afterEach {
                    self.server.stop()
                }
                it("should return movie detail observable") {
                    self.server.respondToMovieDetails().start()
                    let s = self.apiController.loadFor(297802).asObservable().observeOn(self.scheduler).toBlocking(timeout: 1.0).materialize()

                    switch s {
                    case .completed(elements: let elements):
                        let detail = elements.compactMap { return $0 }
                        expect(detail[0].originalTitle).toEventually(equal("Aquaman"))
                        expect(detail[0].homepage).toEventually(equal("http://www.aquamanmovie.com"))
                    case .failed(_, error: _): break
                    }
                }
            }
        }
    }
}
