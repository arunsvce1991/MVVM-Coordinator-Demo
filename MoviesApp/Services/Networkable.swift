//
//  Networkable.swift
//  MoviesApp
//
//  Created by    on 30/03/20.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

typealias ResultHandler<T> = (Result<T, ServiceError>) -> Void

protocol Networkable: class {
    var session: URLSession { get }
    var endPoint: String { get }
    func makeServiceCall<ResponseModel: Decodable> (_ completion: @escaping ResultHandler<ResponseModel>)
}

extension Networkable {
    
    func makeServiceCall<ResponseModel: Decodable>(_ completion: @escaping ResultHandler<ResponseModel>) {
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.malformedUrl))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                completion(.failure(.connectivityError(error)))
                return
            }
            if let data = data {
                completion(data.decode(to: ResponseModel.self))
            }
            }.resume()
    }
}

extension Data {
    func decode<T: Decodable>(to type: T.Type) -> Result<T, ServiceError> {
        let decoder = JSONDecoder()
        do {
            let decodedModel = try decoder.decode(T.self, from: self)
            return .success(decodedModel)
        } catch {
            return .failure(ServiceError.invalidBody)
        }
    }
}

enum ServiceError: Error {
    case connectivityError(Error)
    case invalidBody
    case malformedUrl
}
