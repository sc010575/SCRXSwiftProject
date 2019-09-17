//
//  MovieModelTest.swift
//  TheMovieRxTests
//
//  Created by Suman Chatterjee on 07/12/2018.
//  Copyright © 2018 Suman Chatterjee. All rights reserved.
//

import XCTest
@testable import TheMovieRx

class MovieModelTest: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testMovieModel() {
        let dataResult = Fixtures.getJSONData(jsonPath: "movie")
        let movie: Movie = ParseJson.parse(data: dataResult!) ?? Movie.emptyMovie
        XCTAssertEqual(movie.results[0].title, "Venom")

    }
}
