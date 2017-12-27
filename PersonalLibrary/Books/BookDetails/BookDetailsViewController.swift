//
//  BookDetailsViewController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol BookDetailsViewControllerDelegate: class {
    
}

class BookDetailsViewController: UIViewController {
    
    @IBOutlet var bookName: UILabel!
    @IBOutlet var authorName: UILabel!
    
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
        let viewModel = self.bookDetailsController?.bookViewModel
        self.bookName.text = viewModel?.name
        self.authorName.text = "Author: " + (viewModel?.authorName ?? "")
    }
}
