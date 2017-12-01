//
//  Book.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

struct Book: Codable {
    var id: String!
    var name: String
    
}

extension Book {
    init(from decoder: Decoder) throws {
        let book = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try book.decode(String.self, forKey: .name)
    }
    
    fileprivate enum CodingKeys: String, CodingKey{
        case name
    }
}
