//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by    on 30/03/20.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import MoviesService
import MoviesDataModel

typealias SuccessHandler = () -> Void
typealias FailureHandler = (ServiceError) -> Void

protocol MoviesListViewable {
    func fetchMoviesList(successCompletion: @escaping SuccessHandler, failureCompletion: @escaping FailureHandler)
    var movies: [MoviesDetails] { get }
    var cache: NSCache<AnyObject, AnyObject> { get set }
}

class MoviesListViewModel: MoviesListViewable {
   
    var movies: [MoviesDetails] = []
    var cache = NSCache<AnyObject, AnyObject>()

    private let moviesService: MoviesServiceable
    
    init(moviesService: MoviesServiceable = MoviesService()) {
        self.moviesService = moviesService
    }
    
    func fetchMoviesList(successCompletion: @escaping SuccessHandler, failureCompletion: @escaping FailureHandler) {
        moviesService.getMovies { [weak self] in
                switch $0 {
                case let .success(value):
                    self?.movies = value.movies
                    successCompletion()
                    return
                case let .failure(error):
                    failureCompletion(error)
                    return
                }
        }
    }
}
