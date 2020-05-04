//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by    on 30/03/20.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class MoviesListViewController: BaseViewController<MoviesListView> {
    
    private let viewModel: MoviesListViewable
    weak var delegate: MoviesFlowDelegate?

    init(viewModel: MoviesListViewable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        view.backgroundColor = .white
        fetchMoviesList()
    }
    
    private func setupNavigationBarStyle() {
        guard let navigationController = navigationController else { return }
        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.navigationBar.shadowImage = UIImage()

        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30),
             NSAttributedString.Key.foregroundColor:  UIColor.black]
        
        navigationController.navigationBar.layoutMargins.left = 25
        navigationController.navigationBar.barTintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        title = "Movies"
    }
    
    private func fetchMoviesList() {
        rootView.startLoading()
        viewModel.fetchMoviesList(successCompletion: { [weak self] in
            DispatchQueue.main.async {
                self?.rootView.stopLoading()
                self?.rootView.tableView.isHidden = false
                self?.rootView.tableView.reloadData()
            }
            }, failureCompletion: { [weak self] (error) in
                DispatchQueue.main.async {
                    self?.rootView.stopLoading()
                    self?.rootView.tableView.isHidden = true
                    self?.showAlert(with: error.localizedDescription)
                }
        })
    }
    
    private func showAlert(with message: String) {
        let alertController = UIAlertController(title: "Movies List",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        present(alertController, animated: true, completion: nil)
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:
            MoviesTableViewCell.self),
                                                       for: indexPath) as? MoviesTableViewCell
            else { return UITableViewCell() }
        
        let movieDetail = viewModel.movies[indexPath.row]
        cell.prepareCell(with: movieDetail.title)
        
        guard let posterLink = movieDetail.poster else { return cell }
        
        if let cachedImage = viewModel.cache.object(forKey: posterLink as AnyObject) {
            cell.updatePoster(with: cachedImage as? UIImage)
        }else {
            DispatchQueue.global().async { [weak self] in
                guard let url = URL(string: posterLink),
                    let data = NSData(contentsOf: url) else { return }
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data as Data) else { return }
                    cell.updatePoster(with: image)
                    self?.viewModel.cache.setObject(image, forKey: posterLink as AnyObject)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetail = viewModel.movies[indexPath.row]
        delegate?.navigateToMovieDetails(with: movieDetail)
    }
}
