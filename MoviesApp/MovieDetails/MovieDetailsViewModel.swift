//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by fordlabs on 13/10/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import MoviesService
import MoviesDataModel

protocol MovieDetailsViewable {
    var movieDetails: MoviesDetails { get }
}

class MovieDetailsViewModel: MovieDetailsViewable {
    
    let movieDetails: MoviesDetails
    
    init(movieDetails: MoviesDetails) {
        self.movieDetails = movieDetails
    }
}
