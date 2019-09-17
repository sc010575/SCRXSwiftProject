import Nimble
import Quick
@testable import TheMovieRx

final class SegueHelper {

    static func segues(ofViewController viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?.compactMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
}


final class LoginViewControllerTest: QuickSpec {

    override func spec() {
        describe("LoginViewController tests") {
            var viewController: LaunchScaneViewController?
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            beforeEach {
                viewController = storyboard.instantiateViewController(withIdentifier: "LaunchScaneViewController") as? LaunchScaneViewController
                _ = viewController?.view
            }
            context("When LaunchScaneViewController is created ") {
                it("set the appropiate movie query type for the buttons") {
                    expect(viewController?.popularButton!.queryType).to(equal(.popular))
                    expect(viewController?.topRatedButton!.queryType).to(equal(.topRated))
                    expect(viewController?.upCommingButton!.queryType).to(equal(.upcoming))
                }
            }
            context("When popular button tapped") {
                it("should perform button tap action with popular movie request type") {
                    viewController?.popularButton.sendActions(for: .touchUpInside)
                    let segue = SegueHelper.segues(ofViewController: viewController!)
                    expect(segue.contains("MoveToMovieList")).toEventually(beTrue())
                    expect(segue.count).to(equal(1))
                    let sender = viewController?.shouldPerformSegue(withIdentifier: "MoveToMovieList", sender: MovieQueryType.popular)
                    expect(sender).toEventually(beTrue())
                }
            }
        }
    }
}

