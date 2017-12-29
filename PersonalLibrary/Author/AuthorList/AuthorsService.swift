//
//  AuthorsService.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit
import Firebase

typealias AuthorsResultCallback = (Result<[Author]>) -> Void
typealias OneAuthorResultCallback = (Result<Author>) -> Void

protocol AuthorsServiceProtocol {
    func fetchAuthors(completionHandler: @escaping AuthorsResultCallback)
    func edit(author: Author, completionHandler: @escaping OneAuthorResultCallback)
    func fetchOneAuthor(id: String, completionHandler: @escaping OneAuthorResultCallback)
    func add(author: Author, completionHandler: @escaping OneAuthorResultCallback)
    func remove(author: Author, completionHandler: @escaping OneAuthorResultCallback)
}

class AuthorsService: AuthorsServiceProtocol {

    fileprivate lazy var authorDatabaseReference = Database.database().reference().child("authors")

    func fetchAuthors(completionHandler: @escaping AuthorsResultCallback) {
        self.authorDatabaseReference.observeSingleEvent(of: .value, with: { (dataSnapshot) in
            completionHandler(Result.success(self.processAuthors(dataSnapshot: dataSnapshot)))
        })
    }

    func fetchOneAuthor(id: String, completionHandler: @escaping OneAuthorResultCallback) {
        self.authorDatabaseReference.child(id).observeSingleEvent(of: .value, with: { (dataSnapshot) in
            if let the_author = self.processOneAuthor(dataSnapshot: dataSnapshot) {
                completionHandler(Result.success(the_author))
            }
        })
    }

    func add(author: Author, completionHandler: @escaping OneAuthorResultCallback) {
        do {
            let dict = try self.encode(author: author)
            self.authorDatabaseReference.childByAutoId().setValue(dict)
            completionHandler(Result.success(author))
        } catch let error {
            completionHandler(Result.error(error.localizedDescription))
        }
    }

    func edit(author: Author, completionHandler: @escaping OneAuthorResultCallback) {

    }

    func remove(author: Author, completionHandler: @escaping OneAuthorResultCallback) {
        self.authorDatabaseReference.child(author.id).removeValue()
        completionHandler(Result.success(author))
    }

    fileprivate func processAuthors(dataSnapshot: DataSnapshot) -> [Author] {
        var authors = [Author]()

        if dataSnapshot.hasChildren(), let authors_dict = dataSnapshot.value as? [String: NSDictionary] {
            for (authorKey, authorValue) in authors_dict {
                authors.append(self.decode(authorDictionary: authorValue, authorKey: authorKey))
            }
        }

        return authors
    }

    fileprivate func processOneAuthor(dataSnapshot: DataSnapshot) -> Author? {
        var author: Author? = nil
        if dataSnapshot.hasChildren(), let author_dict = dataSnapshot.value as? NSDictionary {
            author = self.decode(authorDictionary: author_dict, authorKey: dataSnapshot.key)
        }

        return author
    }

    // MARK: Utility functions
    fileprivate func encode(author: Author) throws -> Any {
        let encoder = JSONEncoder()
        let data = try encoder.encode(author)
        return try JSONSerialization.jsonObject(with: data, options: [])
    }

    fileprivate func decode(authorDictionary: NSDictionary, authorKey: String) -> Author {
        var authorToReturn: Author!

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let data = try JSONSerialization.data(withJSONObject: authorDictionary, options: [])
            authorToReturn = try decoder.decode(Author.self, from: data)
            authorToReturn.id = authorKey
        } catch { }

        return authorToReturn
    }
}
