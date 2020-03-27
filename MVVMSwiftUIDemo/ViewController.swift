//
//  ViewController.swift
//  MVVMSwiftUIDemo
//
//  Created by Guchhait, Saikat on 24/01/20.
//  Copyright © 2020 Guchhait, Saikat. All rights reserved.
//

import UIKit
import SwiftUI

//class ViewController: UIHostingController<BookListView> {

class ViewController: UIViewController {
    @IBOutlet weak var bookConatinerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let listViewModel = BookListViewModel(fetcher: NetworkManager())
        let childView = UIHostingController(rootView: BookListView(viewModel: listViewModel))
        addChild(childView)
        childView.view.frame = bookConatinerView.bounds
        bookConatinerView.addSubview(childView.view)
        childView.didMove(toParent: self)
        
    }
}

