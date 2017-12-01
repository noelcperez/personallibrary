//
//  BookDetailsViewController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol BookDetailsViewControllerDelegate: class {
    func doneWithDetails()
}

class BookDetailsViewController: UIViewController {
    
    @IBOutlet var bookName: UILabel!
    
    var bookDetailsController: BookDetailsController?
    weak var delegate: BookDetailsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bookDetailsController?.viewModelUpdated = updateViewModel
    
        self.bookDetailsController?.fetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func updateViewModel(){
        self.bookName.text = self.bookDetailsController?.bookViewModel?.name
    }
}
