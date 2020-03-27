//
//  BookListViewModel.swift
//  MVVMSwiftUIDemo
//
//  Created by Guchhait, Saikat on 27/01/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import Foundation
import Combine

struct BookRowViewModel: Identifiable {
    var id: String {
        return bookTitle + bookSubtitle + bookDescription
    }
    
    let bookTitle: String
    let bookSubtitle: String
    let bookDescription: String
    
    init(book: BookResponse.Book) {
        self.bookTitle = book.title
        self.bookSubtitle = book.subTitle
        self.bookDescription = book.description
    }
}

class BookListViewModel: ObservableObject {
    @Published var rowModels = [BookRowViewModel]()
    fileprivate var fetcher: BookFetchable
    private var disposables = Set<AnyCancellable>()
    var errorDescription = ""
    
    init(fetcher: BookFetchable) {
        self.fetcher = fetcher
    }
    
    func fetchBookWith(title: String, errorCompletion:(()-> Void)? = nil ) {
        _ = fetcher.fetchBookWith(title: title)
        .map { response in
            response.books.map(BookRowViewModel.init)
        }
        .sink(receiveCompletion: {[weak self] value in
            guard let strongSelf = self else { return }
            switch value {
            case .failure(let error):
                switch error {
                case .errorInParsing(let descrition):
                    strongSelf.errorDescription = descrition
                case .network(let description):
                    strongSelf.errorDescription = description
                default:
                    strongSelf.errorDescription = "Unknown Error"
                }
                strongSelf.rowModels = []
                errorCompletion?()
            case .finished:
                break
            }
            }, receiveValue: {[weak self] bookRowModels in
                guard let strongSelf = self else { return }
                strongSelf.rowModels = bookRowModels
        })
        .store(in: &disposables)
    }
    
}
