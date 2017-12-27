//
//  BooksService.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit
import Firebase

typealias BooksResultCallback = (Result<[Book]>) -> Void
typealias OneBookResultCallback = (Result<Book>) -> Void

protocol BooksServiceProtocol {
    func fetchBooks(completionHandler: @escaping BooksResultCallback)
    func edit(book: Book, completionHandler: @escaping OneBookResultCallback)
    func fetchOneBook(id: String, completionHandler: @escaping OneBookResultCallback)
    func add(book: Book, completionHandler: @escaping OneBookResultCallback)
    func remove(book: Book, completionHandler: @escaping OneBookResultCallback)
}

class BooksService: BooksServiceProtocol {
    
    fileprivate lazy var booksDatabaseReference = Database.database().reference().child("books")
    
    func fetchBooks(completionHandler: @escaping BooksResultCallback) {
        self.booksDatabaseReference.observeSingleEvent(of: .value, with: { (dataSnapshot) in
            completionHandler(Result.success(self.processBooks(dataSnapshot: dataSnapshot)))
        })
    }
    
    func fetchOneBook(id: String, completionHandler: @escaping OneBookResultCallback){
        self.booksDatabaseReference.child(id).observeSingleEvent(of: .value) { (dataSnapshot) in
            if let the_book = self.processOneBook(dataSnapshot: dataSnapshot){
                completionHandler(Result.success(the_book))
            }
        }
    }
    
    func add(book: Book, completionHandler: @escaping OneBookResultCallback){
        do {
            let dict = try self.encode(book: book)
            self.booksDatabaseReference.childByAutoId().setValue(dict)
            completionHandler(Result.success(book))
        }
        catch let error {
            completionHandler(Result.error(error.localizedDescription))
        }
    }
    
    func edit(book: Book, completionHandler: @escaping OneBookResultCallback) {
        
    }
    
    func remove(book: Book, completionHandler: @escaping OneBookResultCallback) {
        self.booksDatabaseReference.child(book.id).removeValue()
        completionHandler(Result.success(book))
    }
    
    fileprivate func processBooks(dataSnapshot: DataSnapshot) -> [Book]{
        var books = [Book]()
        
        if dataSnapshot.hasChildren(), let books_dict = dataSnapshot.value as? [String:NSDictionary]{
            for (bookKey, bookValue) in books_dict{
                books.append(self.decode(bookDictionary: bookValue, bookKey: bookKey))
            }
        }
        
        return books
    }
    
    fileprivate func processOneBook(dataSnapshot: DataSnapshot) -> Book?{
        var book: Book? = nil
        if dataSnapshot.hasChildren(), let book_dict = dataSnapshot.value as? NSDictionary{
            book = self.decode(bookDictionary: book_dict, bookKey: dataSnapshot.key)
        }
        
        return book
    }
    
    //MARK: Utility functions
    fileprivate func encode(book: Book) throws -> Any{
        let encoder = JSONEncoder()
        let data = try encoder.encode(book)
        return try JSONSerialization.jsonObject(with: data, options: [])
    }
    
    fileprivate func decode(bookDictionary: NSDictionary, bookKey: String) -> Book{
        var bookToReturn: Book!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do{
            let data = try JSONSerialization.data(withJSONObject: bookDictionary, options: [])
            bookToReturn = try decoder.decode(Book.self, from: data)
            bookToReturn.id = bookKey
        }
        catch{ }
        
        return bookToReturn
    }
}
