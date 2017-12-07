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
    func author(forViewModelIndex index: Int) -> Author
    func remove(authorViewModelIndex index: Int, completionHandler: @escaping (String?) -> Void)
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
    
    func author(forViewModelIndex index: Int) -> Author{
        return self.authors[index]
    }
    
    func remove(authorViewModelIndex index: Int, completionHandler: @escaping (String?) -> Void){
        let author = self.authors[index]
        self.authorService.remove(author: author) { (result) in
            switch result{
                case .success(_):
                    self.fetchAuthors()
                case .error(let error):
                    completionHandler(error)
            }
        }
    }
}
