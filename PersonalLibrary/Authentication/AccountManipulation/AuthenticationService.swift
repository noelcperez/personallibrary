//
//  AuthenticationService.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/30/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit
import Firebase

typealias AuthenticationResultCallback = (Result<Profile>) -> Void

protocol AuthenticationServiceProtocol {
    func signIn(email: String, password: String, completionHandler: @escaping AuthenticationResultCallback)
    func signUp(email: String, password: String, completionHandler: @escaping AuthenticationResultCallback)
}

class AuthenticationService: AuthenticationServiceProtocol {
    func signIn(email: String, password: String, completionHandler: @escaping AuthenticationResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let the_error = error {
                completionHandler(Result.error(the_error.localizedDescription))
            } else {
                completionHandler(Result.success(Profile(id: "", name: "")))
            }
        }
    }

    func signUp(email: String, password: String, completionHandler: @escaping AuthenticationResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password) { (_, error) in
            if let the_error = error {
                completionHandler(Result.error(the_error.localizedDescription))
            } else {
                completionHandler(Result.success(Profile(id: "", name: "")))
            }
        }
    }
}
