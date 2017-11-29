//
//  BooksService.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

typealias BooksResultCallback = (Result<[Book]>) -> Void
typealias BookResultCallback = (Result<Book>) -> Void

protocol BooksServiceProtocol {
    func fetchBooks(completionHandler: BooksResultCallback)
    func edit(book: Book, completionHandler: BookResultCallback)
}

class BooksService: BooksServiceProtocol {
    
    fileprivate var memoryBooks: [Book] = {
       let book1 = Book(id: "1", name: "Book 1")
       let book2 = Book(id: "2", name: "Book 2")
       let book3 = Book(id: "3", name: "Book 3")
        
        return [book1, book2, book3]
    }()
    
    func fetchBooks(completionHandler: (Result<[Book]>) -> Void) {
        completionHandler(Result.success(self.memoryBooks))
    }
    
    func edit(book: Book, completionHandler: (Result<Book>) -> Void) {
        if let bookIndex = self.memoryBooks.index(where: { (_book) -> Bool in
            return _book.id == book.id
        }){
            self.memoryBooks.insert(book, at: bookIndex)
            completionHandler(Result.success(book))
        }
        else{
            completionHandler(Result.error("Not found"))
        }
    }
}
