//
//  NetworkableTests.swift
//  MoviesAppTests
//
//  Created by    on 13/10/19.
//  Copyright © 2019 Test. All rights reserved.
//

import XCTest

@testable import MoviesApp

class NetworkableTests: XCTestCase {
    
    var subject: MoviesAPIV1!
    var urlSession: MockURLSession!
    
    override func setUp() {
        urlSession = MockURLSession()
        subject = MoviesAPIV1(session: urlSession)
    }
    
    func test_whenURLSessionReturnsError_shouldReturnTheRespectiveError() {
        let expectation = XCTestExpectation()
        subject.makeServiceCall() { (result: Result<MoviesResponseModel, ServiceError>) in
            XCTAssert(self.urlSession.isDataTaskCalled ?? false)
            XCTAssertEqual(self.subject.endPoint, self.urlSession.requestURL)
            XCTAssertEqual(result.error, .connectivityError(TestError.simpleError))
            expectation.fulfill()
        }
        
        urlSession.dataTaskCompletion?(nil, nil, TestError.simpleError)
        wait(for: [expectation], timeout: 0.01)
    }
    
    func test_whenDataIsReceived_ShouldReturnResponseModel() {
        let expectation = XCTestExpectation()
        subject.makeServiceCall() { (result: Result<MoviesResponseModel, ServiceError>) in
            XCTAssert(self.urlSession.isDataTaskCalled ?? false)
            XCTAssertEqual(self.subject.endPoint, self.urlSession.requestURL)
            XCTAssertNil(result.error)
            XCTAssertNotNil(result.value)
            XCTAssertEqual(result.value?.movies.first?.title, "test title")
            expectation.fulfill()
        }
        
        let moviesDetails = MoviesDetails(title: "test title", year: "year", rated: "rated",
                                      released: "released", runtime: "runtime", genre: "",
                                      director: "", writer: "", actors: "", plot: "",
                                      language: "", country: "", awards: "", poster1: "",
                                      poster2: "", ratings: "", metascore: "",
                                      imdbRating: "", imdbVotes: "", imdbID: "",
                                      type: "", dvd: "", boxOffice: "", production: "",
                                      website: "")
        let moviesResponseModel = MoviesResponseModel(movies: [moviesDetails])
        
        urlSession.dataTaskCompletion?(moviesResponseModel.encode().value, HTTPURLResponse(), nil)
        wait(for: [expectation], timeout: 0.01)
    }
}

class MockURLSession: URLSession {
    var requestURL: String?
    var dataTaskCompletion: ((Data?, URLResponse?, Error?) -> Void)?
    var isDataTaskCalled: Bool?
    
    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        isDataTaskCalled = true
        requestURL = request.url?.absoluteURL.absoluteString
        
        dataTaskCompletion = completionHandler
        return MockURLSessionDataTask()
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {
    }
}

extension ServiceError: Equatable {
    public static func == (lhs: ServiceError, rhs: ServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.malformedUrl, .malformedUrl): return true
        case (.connectivityError, .connectivityError): return true
        case (.invalidBody, .invalidBody): return true
        default: return false
        }
    }
}

enum TestError: Error {
    case simpleError
}

extension Result {
    var value: Success? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    var error: Failure? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

extension Encodable {
    func encode() -> Result<Data, ServiceError> {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        do {
            let data = try encoder.encode(self)
            return .success(data)
        } catch {
            return .failure(ServiceError.invalidBody)
        }
    }
}
