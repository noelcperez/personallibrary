//
//  AuthorTableViewCell.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/30/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit
import Reusable

class AuthorTableViewCell: UITableViewCell, NibReusable {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(viewModel: AuthorViewModel){
        self.textLabel?.text = viewModel.name
    }

}
