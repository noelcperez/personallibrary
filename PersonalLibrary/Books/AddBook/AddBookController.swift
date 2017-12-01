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
    
    func addBook(name: String, completionHandler: @escaping (String?) -> Void)
}

class AddBookController: AddBookControllerProtocol {
    
    var service: BooksServiceProtocol?
    
    init(service: BooksServiceProtocol) {
        self.service = service
    }
    
    func addBook(name: String, completionHandler: @escaping (String?) -> Void) {
        let book = Book(id: "", name: name)
        self.service?.add(book: book, completionHandler: { (result) in
            switch result{
                case .success(_):
                    completionHandler(nil)
                case .error(let error):
                    completionHandler(error)
            }
            
        })
    }
}
