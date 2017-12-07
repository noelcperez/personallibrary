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
    var authorId: String
}

extension Book {
    init(from decoder: Decoder) throws {
        let book = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try book.decode(String.self, forKey: .name)
        self.authorId = try book.decode(String.self, forKey: .authorId)
    }
    
    fileprivate enum CodingKeys: String, CodingKey{
        case name
        case authorId
    }
}
