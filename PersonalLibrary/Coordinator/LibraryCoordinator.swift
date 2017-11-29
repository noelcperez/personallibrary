//
//  LibraryCoordinator.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

class LibraryCoordinator: NSObject{
    
    fileprivate var booksNavigationController: UINavigationController?
    fileprivate var authorNavigationController: UINavigationController?
    fileprivate var profileNavigationController: UINavigationController?
    
    private enum TabItems: Int {
        case books = 0
        case authors = 1
        case profile = 2
    }
    
    fileprivate var tabBarController: UITabBarController{
        didSet{
            tabBarController.delegate = self
        }
    }
    fileprivate let authenticator: Authenticator
    
    init(tabBarController: UITabBarController, authenticator: Authenticator) {
        self.tabBarController = tabBarController
        self.authenticator = authenticator
        
        super.init()
        
        self.tabBarController.delegate = self
        
        self.configureTabBar()
    }
    
    fileprivate func configureTabBar(){
        //Configure books tab
        self.booksNavigationController = self.tabBarController.viewControllers?[TabItems.books.rawValue] as? UINavigationController
        let booksService = BooksService()
        let booksController = BooksController(booksService: booksService)
        let booksViewController = StoryboardScene.Library.booksViewController.instantiate()
        //Inject properties
        booksViewController.booksController = booksController
        booksViewController.delegate = self
        //Set the book view controller as the root controller
        self.booksNavigationController?.viewControllers = [booksViewController]
        
        //Configure authors tab
        self.authorNavigationController = self.tabBarController.viewControllers?[TabItems.authors.rawValue] as? UINavigationController
        let authorService = AuthorsService()
        let authorController = AuthorsController(authorService: authorService)
        let authorViewController = StoryboardScene.Library.authorsViewController.instantiate()
        //Inject properties
        authorViewController.controller = authorController
        authorViewController.delegate = self
        //Set te author controller as the root controller
        self.authorNavigationController?.viewControllers = [authorViewController]
        
        //Configure profile tab
        self.profileNavigationController = self.tabBarController.viewControllers?[TabItems.profile.rawValue] as? UINavigationController
        let profileViewController = StoryboardScene.Library.profileViewController.instantiate()
        self.profileNavigationController?.viewControllers = [profileViewController]
    }
}

extension LibraryCoordinator: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard !authenticator.isUserAuthenticated else {
            return true
        }
        
        return viewController == tabBarController.viewControllers?[TabItems.profile.rawValue] ? false : true
    }
}

extension LibraryCoordinator: AuthorsViewControllerDelegate{
    func showAuthorDetails(_ viewController: AuthorsViewController, authorId: String) {
        
    }
}

extension LibraryCoordinator: BooksViewControllerDelegate{
    func showBookDetails(_ viewController: BooksViewController, bookId: String) {
        
    }
}
