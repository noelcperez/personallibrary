//
//  AddAuthorController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 12/4/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol AddAuthorControllerProtocol {
    var service: AuthorsServiceProtocol { get }

    func addAuthor(name: String, completionHandler: @escaping (String?) -> Void)
}

class AddAuthorController: AddAuthorControllerProtocol {

    private(set) var service: AuthorsServiceProtocol

    init(service: AuthorsServiceProtocol) {
        self.service = service
    }

    func addAuthor(name: String, completionHandler: @escaping (String?) -> Void) {
        let authorToAdd = Author(id: "", name: name)
        self.service.add(author: authorToAdd) { (result) in
            switch result {
            case .success:
                    completionHandler(nil)
            case .error(let error):
                    completionHandler(error)
            }
        }
    }
}
