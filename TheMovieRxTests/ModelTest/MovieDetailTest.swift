import Quick
import Nimble

@testable import TheMovieRx


final class MovieDetailTest: QuickSpec {
    override func spec() {
        describe("MovieDetail model Test") {
            context("When parse the JSON file for movie details") {
                it("Populate the MovieDetail model") {
                    let dataResult = Fixtures.getJSONData(jsonPath: "movieDetail")
                    guard let movieDetail: MovieDetail = ParseJson.parse(data: dataResult!) else {
                        return
                    }
                    expect(movieDetail.originalTitle).to(equal("Aquaman"))
                    expect(movieDetail.homepage).to(equal("http://www.aquamanmovie.com"))
                    expect(movieDetail.releaseDate).to(equal("2018-12-07"))
                    expect(movieDetail.backdropPath).to(equal("/5A2bMlLfJrAfX9bqAibOL2gCruF.jpg"))
                    expect(movieDetail.productionCompanies.count).to(equal(4))
                    expect(movieDetail.voteCount).to(equal(233))
                }
            }
        }
    }
}
