//
//  BookListView.swift
//  MVVMSwiftUIDemo
//
//  Created by Guchhait, Saikat on 24/01/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import SwiftUI

struct BookListView: View {
    private let activityIndicator: ActivityIndicator
    @ObservedObject var viewModel: BookListViewModel
    @State var showAlert = false
    
    init(viewModel: BookListViewModel) {
        self.viewModel = viewModel
        self.activityIndicator = ActivityIndicator(isAnimating: .constant(true),
                                                   style: .large)
    }
    
    var body: some View {
        VStack {
            if viewModel.rowModels.isEmpty {
                activityIndicator
            } else {
                listView
            }
        }.onAppear {
            self.viewModel.fetchBookWith(title: "quilting") {
                self.showAlert = true
            }
        }.alert(isPresented: $showAlert) { () -> Alert in
            Alert(title: Text("Network"),
                  message: Text(viewModel.errorDescription),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    var listView: some View {
        List {
            bookSections
        }
    }    
    
    var bookSections: some View {
        Section {
            ForEach(viewModel.rowModels, content: BookRowView.init(viewModel:))
        }
    }
    
}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

//struct BookListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookListView(viewModel: <#<<error type>>#>)
//    }
//}
