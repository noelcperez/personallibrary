//
//  AuthorsController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol AuthorsControllerProtocol: class {
    var authorService: AuthorsServiceProtocol { get }
    var authorsViewModel: [AuthorViewModel]? { get }
}

class AuthorsController: AuthorsControllerProtocol {
    
    private (set) var authorService: AuthorsServiceProtocol
    var authorsViewModel: [AuthorViewModel]?{
        didSet{
            
        }
    }
    
    init(authorService: AuthorsServiceProtocol) {
        self.authorService = authorService
    }
    
    
}
