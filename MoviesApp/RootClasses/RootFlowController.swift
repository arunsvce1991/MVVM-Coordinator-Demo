//
//  RootFlowController.swift
//  MoviesApp
//
//  Created by    on 30/03/20.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class RootFlowController: UIViewController {
    private let router: Routable
    private var currentViewController: UIViewController
    
    var childCoordinators = [Coordinator]()
    
    init(router: Routable = Router()) {
        self.router = router
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        self.currentViewController = storyboard.instantiateViewController(withIdentifier: "LaunchScreen")
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(childController: currentViewController)
    }
    
    private func move(to newViewController: UIViewController) {
        currentViewController.removeFromParent()
        remove(childController: currentViewController)
        add(childController: newViewController)
        currentViewController = newViewController
    }
    
    private func add(childController: UIViewController) {
        DispatchQueue.main.async {
            self.addChild(childController)
            self.view.addSubview(childController.view)
            childController.didMove(toParent: self)
        }
    }
    
    private func remove(childController: UIViewController) {
        DispatchQueue.main.async {
            childController.willMove(toParent: nil)
            childController.view.removeFromSuperview()
            childController.removeFromParent()
        }
    }
}

// MARK: - Coordinator

extension RootFlowController: Coordinator {
    func start() {
        startMoviesListFlow()
    }
    
    private func startMoviesListFlow() {
        let moviesCoordinator = MoviesCoordinator()
        childCoordinators = [moviesCoordinator]
        moviesCoordinator.start()
        move(to: moviesCoordinator.toPresentable())
    }
}

class BaseViewController<V: UIView>: UIViewController {
    public lazy var rootView: V = V()
    
    open override func loadView() {
        view = rootView
    }
}
