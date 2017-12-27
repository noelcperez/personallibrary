//
//  ViewModelUpdateProtocol.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/30/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol ViewModelUpdateProtocol {
    var viewModelUpdated: (() -> Void)? { set get }
}
