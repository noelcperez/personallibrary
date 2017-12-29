//
//  SignUpViewController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/30/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol SignUpViewControllerDelegate: class {
    func signUpSuccessfully()
}

class SignUpViewController: UIViewController {

    var controller: SignUpControllerProtocol?
    weak var delegate: SignUpViewControllerDelegate?

    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: My functions
    fileprivate func clearView() {
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
    }

    @IBAction func signUpButtonTouchUpInside(_ sender: UIButton) {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text {
            self.controller?.signUp(email: email, password: password, completionHandler: { [unowned self] error in
                if error != nil {
                    //Show error
                } else {
                    self.clearView()
                    self.delegate?.signUpSuccessfully()
                }
            })
        }
    }
}
