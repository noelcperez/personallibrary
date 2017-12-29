//
//  SignInViewController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/30/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol SignInViewControllerDelegate: class {
    func signInSuccessfully()
    func signUp()
}

class SignInViewController: UIViewController {

    var controller: SignInControllerProtocol?
    weak var delegate: SignInViewControllerDelegate?

    @IBOutlet private var email: UITextField!
    @IBOutlet private var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func hello() { }

    // MARK: - Actions
    @IBAction func sigInButtonTouchUpInside(_ sender: UIButton) {
        if let email = self.email.text, let password = self.password.text {
            self.controller?.signIn(email: email, password: password, completionHandler: { [unowned self] error in
                if error != nil {
                    //Show error
                } else {
                    self.delegate?.signInSuccessfully()
                }
            })
        }
    }

    @IBAction func signUpButtonTouchUpInside(_ sender: UIButton) {
        self.delegate?.signUp()
    }
}
