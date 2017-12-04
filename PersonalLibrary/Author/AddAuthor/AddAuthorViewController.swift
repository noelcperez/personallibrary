//
//  AddAuthorViewController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 12/1/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol AddAuthorViewControllerDelegate: class {
    func authorAddedSuccesfully()
}

class AddAuthorViewController: UIViewController {
    
    @IBOutlet var authorName: UITextField!
    
    var controller: AddAuthorControllerProtocol?
    weak var delegate: AddAuthorViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addButtonTouchUpInside(_ sender: UIButton) {
        if let author_name = self.authorName.text{
            self.controller?.addAuthor(name: author_name, completionHandler: { [unowned self] (error) in
                if let _ = error{
                    //Show error
                }
                else{
                    self.delegate?.authorAddedSuccesfully()
                }
            })
        }
    }
}
