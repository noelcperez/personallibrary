//
//  ProfileController.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/30/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit

protocol ProfileControllerProtocol: class, ViewModelUpdateProtocol{
    var profileService: ProfileServiceProtocol { get }
    var profileViewModel: ProfileViewModel? { set get }
    
    func fetchProfile()
    func signOut(completionHandler: (String?) -> Void)
}

class ProfileController: ProfileControllerProtocol {
    var viewModelUpdated: (() -> Void)?
    
    private(set) var profileService: ProfileServiceProtocol
    var profileViewModel: ProfileViewModel?{
        didSet{
            self.viewModelUpdated?()
        }
    }
    
    private var profile: Profile!{
        didSet{
            self.profileViewModel = ProfileViewModel(name: profile.name)
        }
    }
    
    init(profileService: ProfileServiceProtocol) {
        self.profileService = profileService
    }
    
    func fetchProfile() {
        self.profileService.fetchUser { (result) in
            switch result{
                case .success(let profile):
                    self.profile = profile
                case .error(_):
                    //Show error
                    break
            }
        }
    }
    
    func signOut(completionHandler: (String?) -> Void){
        self.profileService.signOut(completionHandler: completionHandler)
    }
}
