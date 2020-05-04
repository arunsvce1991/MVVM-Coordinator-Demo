//
//  MoviesServiceTests.swift
//  MoviesAppTests
//
//  Created by    on 13/10/19.
//  Copyright © 2019 Test. All rights reserved.
//

import XCTest

@testable import MoviesApp

class MoviesServiceTests: XCTestCase {
    var subject: MoviesService!
    let moviesAPIMock = MoviesAPIMock()
    
    override func setUp() {
        subject = MoviesService(moviesApi: moviesAPIMock)
    }
    
    func testGetMovies() {
        let expectation = XCTestExpectation()
        subject.getMovies {
            let moviesDetails = $0.value?.movies[0]
            XCTAssertEqual($0.value?.movies.count, self.moviesAPIMock.moviesResponseModel.movies.count)
            XCTAssertEqual(moviesDetails?.title, self.moviesAPIMock.moviesDetails.title)
            XCTAssertEqual(moviesDetails?.rated, self.moviesAPIMock.moviesDetails.rated)
            XCTAssertEqual(moviesDetails?.year, self.moviesAPIMock.moviesDetails.year)
            XCTAssertEqual(moviesDetails?.released, self.moviesAPIMock.moviesDetails.released)
            expectation.fulfill()
        }
        XCTAssert(moviesAPIMock.isServiceCalled)
        wait(for: [expectation], timeout: 0.01)
    }
}

class MoviesAPIMock: MoviesAPI {
    var session = URLSession.shared
    var endPoint = "www.mockUrl.com"
    
    var isServiceCalled = false
    var moviesResponseModel: MoviesResponseModel!
    var moviesDetails: MoviesDetails!
    
    func getMovies(resultHandler: @escaping ResultHandler<MoviesResponseModel>) {
        self.isServiceCalled = true
        moviesDetails = MoviesDetails(title: "title", year: "year", rated: "rated",
                                          released: "released", runtime: "runtime", genre: "",
                                          director: "", writer: "", actors: "", plot: "",
                                          language: "", country: "", awards: "", poster1: "",
                                          poster2: "", ratings: "", metascore: "",
                                          imdbRating: "", imdbVotes: "", imdbID: "",
                                          type: "", dvd: "", boxOffice: "", production: "",
                                          website: "")
        moviesResponseModel = MoviesResponseModel(movies: [moviesDetails])
        resultHandler(.success(moviesResponseModel))
    }
}
