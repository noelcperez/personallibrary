//
//  Result.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

enum Result<T> {
    case success(T)
    case error(String)
}
