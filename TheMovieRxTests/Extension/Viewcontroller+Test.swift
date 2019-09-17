import Nimble
import UIKit
import XCTest

@testable import Pods_TheMovieRx
extension UIViewController {
    func preloadView() {
        _ = view
    }
    
    func appear() {
        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
    
    func appearInWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self
        window.makeKeyAndVisible()
        
        _ = self.view
        expect(self.isViewLoaded).toEventually(beTrue(), pollInterval: 0.3)
        
        return window
    }
    
    @discardableResult
    func appearInWindowTearDown() -> (window: UIWindow, tearDown: () -> ()) {
        let window = appearInWindow()
        
        let tearDown = {
            window.rootViewController = nil
        }
        
        return (window: window, tearDown: tearDown)
    }
    
    func presentInWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let parent = UIViewController()
        window.rootViewController = parent
        window.makeKeyAndVisible()
        parent.present(self, animated: false)
        
        _ = parent.view
        expect(parent.isViewLoaded).toEventually(beTrue(), pollInterval: 0.5)
        
        _ = self.view
        expect(self.isViewLoaded).toEventually(beTrue(), pollInterval: 0.5)
        
        return window
    }
    
    @discardableResult
    func presentInWindowTearDown() -> (window: UIWindow, tearDown: ()->()) {
        let window = presentInWindow()
        
        let tearDown = {
            self.dismiss(animated: false) {
                self.removeFromParent()
                window.rootViewController?.dismiss(animated: false)
                window.rootViewController = nil
            }
        }
        
        return (window, tearDown)
    }
    
    func getAlert(file: String = #file, line: UInt = #line) -> (alert: UIAlertController, tearDown: () -> Void) {
        expect(self.presentedViewController, file: file, line: line).toEventually(beAKindOf(UIAlertController.self))
        
        guard let alertVC = self.presentedViewController as? UIAlertController else {
            fail("Expected alert view controller", file: file, line: line)
            return (UIAlertController(), {})
        }
        
        let alertTearDown = {
            alertVC.dismiss(animated: false, completion: nil)
            alertVC.removeFromParent()
        }
        
        return (alertVC, alertTearDown)
    }

}
