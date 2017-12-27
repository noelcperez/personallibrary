//
//  Seeds.swift
//  PersonalLibraryTests
//
//  Created by Noel Perez on 12/8/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

@testable import PersonalLibrary

struct Seeds {
    struct Books {
        static let book1 = Book(id: "1", name: "Book 1", authorId: "1")
        static let book2 = Book(id: "2", name: "Book 2", authorId: "2")
        static let book3 = Book(id: "3", name: "Book 3", authorId: "3")
    }
}
