//
//  AuthorDetailsController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/30/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol AuthorDetailsControllerProtocol: class, ViewModelUpdateProtocol {
    var authorsService: AuthorsServiceProtocol { get }
    var authorViewModel: AuthorViewModel? { get }
    
    func fetch()
    func editAuthor(authorName: String)
    func remove()
}

class AuthorDetailsController: AuthorDetailsControllerProtocol {
    var viewModelUpdated: (() -> Void)?
    
    private (set) var authorsService: AuthorsServiceProtocol
    private (set) var authorViewModel: AuthorViewModel?{
        didSet{
            viewModelUpdated?()
        }
    }
    
    private var author: Author!{
        didSet{
            self.authorViewModel = AuthorViewModel(name: author.name)
        }
    }
    private let authorId: String!
    
    init(authorsService: AuthorsServiceProtocol, authorId: String) {
        self.authorsService = authorsService
        self.authorId = authorId
    }
    
    func fetch() {
        self.authorsService.fetchAuthor(id: self.authorId) { (result) in
            switch result{
                case .success(let author):
                    self.author = author
                case .error(_):
                    //Show error
                    break
            }
        }
    }
    
    func editAuthor(authorName: String) {
        
    }
    
    func remove() {
        
    }
    

}
