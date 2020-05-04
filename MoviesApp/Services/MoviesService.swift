//
//  MoviesService.swift
//  MoviesApp
//
//  Created by    on 30/03/20.
//  Copyright © 2019 Test. All rights reserved.
//

protocol MoviesServiceable {
    func getMovies(resultHandler: @escaping ResultHandler<MoviesResponseModel>)
}

class MoviesService: MoviesServiceable {
    private let moviesApi: MoviesAPI
    
    init(moviesApi: MoviesAPI = MoviesAPIV1()) {
        self.moviesApi = moviesApi
    }
    
    func getMovies(resultHandler: @escaping ResultHandler<MoviesResponseModel>) {
        moviesApi.getMovies(resultHandler: resultHandler)
    }
}
