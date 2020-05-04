//
//  MoviesCoordinatorTests.swift
//  MoviesAppTests
//
//  Created by Arun Pradeep on 3/31/20.
//  Copyright © 2020 Test. All rights reserved.
//

import XCTest

@testable import MoviesApp

class MoviesCoordinatorTests: XCTestCase {
    var subject: MoviesCoordinator!
    var router: Routable!
    var receivedMovieDetails: MoviesDetails?

    override func setUp() {
        router = Router()
        let moviesListViewModelBuilder: MoviesListViewModelBuilder = { MockMoviesListViewModel() }
        let MovieDetailsViewModelBuilder: MovieDetailsViewModelBuilder = {(movieDetails) in
            self.receivedMovieDetails = movieDetails
            return MovieDetailsViewModel(movieDetails: movieDetails)
        }
        
        subject = MoviesCoordinator(router: router,
                                    moviesListViewModelBuilder: moviesListViewModelBuilder,
                                    movieDetailsViewModelBuilder: MovieDetailsViewModelBuilder)
    }
    
    func testShowMoviesListFlow() {
        subject.start()
        XCTAssertTrue(router.navigationController.topViewController!.isKind(of: MoviesListViewController.self))
    }
    
    func testShowMovieDetailsFlow() {
        let movieDetails = MoviesDetails(title: "movie title", year: "year", rated: "rated",
                                         released: "released", runtime: "runtime", genre: "",
                                         director: "", writer: "", actors: "", plot: "",
                                         language: "", country: "", awards: "", poster1: "",
                                         poster2: "", ratings: "", metascore: "",
                                         imdbRating: "", imdbVotes: "", imdbID: "",
                                         type: "", dvd: "", boxOffice: "", production: "",
                                         website: "")
        subject.navigateToMovieDetails(with: movieDetails)
        XCTAssertTrue(router.navigationController.topViewController!.isKind(of: MovieDetailsViewController.self))
        XCTAssertEqual(movieDetails.title, receivedMovieDetails?.title)
        XCTAssertEqual(movieDetails.year, receivedMovieDetails?.year)
        XCTAssertEqual(movieDetails.released, receivedMovieDetails?.released)
        XCTAssertEqual(movieDetails.runtime, receivedMovieDetails?.runtime)
    }
    
    override func tearDown() {
        router = nil
    }
}

class MockMoviesListViewModel: MoviesListViewable {
    var cache = NSCache<AnyObject, AnyObject>()

    func fetchMoviesList(successCompletion: @escaping SuccessHandler,
                         failureCompletion: @escaping FailureHandler) {
        
    }
    
    var movies: [MoviesDetails] = []
}
