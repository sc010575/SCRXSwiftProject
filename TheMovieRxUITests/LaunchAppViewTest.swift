import Nimble
import Quick

class LaunchAppViewTest: QuickSpec {
    override func spec() {
        describe("MovieListView Test") {
            var app: XCUIApplication?
            var server: MockServer?

            beforeEach {
                self.continueAfterFailure = false
                Nimble.AsyncDefaults.Timeout = 15

                server = MockServer()

                app = XCUIApplication()
                .setUITestLocalServer()
            }
            afterEach {
                app?.terminate()
                server?.stop()
            }
            context("When the user navigates to the app and then to the launch screen") {
                it("displays the launch scene page") {
                    app?.launch()

                    _ = LaunchScaneViewPage(app)
                        .expectOnPage()
                }
            }
            context("when user tap the populate button") {
                it("should display popular movies for successful call") {
                    server?.respondToMovieLists()
                    server?.start()

                    app?.launch()

                    _ = LaunchScaneViewPage(app)
                        .expectOnPage()
                        .tapPopularButton()
                    
                    _ = MovieListPage(app)
                        .expectOnPage()
                }
            }
        }
    }
}
