//
//  AddBookViewController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 12/1/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol AddBookViewControllerDelegate: class {
    func bookAddedSuccessfully()
}

class AddBookViewController: UIViewController {
    
    weak var delegate: AddBookViewControllerDelegate?
    var controller: AddBookController?

    @IBOutlet var bookTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addButtonTouchUpInside(_ sender: UIButton) {
        if let bookName = self.bookTitle.text{
            self.controller?.addBook(name: bookName, completionHandler: { (error) in
                if let _ = error{
                    //Show error
                }
                else{
                    self.delegate?.bookAddedSuccessfully()
                }
            })
        }
    }
}
