import Nimble
import Quick
@testable import TheMovieRx

class MovieDetailViewControllerTest: QuickSpec {
    
    override func spec() {
        describe("MovieDetailViewController Test") {
            
            var viewController: MovieDetailViewController?
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            beforeEach {
                viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
            }
            context("When movie details initiated") {
                it("Contain movie name in the title and year of release"){
                    let title = "Aquaman"
                    let release = "2018"
                    let movieDetailViewModelMock = MovieDetailViewModelMock(2000)
                    viewController?.movieTitle = "\(title)(\(release))"
                    viewController?.viewModel = movieDetailViewModelMock
                    viewController?.preloadView()
                    let (wnd, tearDown) = (viewController?.appearInWindowTearDown())!
                    defer { tearDown() }
                    expect(viewController?.title).to(contain(title))
                    expect(viewController?.title).to(contain(release))
                    expect(viewController?.overviewLabel.text).toEventually(equal("Test Overview"))
                }
            }
        }
    }
}
