//
//  ProfileService.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/30/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit
import Firebase

typealias UserResultCallback = (Result<Profile>) -> Void

protocol ProfileServiceProtocol {
    func fetchUser(completionHandler: @escaping UserResultCallback)
    func signOut(completionHandler: (String?) -> Void)
}

class ProfileService: NSObject, ProfileServiceProtocol {
    
    func fetchUser(completionHandler: @escaping UserResultCallback) {
        if let user = Auth.auth().currentUser, let email = user.email{
            completionHandler(Result.success(Profile(id: user.uid, name: email)))
        }
        else{
            completionHandler(Result.error("Not found"))
        }
    }
    
    func signOut(completionHandler: (String?) -> Void){
        do {
            try Auth.auth().signOut()
            completionHandler(nil)
        }
        catch let error{
            completionHandler(error.localizedDescription)
        }
    }
}
