//
//  MoviesListViewModelTests.swift
//  MoviesAppTests
//
//  Created by    on 13/10/19.
//  Copyright © 2019 Test. All rights reserved.
//

import XCTest

@testable import MoviesApp

class MoviesListViewModelTests: XCTestCase {
    var subject: MoviesListViewModel!
    let moviesServiceMock = MoviesServiceMock()
    
    override func setUp() {
        subject = MoviesListViewModel(moviesService: moviesServiceMock)
    }
    
    func testGetMoviesCompletesWithSuccessFlow() {
        let expectation = XCTestExpectation()
        moviesServiceMock.issuccessFlow = true

        subject.fetchMoviesList(successCompletion: {
            let moviesDetails = self.subject.movies[0]
            XCTAssertEqual(self.subject.movies.count, self.moviesServiceMock.moviesResponseModel.movies.count)
            XCTAssertEqual(moviesDetails.title, self.moviesServiceMock.moviesDetails.title)
            XCTAssertEqual(moviesDetails.rated, self.moviesServiceMock.moviesDetails.rated)
            XCTAssertEqual(moviesDetails.year, self.moviesServiceMock.moviesDetails.year)
            XCTAssertEqual(moviesDetails.released, self.moviesServiceMock.moviesDetails.released)
            expectation.fulfill()
        }, failureCompletion: { _ in
            XCTAssert(false)
        })
        
        XCTAssert(moviesServiceMock.isGetMoviesCalled)
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetMoviesCompletesWithFailureFlow() {
        let expectation = XCTestExpectation()
        moviesServiceMock.issuccessFlow = false
        subject.fetchMoviesList(successCompletion: { XCTAssert(false) },
                                failureCompletion: {
                                    XCTAssertEqual($0, ServiceError.malformedUrl)
                                    expectation.fulfill()
        })
        
        XCTAssert(moviesServiceMock.isGetMoviesCalled)
        wait(for: [expectation], timeout: 0.01)
    }
    
    override  func tearDown() {
        moviesServiceMock.isGetMoviesCalled = false
    }
}

class MoviesServiceMock: MoviesServiceable {
   
    var isGetMoviesCalled = false
    var moviesResponseModel: MoviesResponseModel!
    var moviesDetails: MoviesDetails!
    var issuccessFlow = true
    func getMovies(resultHandler: @escaping ResultHandler<MoviesResponseModel>) {
        self.isGetMoviesCalled = true
        moviesDetails = MoviesDetails(title: "title", year: "year", rated: "rated",
                                      released: "released", runtime: "runtime", genre: "",
                                      director: "", writer: "", actors: "", plot: "",
                                      language: "", country: "", awards: "", poster1: "",
                                      poster2: "", ratings: "", metascore: "",
                                      imdbRating: "", imdbVotes: "", imdbID: "",
                                      type: "", dvd: "", boxOffice: "", production: "",
                                      website: "")
        moviesResponseModel = MoviesResponseModel(movies: [moviesDetails])
        
        if issuccessFlow {
            resultHandler(.success(moviesResponseModel))
        } else {
            resultHandler(.failure(.malformedUrl))
        }
    }
}
