//
//  ProfileViewController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol ProfileViewControllerDelegate: class{
    
}

class ProfileViewController: UIViewController {
    
    @IBOutlet var userName: UILabel!
    
    var controller: ProfileControllerProtocol?
    weak var delegate: ProfileViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewConfigurator()
        
        self.controller?.fetchProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func viewConfigurator(){
        self.controller?.viewModelUpdated = viewModelUpdated
    }
    
    fileprivate func viewModelUpdated(){
        self.userName.text =  self.controller?.profileViewModel?.name
    }
}
