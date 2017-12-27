//
//  LibraryCoordinator.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

class LibraryCoordinator: NSObject{
    
    fileprivate let window: UIWindow
    
    fileprivate var booksNavigationController: UINavigationController?
    fileprivate var authorNavigationController: UINavigationController?
    fileprivate var profileNavigationController: UINavigationController?
    fileprivate var accountManipulationNavigationController: UINavigationController?
    
    private enum TabItems: Int {
        case books = 0
        case authors = 1
        case profile = 2
    }
    
    fileprivate var tabBarController: UITabBarController = {
        let tabBarController = StoryboardScene.Library.initialScene.instantiate()
        return tabBarController
    }()
    fileprivate let authenticator: Authenticator
    
    init(window: UIWindow, authenticator: Authenticator) {
        self.window = window
        self.authenticator = authenticator
        
        super.init()
        
        self.window.rootViewController = self.tabBarController
        self.window.makeKeyAndVisible()
        
        tabBarController.delegate = self
        
        self.configureNavigation()
    }
    
    fileprivate func configureNavigation(){
        //Configure books tab
        self.booksNavigationController = self.tabBarController.viewControllers?[TabItems.books.rawValue] as? UINavigationController
        let booksService = BooksService()
        let booksController = BooksController(booksService: booksService)
        let booksViewController = StoryboardScene.Library.booksViewController.instantiate()
        //Inject properties
        booksViewController.booksController = booksController
        booksViewController.delegate = self
        //Navigation
        booksViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(LibraryCoordinator.addBook))
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
        authorViewController.authorVCType = .showdetails
        //Navigation
        authorViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(LibraryCoordinator.addAuthor))
        //Set te author controller as the root controller
        self.authorNavigationController?.viewControllers = [authorViewController]
        
        //Configure profile tab
        self.profileNavigationController = self.tabBarController.viewControllers?[TabItems.profile.rawValue] as? UINavigationController
        let profileService = ProfileService()
        let profileController = ProfileController(profileService: profileService)
        let profileViewController = StoryboardScene.Library.profileViewController.instantiate()
        //Inject properties
        profileViewController.controller = profileController
        profileViewController.delegate = self
        self.profileNavigationController?.viewControllers = [profileViewController]
        
        //Configure authentication flow
        self.accountManipulationNavigationController = StoryboardScene.Authentication.initialScene.instantiate()
        let signInService = AuthenticationService()
        let signInController = SignInController(service: signInService)
        let signInViewController = StoryboardScene.Authentication.signInViewController.instantiate()
        //Inject properties
        signInViewController.controller = signInController
        signInViewController.delegate = self
        //Navigation
        signInViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(LibraryCoordinator.closeAccountManipulation))
        self.accountManipulationNavigationController?.viewControllers = [signInViewController]
    }
    
    @objc fileprivate func closeAccountManipulation(){
        self.tabBarController.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func addBook(){
        let service = BooksService()
        let addBookController = AddBookController(service: service)
        let addBookViewController = StoryboardScene.Library.addBookViewController.instantiate()
        addBookViewController.controller = addBookController
        addBookViewController.delegate = self
        self.booksNavigationController?.pushViewController(addBookViewController, animated: true)
    }
    
    @objc fileprivate func addAuthor(){
        let service = AuthorsService()
        let controller = AddAuthorController(service: service)
        let addAuthorViewController = StoryboardScene.Library.addAuthorViewController.instantiate()
        //Inject properties
        addAuthorViewController.controller = controller
        addAuthorViewController.delegate = self
        self.authorNavigationController?.pushViewController(addAuthorViewController, animated: true)
    }
    
    fileprivate func showAuthentication(){
        if let accountManipulationNavigationController = self.accountManipulationNavigationController{
            self.tabBarController.present(accountManipulationNavigationController, animated: true, completion: nil)
        }
    }
}

//MARk: - tabbar controller delegate
extension LibraryCoordinator: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard !authenticator.isUserAuthenticated else {
            return true
        }
        
        if viewController == tabBarController.viewControllers?[TabItems.profile.rawValue]{
            self.showAuthentication()
            return false
        }
        
        return  true
    }
}

//MARK: - Books navigation delegates
extension LibraryCoordinator: BooksViewControllerDelegate{
    func showBookDetails(_ viewController: BooksViewController, bookId: String) {
        let bookService = BooksService()
        let authorService = AuthorsService()
        let bookDetailsController = BookDetailsController(booksService: bookService, authorsService: authorService, bookId: bookId)
        let bookDetailsViewController = StoryboardScene.Library.bookDetailsViewController.instantiate()
        //Inject properties
        bookDetailsViewController.bookDetailsController = bookDetailsController
        bookDetailsViewController.delegate = self
        self.booksNavigationController?.pushViewController(bookDetailsViewController, animated: true)
    }
}

extension LibraryCoordinator: AddBookViewControllerDelegate{
    func bookAddedSuccessfully() {
        self.booksNavigationController?.popViewController(animated: true)
    }
    
    func selectAnAuthor(addBookViewController: AddBookViewController) {
        //Configure authors tab
        let authorService = AuthorsService()
        let authorController = AuthorsController(authorService: authorService)
        let authorViewController = StoryboardScene.Library.authorsViewController.instantiate()
        //Inject properties
        authorViewController.controller = authorController
        authorViewController.delegate = self
        authorViewController.viewControllerToRespond = addBookViewController
        authorViewController.authorVCType = .pick
        self.booksNavigationController?.show(authorViewController, sender: self)
    }
}

extension LibraryCoordinator: BookDetailsViewControllerDelegate{
    
}

//MARK: - Authors Navigation delegates
extension LibraryCoordinator: AuthorsViewControllerDelegate{
    func authorPicked(_ viewController: AuthorsViewController, author: Author) {
        switch viewController.authorVCType {
        case .pick:
            if let addBookViewController = viewController.viewControllerToRespond as? AddBookViewController{
                addBookViewController.controller?.selectedAuthor = author
            }
            self.booksNavigationController?.popViewController(animated: true)
        case .showdetails:
            let authorService = AuthorsService()
            let authorDetailsController = AuthorDetailsController(authorsService: authorService, authorId: author.id)
            let authorDetailsViewController = StoryboardScene.Library.authorDetailsViewController.instantiate()
            //Inject properties
            authorDetailsViewController.controller = authorDetailsController
            authorDetailsViewController.delegate = self
            self.authorNavigationController?.pushViewController(authorDetailsViewController, animated: true)
        }
    }
}

extension LibraryCoordinator: AddAuthorViewControllerDelegate{
    func authorAddedSuccesfully() {
        self.authorNavigationController?.popViewController(animated: true)
    }
}

extension LibraryCoordinator: AuthorDetailsViewControllerDelegate{
    
}

//MARK: - Profile Navigation delegates
extension LibraryCoordinator: ProfileViewControllerDelegate{
    func signOut() {
        self.tabBarController.selectedIndex = 0
    }
}

//MARK: - Authentication navigation delegate
extension LibraryCoordinator: SignInViewControllerDelegate{
    func signInSuccessfully() {
        self.closeAccountManipulation()
    }
    
    func signUp() {
        let service = AuthenticationService()
        let controller = SignUpController(service: service)
        let signUpViewController = StoryboardScene.Authentication.signUpViewController.instantiate()
        signUpViewController.controller = controller
        signUpViewController.delegate = self
        self.accountManipulationNavigationController?.pushViewController(signUpViewController, animated: true)
    }
}

extension LibraryCoordinator: SignUpViewControllerDelegate{
    func signUpSuccessfully() {
        self.closeAccountManipulation()
    }
}
