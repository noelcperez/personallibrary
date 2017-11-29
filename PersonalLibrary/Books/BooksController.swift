//
//  BooksController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol ViewModelUpdateProtocol {
    var viewModelUpdated: (() -> Void)? { set get }
}

protocol BooksControllerProtocol: class, ViewModelUpdateProtocol {
    var booksService: BooksServiceProtocol { get }
    var booksViewModel: [BookViewModel]? { get }
    
    func fetchBooks()
    func editBook(index: Int)
}

class BooksController: NSObject, BooksControllerProtocol {
    var viewModelUpdated: (() -> Void)?
    
    private var books = [Book](){
        didSet{
            self.booksViewModel = books.map{ BookViewModel(name: $0.name) }
        }
    }
    
    private(set) var booksService: BooksServiceProtocol
    private(set) var booksViewModel: [BookViewModel]?{
        didSet{
            viewModelUpdated?()
        }
    }
    
    init(booksService: BooksServiceProtocol) {
        self.booksService = booksService
    }
    
    func fetchBooks() {
        self.booksService.fetchBooks { [unowned self] (result) in
            switch result{
                case .success(let books):
                    self.books = books
                default:
                    //Show error
                    break
            }
        }
    }
    
    func editBook(index: Int) {
        let selectedBook = self.books[index]
        self.booksService.edit(book: selectedBook) { (result) in
            switch result{
                case .success(let _):
                    break
                default:
                    break
            }
        }
    }
    
}
