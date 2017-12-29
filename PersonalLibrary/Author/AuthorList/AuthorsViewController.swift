//
//  AuthorsViewController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol RespondsToViewController {
    var viewControllerToRespond: UIViewController! { get }
}

protocol AuthorsViewControllerDelegate: class {
    func authorPicked(_ viewController: AuthorsViewController, author: Author)
}

class AuthorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RespondsToViewController {

    @IBOutlet private var tableView: UITableView!

    enum AuthorVCType {
        case pick
        case showdetails
    }

    var authorVCType = AuthorVCType.pick

    //Property injection
    var controller: AuthorsControllerProtocol?
    var viewControllerToRespond: UIViewController!
    weak var delegate: AuthorsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewConfigurator()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.controller?.fetchAuthors()
    }

    fileprivate func viewConfigurator() {
        self.tableView.register(cellType: AuthorTableViewCell.self)
        self.tableView.tableFooterView = UIView()

        self.controller?.viewModelUpdated = {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller?.authorsViewModel?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: AuthorTableViewCell.self)

        if let viewModel = self.controller?.authorsViewModel?[indexPath.row] {
            cell.configure(viewModel: viewModel)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let author = self.controller?.author(forViewModelIndex: indexPath.row) {
            tableView.deselectRow(at: indexPath, animated: true)

            self.delegate?.authorPicked(self, author: author)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.controller?.remove(authorViewModelIndex: indexPath.row, completionHandler: { (error) in
                if error != nil {
                    //Show error
                }
            })
        default:
            break
        }
    }
}
