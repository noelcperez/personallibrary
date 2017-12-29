//
//  SignUpController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/30/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol SignUpControllerProtocol: class {
    var service: AuthenticationServiceProtocol { get }

    func signUp(email: String, password: String, completionHandler: @escaping (String?) -> Void)
}

class SignUpController: SignUpControllerProtocol {
    var viewModelUpdated: (() -> Void)?

    var service: AuthenticationServiceProtocol

    init(service: AuthenticationServiceProtocol) {
        self.service = service
    }

    func signUp(email: String, password: String, completionHandler: @escaping (String?) -> Void) {
        self.service.signUp(email: email, password: password) { (result) in
            switch result {
            case .success:
                    completionHandler(nil)
            case .error(let error):
                    completionHandler(error)
            }
        }
    }
}
