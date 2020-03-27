//
//  Parser.swift
//  MVVMSwiftUIDemo
//
//  Created by Guchhait, Saikat on 03/02/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badRequest
    case errorInParsing(description: String)
    case network(description: String)
}

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, NetworkError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .errorInParsing(description: error.localizedDescription)
    }.eraseToAnyPublisher()
}

