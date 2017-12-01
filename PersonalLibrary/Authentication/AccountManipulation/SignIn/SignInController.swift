//
//  SignInController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/30/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol SignInControllerProtocol: class {
    var service: AuthenticationServiceProtocol { get }
    
    func signIn(email: String, password: String, completionHandler: @escaping (String?) ->Void)
}

class SignInController: SignInControllerProtocol {
    
    private(set) var service: AuthenticationServiceProtocol
    
    init(service: AuthenticationServiceProtocol) {
        self.service = service
    }
    
    func signIn(email: String, password: String, completionHandler: @escaping (String?) ->Void) {
        self.service.signIn(email: email, password: password) { (result) in
            switch result{
                case .success(_):
                    completionHandler(nil)
                case .error(let error):
                    completionHandler(error)
            }
        }
    }
}
