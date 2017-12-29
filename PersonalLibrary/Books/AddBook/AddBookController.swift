//
//  AddBookController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 12/1/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol AddBookControllerProtocol {
    var service: BooksServiceProtocol? { get }
    var selectedAuthor: Author! { get set }

    func addBook(name: String, completionHandler: @escaping (String?) -> Void)
}

class AddBookController: AddBookControllerProtocol {

    var service: BooksServiceProtocol?
    var selectedAuthor: Author!

    init(service: BooksServiceProtocol) {
        self.service = service
    }

    func addBook(name: String, completionHandler: @escaping (String?) -> Void) {
        let book = Book(id: "", name: name, authorId: self.selectedAuthor.id)
        self.service?.add(book: book, completionHandler: { (result) in
            switch result {
            case .success:
                completionHandler(nil)
            case .error(let error):
                completionHandler(error)
            }

        })
    }
}
