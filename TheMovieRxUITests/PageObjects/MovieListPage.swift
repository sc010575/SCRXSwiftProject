import Foundation
import Nimble
import XCTest

extension XCUIApplication {
    func setUITestLocalServer() -> XCUIApplication {
        launchEnvironment["IsLocalServerBackend"] = "true"
        return self
    }
}

class MovieListPage {
    var app: XCUIApplication?
    
    init(_ ourApp: XCUIApplication?) {
        app = ourApp
    }
    
    func expectOnPage(file: String = #file, line: UInt = #line) -> MovieListPage {
        expect(self.app?.otherElements["Popular"].exists, file: file, line: line).toEventually(beTrue())
        return self
    }
}

