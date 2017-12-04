//
//  BooksController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol BooksControllerProtocol: class, ViewModelUpdateProtocol {
    var booksService: BooksServiceProtocol { get }
    var booksViewModel: [BookViewModel]? { get }
    
    func fetchBooks()
    func bookId(forViewModelIndex index: Int) -> String
    func deleteBook(forViewModelIndex index: Int, completionHandler: @escaping (String?) -> Void)
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
    
    //MARK: - BooksController Protocol implementation
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
    
    func deleteBook(forViewModelIndex index: Int, completionHandler: @escaping (String?) -> Void){
        let book = self.books[index]
        self.booksService.remove(book: book) { [unowned self] (result) in
            switch result{
                case .success(_):
                    self.fetchBooks()
                    completionHandler(nil)
                case .error(let error):
                    completionHandler(error)
            }
        }
    }
    
    func bookId(forViewModelIndex index: Int) -> String{
        return self.books[index].id
    }
}
