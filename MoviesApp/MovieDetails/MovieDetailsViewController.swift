//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by fordlabs on 13/10/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class MovieDetailsViewController: BaseViewController<MovieDetailsView> {
    
    private let viewModel: MovieDetailsViewable
    
    init(viewModel: MovieDetailsViewable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        view.backgroundColor = .white
        rootView.setupView(movieDetail: viewModel.movieDetails)
    }
    
    private func setupNavigationBarStyle() {
        let newImage = UIImage(named: "back")? .imageFlippedForRightToLeftLayoutDirection()
        let backButton = UIBarButtonItem(image: newImage?.withRenderingMode(.alwaysOriginal),
                                         landscapeImagePhone: nil,
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonAction))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        title = viewModel.movieDetails.title
    }
    
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
}
