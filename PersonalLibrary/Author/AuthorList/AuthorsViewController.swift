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

class AuthorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    //Property injection
    var controller: AuthorsControllerProtocol?
    weak var delegate: AuthorsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewConfigurator()
        
        self.controller?.fetchAuthors()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func viewConfigurator(){
        self.tableView.register(cellType: AuthorTableViewCell.self)
        self.tableView.tableFooterView = UIView()
        
        self.controller?.viewModelUpdated = {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.controller?.authorsViewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: AuthorTableViewCell.self)
        
        if let viewModel = self.controller?.authorsViewModel?[indexPath.row]{
            cell.configure(viewModel: viewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let bookId = self.controller?.authorId(forAuthorViewModel: indexPath.row){
            tableView.deselectRow(at: indexPath, animated: true)
            
            self.delegate?.showAuthorDetails(self, authorId: bookId)
        }
    }
}
