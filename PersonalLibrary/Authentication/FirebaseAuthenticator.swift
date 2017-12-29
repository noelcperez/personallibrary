//
//  FirebaseAuthenticator.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/29/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit
import Firebase

class FirebaseAuthenticator: Authenticator {
    var isUserAuthenticated: Bool {
        //if let _ = try? Auth.auth().signOut(){ }
        return Auth.auth().currentUser != nil
    }
}
