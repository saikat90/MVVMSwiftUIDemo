//
//  BookRowView.swift
//  MVVMSwiftUIDemo
//
//  Created by Guchhait, Saikat on 27/01/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import SwiftUI

//======================================
private let testInput = BookResponse.Book(title: "Quilting Patterns",
                                          subTitle: "110 Ready-to-Use Machine Quilting Designs",
                                          description: "Feathers, pinwheels, flowers, birds, and other eye-catching designs abound in this treasury of more than 100 quilting patterns. Clear, complete directions and numerous diagrams guide even beginners through every step.")

private var books = [BookRowViewModel(book: testInput)]

//======================================

struct BookRowView: View {
    var viewModel: BookRowViewModel
    
    init(viewModel: BookRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text(viewModel.bookTitle).underline()
            Text(viewModel.bookSubtitle).fontWeight(.light)
            Text(viewModel.bookDescription).fontWeight(Font.Weight.medium)
        }
    }
}

struct BookRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookRowView(viewModel: books[0])
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
