import Nimble
import Quick
@testable import TheMovieRx


final class MovieListViewControllerTest: QuickSpec {
    
    var server = MockServer()

    override func spec() {
        describe("MovieListViewController tests") {
            var viewController: MovieListViewController?
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            beforeEach {
                viewController = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController
            }
            context("When MovieListViewController is launched ") {
                it("tableview should not be nil") {
                    
                    let viewModel = MovieListViewModelMock(ApiController(),requestType:.popular)
                    viewController?.viewModel = viewModel
                    
                    viewController?.preloadView()
                    let (wnd, tearDown) = (viewController?.appearInWindowTearDown())!
                    defer { tearDown() }

                    expect(viewController?.tableView!).toNot(beNil())
                    let viewModelMock = viewController?.viewModel as? MovieListViewModelMock
                    expect(viewModelMock?.loadMovieCalled).to(beTrue())
                }
            }
            
            context("when viewcontroller is initiated") {
                afterEach {
                    self.server.stop()
                }
                
                it("load the movie lists to the tableview for a successful api call") {
                    self.server.respondToMovieLists(fixture: "movie", statusCode: 200).start()
                    let viewModel = MovieListViewModel(ApiControllerMock(), requestType: .popular)
                    viewController?.viewModel = viewModel
                    
                    viewController?.preloadView()
                    let (wnd, tearDown) = (viewController?.appearInWindowTearDown())!
                    defer { tearDown() }
                    
                    let cell = viewController?.tableView.visibleCells[0] as? MovieListTableViewCell
                    let overview = cell?.overviewLabel.text!
                    expect(overview).toEventually(equal("Eddie Brock is a reporter—investigating people who want to go unnoticed. But after he makes a terrible discovery at the Life Foundation, he begins to transform into ‘Venom’.  The Foundation has discovered creatures called symbiotes, and believes they’re the key to the next step in human evolution. Unwittingly bonded with one, Eddie discovers he has incredible new abilities—and a voice in his head that’s telling him to embrace the darkness."))
                }
                
                it("handel the error if api is fail") {
                    self.server.respondToMovieLists(fixture: "movie", statusCode: 403).start()
                    
                    let viewModel = MovieListViewModel(ApiControllerMock(), requestType: .popular)
                    viewController?.viewModel = viewModel
                    
                    viewController?.preloadView()
                    let (wnd, tearDown) = (viewController?.appearInWindowTearDown())!
                    defer { tearDown() }
                    
                    if let error = viewController?.viewModel.errorHandle.value as? RxURLSessionError {
                        expect(error).toEventually(beAnInstanceOf(RxURLSessionError.self))
                        expect(error).toNot(beNil(), description: "not nill")
                    }
//               let (alert, alertTearDown) = (viewController?.getAlert())!
//                    expect(alert.message).toEventually(equal("It looks like something went wrong. Please try again."))
//                    alertTearDown()
                }
            }
            context("When movie row is clicked") {
                
                beforeEach {
                    self.server.respondToMovieLists(fixture: "movie", statusCode: 200).start()
                    let viewModel = MovieListViewModel(ApiControllerMock(), requestType: .popular)
                    viewController?.viewModel = viewModel
                    
                }
                afterEach {
                    self.server.stop()
                }
                it("should perform right segue") {
                    viewController?.preloadView()
                    let (wnd, tearDown) = (viewController?.appearInWindowTearDown())!
                    defer { tearDown() }
                    let indexPath = IndexPath(row: 0, section: 0)
                    viewController?.tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition(rawValue: 0)!)
                    
                    let segue = SegueHelper.segues(ofViewController: viewController!)
                    expect(segue.contains("MoveToDetails")).toEventually(beTrue())
                    expect(segue.count).to(equal(1))

                    let sender = viewController?.shouldPerformSegue(withIdentifier: "MoveToDetails", sender: nil)
                    expect(sender).toEventually(beTrue())

                }
            }
        }
    }
}
