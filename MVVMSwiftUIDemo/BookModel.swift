//
//  BookModel.swift
//  MVVMSwiftUIDemo
//
//  Created by Guchhait, Saikat on 27/01/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation

struct BookResponse: Decodable {
    struct Book: Decodable {
        let title: String
        let subTitle: String
        let description: String
        
        private enum CodingKeys: String, CodingKey {
            case volumeInfo = "volumeInfo"
            case title
            case subTitle = "subtitle"
            case description
        }
        
    }
    let books: [Book]
    
    private enum CodingKeys: String, CodingKey {
        case books = "items"
    }
}


extension BookResponse.Book {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let volumeInfo = try container.nestedContainer(keyedBy: CodingKeys.self,
                                                       forKey: .volumeInfo)
        title = try volumeInfo.decode(String?.self, forKey: .title) ?? "NA"
        do {
          subTitle = try volumeInfo.decode(String?.self, forKey: .subTitle) ?? "No Subtitle"
        } catch {
          subTitle = "No Subtitle"
        }
        do {
            description = try volumeInfo.decode(String?.self,
                                                 forKey: .description) ?? "No Description Available"
        } catch {
            description = "No Description Available"
        }
    }
}
