//
//  BooksControllerTests.swift
//  PersonalLibraryTests
//
//  Created by Noel Perez on 12/8/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import XCTest
@testable import PersonalLibrary

class BooksControllerTests: XCTestCase {

    class BookServiceTest: BooksService {
        override func fetchBooks(completionHandler: @escaping BooksResultCallback) {
            completionHandler(Result.success([Seeds.Books.book1, Seeds.Books.book2, Seeds.Books.book3]))
        }
    }

    var booksController: BooksController!
    let bookService = BookServiceTest()

    override func setUp() {
        super.setUp()

        booksController = BooksController(booksService: bookService)
    }

    override func tearDown() {
        booksController = nil

        super.tearDown()
    }

    func testThatViewModelIsNilBeforeReloadingBooks() {
        XCTAssertNil(booksController.booksViewModel)
    }

    func testThatWhenFetchBooksIsCalledViewModelsNotNil() {
        let theExpectation = expectation(description: "Fetch books")

        booksController.viewModelUpdated = {
            theExpectation.fulfill()
        }

        booksController.fetchBooks()
        waitForExpectations(timeout: 1.0)

        XCTAssertNotNil(self.booksController.booksViewModel)
    }
}
