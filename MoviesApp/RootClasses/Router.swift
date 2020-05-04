//
//  Router.swift
//  MoviesApp
//
//  Created by    on 30/03/20.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

protocol Routable: AnyObject {
    var navigationController: UINavigationController { get }
    func push(_ controller: UIViewController, animated: Bool)
    func setRootModule(_ controller: UIViewController, animated: Bool)
}

class Router: NSObject, Routable {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        super.init()
    }
    
    func push(_ controller: UIViewController, animated: Bool) {
        navigationController.pushViewController(controller, animated: animated)
    }
    
    open func setRootModule(_ module: UIViewController, animated: Bool) {
        navigationController.setViewControllers([module], animated: animated)
    }
}
