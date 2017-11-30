//
//  BookDetailsController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/30/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol BookDetailsControllerProtocol: class, ViewModelUpdateProtocol {
    var booksService: BooksServiceProtocol { get }
    var bookViewModel: BookViewModel? { get }
    
    func fetch()
    func editBook(bookName: String)
    func remove()
}

class BookDetailsController: BookDetailsControllerProtocol {
    
    var viewModelUpdated: (() -> Void)?
    
    var booksService: BooksServiceProtocol
    var bookViewModel: BookViewModel?{
        didSet{
            viewModelUpdated?()
        }
    }
    
    private var bookId: String
    private var book: Book?{
        didSet{
            if let the_book = book{
                self.bookViewModel = BookViewModel(name: the_book.name)
            }
        }
    }
    
    init(booksService: BooksServiceProtocol, bookId: String) {
        self.booksService = booksService
        self.bookId = bookId
    }
    
    func fetch() {
        self.booksService.fetchBook(id: self.bookId) { [unowned self] (result) in
            switch result{
                case .success(let book):
                    self.book = book
                case .error(_):
                    //Show error
                    break
            }
        }
    }
    
    func editBook(bookName: String) {
        
    }
    
    func remove() {
        
    }
}
