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
    func selectAnAuthor(addBookViewController: AddBookViewController)
}

class AddBookViewController: UIViewController {

    weak var delegate: AddBookViewControllerDelegate?
    var controller: AddBookControllerProtocol?

    @IBOutlet private var bookTitle: UITextField!
    @IBOutlet private var selectAnAuthorButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let buttonTitle = self.controller?.selectedAuthor?.name ?? "Select an Author"
        self.selectAnAuthorButton.setTitle(buttonTitle, for: .normal)
    }

    @IBAction func addButtonTouchUpInside(_ sender: UIButton) {
        if let bookName = self.bookTitle.text {
            self.controller?.addBook(name: bookName, completionHandler: { (error) in
                if error != nil {
                    //Show error
                } else {
                    self.delegate?.bookAddedSuccessfully()
                }
            })
        }
    }

    @IBAction func selectAuthorButtonTouchUpInside(_ sender: UIButton) {
        self.delegate?.selectAnAuthor(addBookViewController: self)
    }
}
