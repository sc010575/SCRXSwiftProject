import Foundation
import Nimble
import XCTest

class LaunchScaneViewPage {
    var app: XCUIApplication?

    init(_ ourApp: XCUIApplication?) {
        app = ourApp
    }

    func expectOnPage(file: String = #file, line: UInt = #line) -> LaunchScaneViewPage {
        expect(self.app?.staticTexts["The Mobie DB"].exists, file: file, line: line).toEventually(beTrue())
        return self
    }
    
    func tapPopularButton(file: String = #file, line: UInt = #line) -> LaunchScaneViewPage {
        expect(self.app?.buttons["POPULAR"].isHittable).toEventually(beTrue())
        app?.buttons["POPULAR"].tap()
        return self
    }

}

