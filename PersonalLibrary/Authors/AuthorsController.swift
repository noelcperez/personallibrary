//
//  AuthorsController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol AuthorsControllerProtocol: class, ViewModelUpdateProtocol {
    var authorService: AuthorsServiceProtocol { get }
    var authorsViewModel: [AuthorViewModel]? { set get }
    
    func fetchAuthors()
    func authorId(forAuthorViewModel index: Int) -> String
}

class AuthorsController: AuthorsControllerProtocol {
    var viewModelUpdated: (() -> Void)?
    
    private (set) var authorService: AuthorsServiceProtocol
    var authorsViewModel: [AuthorViewModel]?{
        didSet{
            viewModelUpdated?()
        }
    }
    
    private var authors = [Author](){
        didSet{
            self.authorsViewModel = authors.map { AuthorViewModel(name: $0.name) }
        }
    }
    
    init(authorService: AuthorsServiceProtocol) {
        self.authorService = authorService
    }
    
    func fetchAuthors(){
        self.authorService.fetchAuthors { (result) in
            switch result{
                case .success(let authors):
                    self.authors = authors
                case .error(_):
                    //Show error
                    break
            }
        }
    }
    
    func authorId(forAuthorViewModel index: Int) -> String{
        return self.authors[index].id
    }
}
