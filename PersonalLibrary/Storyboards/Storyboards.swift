//
//  Storyboards.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation
import UIKit

protocol StoryboardType {
    static var storyboardName: String { get }
}

extension StoryboardType {
    static var storyboard: UIStoryboard {
        let name = self.storyboardName
        return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
    }
}

struct SceneType<T: Any> {
    let storyboard: StoryboardType.Type
    let identifier: String
    
    func instantiate() -> T {
        let identifier = self.identifier
        guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
        }
        return controller
    }
}

struct InitialSceneType<T: Any> {
    let storyboard: StoryboardType.Type
    
    func instantiate() -> T {
        guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
            fatalError("ViewController is not of the expected class \(T.self).")
        }
        return controller
    }
}

protocol SegueType: RawRepresentable { }

extension UIViewController {
    func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
        let identifier = segue.rawValue
        performSegue(withIdentifier: identifier, sender: sender)
    }
}

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
enum StoryboardScene {
    enum Authentication: StoryboardType {
        static let storyboardName = "Authentication"
    }
    enum LaunchScreen: StoryboardType {
        static let storyboardName = "LaunchScreen"
        
        static let initialScene = InitialSceneType<UIViewController>(storyboard: LaunchScreen.self)
    }
    enum Library: StoryboardType {
        static let storyboardName = "Library"
        
        static let initialScene = InitialSceneType<UITabBarController>(storyboard: Library.self)
        
        static let authorDetailsViewController = SceneType<PersonalLibrary.AuthorDetailsViewController>(storyboard: Library.self, identifier: "AuthorDetailsViewController")

        static let authorsViewController = SceneType<PersonalLibrary.AuthorsViewController>(storyboard: Library.self, identifier: "AuthorsViewController")
        
        static let bookDetailsViewController = SceneType<PersonalLibrary.BookDetailsViewController>(storyboard: Library.self, identifier: "BookDetailsViewController")
        
        static let booksViewController = SceneType<PersonalLibrary.BooksViewController>(storyboard: Library.self, identifier: "BooksViewController")
        
        static let profileViewController = SceneType<PersonalLibrary.ProfileViewController>(storyboard: Library.self, identifier: "ProfileViewController")
    }
}

enum StoryboardSegue {
}

private final class BundleToken {}
