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
    var authorsService: AuthorsServiceProtocol { get }
    var bookViewModel: BookViewModel? { get }

    func fetch()
    func editBook(bookName: String)
    func remove()
}

class BookDetailsController: BookDetailsControllerProtocol {

    var viewModelUpdated: (() -> Void)?

    var booksService: BooksServiceProtocol
    var authorsService: AuthorsServiceProtocol
    var bookViewModel: BookViewModel? {
        didSet {
            viewModelUpdated?()
        }
    }

    private var bookId: String
    private var book: Book?
    private var author: Author? {
        didSet {
            if let the_book = book, let the_author = author {
                self.bookViewModel = BookViewModel(name: the_book.name, authorName: the_author.name)
            }
        }
    }

    init(booksService: BooksServiceProtocol, authorsService: AuthorsServiceProtocol, bookId: String) {
        self.booksService = booksService
        self.bookId = bookId
        self.authorsService = authorsService
    }

    func fetch() {
        self.booksService.fetchOneBook(id: self.bookId) { [unowned self] (result) in
            switch result {
            case .success(let book):
                self.book = book
                self.fetchAuthor()
            case .error:
                //Show error
                break
            }
        }
    }

    fileprivate func fetchAuthor() {
        guard let the_book = self.book else {
            return
        }
        self.authorsService.fetchOneAuthor(id: the_book.authorId) {[unowned self] (result) in
            switch result {
            case .success(let author):
                self.author = author
            case .error:
                break
            }
        }
    }

    func editBook(bookName: String) {

    }

    func remove() {

    }
}
