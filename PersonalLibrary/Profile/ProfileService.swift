//
//  ProfileService.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/30/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

typealias UserResultCallback = (Result<Profile>) -> Void

protocol ProfileServiceProtocol {
    func fetchUser(completionHandler: @escaping UserResultCallback)
}

class ProfileService: NSObject, ProfileServiceProtocol {
    
    private var user = {
        return Profile(id: "1", name: "This user")
    }()
    
    func fetchUser(completionHandler: @escaping UserResultCallback) {
        completionHandler(Result.success(self.user))
    }
}
