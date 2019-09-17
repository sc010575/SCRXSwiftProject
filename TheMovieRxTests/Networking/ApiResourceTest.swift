import Quick
import Nimble
@testable import TheMovieRx

class NetworkTest: ApiResource {

}
class ApiResourceTest: QuickSpec {
    override func spec() {
        let network = NetworkTest()
        describe("ApiResource Test") {
            context("when call load movie details") {
                it("should return right url request") {
                   let urlToTest = URL(string: "http://localhost:8088/movie/297802?api_key=449d682523802e0ca4f8b06d8dcf629c&language=en-US")
                   let request =  network.movieDetailRequest(id: 297802)
                    expect(request?.url?.absoluteString).to(equal(urlToTest?.absoluteURL.absoluteString))
                }
            }
            context("When call movie request type") {
                it("should return right url") {
                    let urlToTest = URL(string: "http://localhost:8088/movie/popular?api_key=449d682523802e0ca4f8b06d8dcf629c&language=en-US")
                    let request =  network.movieTypeRequest(requestType: .popular)
                    expect(request?.url?.absoluteString).to(equal(urlToTest?.absoluteURL.absoluteString))
                }
            }
        }
    }
}
