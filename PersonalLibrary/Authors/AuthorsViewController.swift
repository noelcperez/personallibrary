//
//  AuthorsViewController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol AuthorsViewControllerDelegate: class {
    func showAuthorDetails(_ viewController: AuthorsViewController, authorId: String)
}

class AuthorsViewController: UIViewController {
    
    //Property injection
    var controller: AuthorsControllerProtocol?
    weak var delegate: AuthorsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}
