//
//  Coordinator.swift
//  MoviesApp
//
//  Created by    on 30/03/20.
//  Copyright © 2019 Test. All rights reserved.
//

public protocol Coordinator: AnyObject {
    func start()
    var childCoordinators: [Coordinator] { get set }
}
