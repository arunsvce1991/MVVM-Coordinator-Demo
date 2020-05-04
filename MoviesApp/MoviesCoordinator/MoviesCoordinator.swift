//
//  MoviesCoordinator.swift
//  MoviesApp
//
//  Created by    on 30/03/20.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesFlowDelegate: AnyObject {
    func navigateToMovieDetails(with movieDetails: MoviesDetails)
}

typealias MoviesListViewModelBuilder = () -> MoviesListViewable
typealias MovieDetailsViewModelBuilder = (MoviesDetails) -> MovieDetailsViewable

class MoviesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let router: Routable
    private let moviesListViewModelBuilder: MoviesListViewModelBuilder
    private let movieDetailsViewModelBuilder: MovieDetailsViewModelBuilder

    init(router: Routable = Router(),
         moviesListViewModelBuilder: @escaping MoviesListViewModelBuilder = { MoviesListViewModel() },
        movieDetailsViewModelBuilder: @escaping MovieDetailsViewModelBuilder = { MovieDetailsViewModel(movieDetails: $0) }) {
        self.router = router
        self.moviesListViewModelBuilder = moviesListViewModelBuilder
        self.movieDetailsViewModelBuilder = movieDetailsViewModelBuilder
    }
    
    func start() {
        showMoviesList()
    }
    
    func toPresentable() -> UIViewController {
        return router.navigationController
    }
    
    func showMoviesList() {
        let viewModel = moviesListViewModelBuilder()
        let viewController = MoviesListViewController(viewModel: viewModel)
        viewController.delegate = self
        router.setRootModule(viewController, animated: false)
    }
}

extension MoviesCoordinator: MoviesFlowDelegate {
    func navigateToMovieDetails(with movieDetails: MoviesDetails) {
        let viewModel = movieDetailsViewModelBuilder(movieDetails)
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        router.push(viewController, animated: true)
    }
}
