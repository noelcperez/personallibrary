//
//  BooksViewControllerTests.swift
//  PersonalLibraryTests
//
//  Created by Noel Perez on 12/8/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import XCTest
@testable import PersonalLibrary

class BooksViewControllerTests: XCTestCase {

    var bookViewController: BooksViewController!
    var bookControllerTest = BookControllerTest(booksService: BookServiceTest())

    override func setUp() {
        super.setUp()

        bookViewController = BooksViewController()
        bookViewController.booksController = bookControllerTest
    }

    override func tearDown() {
        bookViewController = nil

        super.tearDown()
    }

    class BookControllerTest: BooksController {
        var fetchBookCalled = false

        override func fetchBooks() {
            self.booksService.fetchBooks { (_) in
                self.fetchBookCalled = true
            }
        }
    }

    class BookServiceTest: BooksService {
        override func fetchBooks(completionHandler: @escaping BooksResultCallback) {
            completionHandler(Result.success([Seeds.Books.book1, Seeds.Books.book2, Seeds.Books.book3]))
        }
    }

    func testBooksViewControllerViewWillAppearCallFetchBook() {
        bookViewController.viewWillAppear(true)

        XCTAssertNotNil(bookControllerTest.fetchBookCalled)
    }
}
