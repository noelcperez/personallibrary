//
//  AuthorDetailsViewController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/30/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol AuthorDetailsViewControllerDelegate: class {
    
}

class AuthorDetailsViewController: UIViewController {
    
    @IBOutlet var authorName: UILabel!
    
    var controller: AuthorDetailsControllerProtocol?
    weak var delegate: AuthorDetailsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.controller?.viewModelUpdated = viewModelUpdated
        
        self.controller?.fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewModelUpdated(){
        self.authorName.text = self.controller?.authorViewModel?.name
    }

}
