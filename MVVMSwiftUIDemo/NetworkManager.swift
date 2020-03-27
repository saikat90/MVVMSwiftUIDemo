//
//  NetworkManager.swift
//  MVVMSwiftUIDemo
//
//  Created by Guchhait, Saikat on 28/01/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation
import Combine

protocol BookFetchable {
    func fetchBookWith(title: String) -> AnyPublisher<BookResponse, NetworkError>
}


struct NetworkManager {
    let urlSession: URLSession
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        urlSession = URLSession(configuration: configuration)
    }
    
    fileprivate func fetch<T>(request: URLComponents) -> AnyPublisher<T, NetworkError> where T: Decodable {
        guard let url = request.url else {
            return Fail(error: .badRequest).eraseToAnyPublisher()
        }
        return urlSession.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}


extension NetworkManager: BookFetchable {
    
    func fetchBookWith(title: String) -> AnyPublisher<BookResponse, NetworkError> {
        return fetch(request: makeBookRequest(with: title))
    }
    
}


// MARK: - OpenWeatherMap API
private extension NetworkManager {
  struct BookAPI {
    static let scheme = "https"
    static let host = "www.googleapis.com"
    static let path = "/books/v1/volumes"
  }
  
  func makeBookRequest(
    with title: String
  ) -> URLComponents {
    var components = URLComponents()
    components.scheme = BookAPI.scheme
    components.host = BookAPI.host
    components.path = BookAPI.path
    
    components.queryItems = [
      URLQueryItem(name: "q", value: title)
    ]
    
    return components
  }
}
