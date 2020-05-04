//
//  MoviesAPI.swift
//  MoviesApp
//
//  Created by    on 30/03/20.
//  Copyright © 2019 Test. All rights reserved.
// "https://api.myjson.com/bins/18buhu"

import Foundation

protocol MoviesAPI: Networkable {
    func getMovies(resultHandler: @escaping ResultHandler<MoviesResponseModel>)
}

class MoviesAPIV1: MoviesAPI {
    
    let session: URLSession
    let endPoint: String
    
    init(session: URLSession,
         endPoint: String) {
        self.session = session
        self.endPoint = endPoint
    }
    
    convenience init(session: URLSession = URLSession(configuration:
        URLSessionConfiguration.default)) {
        self.init(session: session, endPoint: "https://api.jsonbin.io/b/5e86bb0ef4dba3539aac2f2a")
    }
    
    func getMovies(resultHandler: @escaping ResultHandler<MoviesResponseModel>) {
        makeServiceCall(resultHandler)
    }
}
