//
//  AuthorsService.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

typealias AuthorResultCallback = (Result<Author>) -> Void

protocol AuthorsServiceProtocol {
    func fetchAuthors(completionHanlder: @escaping AuthorResultCallback)
}

class AuthorsService: AuthorsServiceProtocol {
    func fetchAuthors(completionHanlder: @escaping AuthorResultCallback) {
        
    }
}
