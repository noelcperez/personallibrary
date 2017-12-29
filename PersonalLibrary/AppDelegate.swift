//
//  AppDelegate.swift
//  PersonalLibrary
//
//  Created by Noel Perez on 11/28/17.
//  Copyright © 2017 Noel C. Perez. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var libraryCoordinator: LibraryCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        window = UIWindow(frame: UIScreen.main.bounds)

        // swiftlint:disable force_unwrapping
        libraryCoordinator = LibraryCoordinator(window: window!, authenticator: FirebaseAuthenticator())

        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
}
