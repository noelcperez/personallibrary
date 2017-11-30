//
//  AuthorsService.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

typealias AuthorsResultCallback = (Result<[Author]>) -> Void
typealias OneAuthorResultCallback = (Result<Author>) -> Void

protocol AuthorsServiceProtocol {
    func fetchAuthors(completionHanlder: @escaping AuthorsResultCallback)
    func fetchAuthor(id: String, completionHandler: @escaping OneAuthorResultCallback)
}

class AuthorsService: AuthorsServiceProtocol {
    
    fileprivate var memoryAuthors: [Author] = {
        let author1 = Author(id: "1", name: "Author 1")
        let author2 = Author(id: "2", name: "Author 2")
        let author3 = Author(id: "3", name: "Author 3")
        
        return [author1, author2, author3]
    }()
    
    func fetchAuthors(completionHanlder: @escaping AuthorsResultCallback) {
        completionHanlder(Result.success(self.memoryAuthors))
    }
    
    func fetchAuthor(id: String, completionHandler: @escaping OneAuthorResultCallback) {
        if let index = self.memoryAuthors.index(where: { $0.id == id}){
            completionHandler(Result.success(self.memoryAuthors[index]))
        }
        else{
            completionHandler(Result.error("Not found"))
        }
    }
}
