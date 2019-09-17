//
//  Constant.swift
//  TheMovieRx
//
//  Created by Suman Chatterjee on 13/12/2018.
//  Copyright © 2018 Suman Chatterjee. All rights reserved.
//

import Foundation

struct Constant {
    static let apiKey = "449d682523802e0ca4f8b06d8dcf629c"
    static var baseURL: URL? {
        
        if isUITest || isUnitTest {
            return URL(string: "http://localhost:8088")
        }
        
        return URL(string: "https://api.themoviedb.org/3")
    }
    
    static var isUnitTest: Bool {
        #if targetEnvironment(simulator)
        if let _ = NSClassFromString("XCTest") {
            return true
        }
        #endif
        return false
    }
    
    static var isUITest: Bool {
        #if targetEnvironment(simulator)
        if ProcessInfo.processInfo.environment["IsLocalServerBackend"] == "true" {
            return true
        }
        #endif
        return false
    }
    
    static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
}

