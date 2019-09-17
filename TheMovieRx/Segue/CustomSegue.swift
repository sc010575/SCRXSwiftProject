//
//  CustomSegue.swift
//  TheMovieRx
//
//  Created by Suman Chatterjee on 16/12/2018.
//  Copyright © 2018 Suman Chatterjee. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    var animationDuration = 0.8
    
    override func perform() {

        let firstView = self.source.view
        let secondView = self.destination.view

        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height

        guard let secondVCView = secondView, let firstVCView = firstView else { return }
        secondVCView.frame = CGRect(x: 0.0, y: screenHeight, width: screenWidth, height: screenHeight)
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondVCView, aboveSubview: firstVCView)
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            firstVCView.frame = firstVCView.frame.offsetBy(dx: 0, dy: -screenHeight)
            secondVCView.frame = secondVCView.frame.offsetBy(dx: 0, dy: -screenHeight)
        }) { (Finished) in
            self.source.present(self.destination as UIViewController,
                animated: false,
                completion: nil)
        }
    }
}
