//
//  BooksViewController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol BooksViewControllerDelegate: class {
    func showBookDetails(_ viewController: BooksViewController, bookId: String)
}

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var booksController: BooksControllerProtocol?
    weak var delegate: BooksViewControllerDelegate?

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewConfigurator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.booksController?.fetchBooks()
    }
    
    fileprivate func viewConfigurator(){
        self.tableView.register(cellType: BookTableViewCell.self)
        self.tableView.tableFooterView = UIView()
        
        self.booksController?.viewModelUpdated = { [unowned self] in
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
        return self.booksController?.booksViewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BookTableViewCell.self)
        
        if let viewModel = self.booksController?.booksViewModel?[indexPath.row]{
            cell.configure(viewModel: viewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let bookId = self.booksController?.bookId(forViewModelIndex: indexPath.row){
            tableView.deselectRow(at: indexPath, animated: true)
            
            self.delegate?.showBookDetails(self, bookId: bookId)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.booksController?.deleteBook(forViewModelIndex: indexPath.row, completionHandler: { (error) in
                if let _ = error{
                    //Show error
                }
            })
        default:
            break
        }
    }
}
