//
//  AppDelegate.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    fileprivate let databaseManager = DatabaseManager.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        loadAppropriateStoryboard()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {
        databaseManager.saveContext()
    }
}

fileprivate extension AppDelegate {
    fileprivate func loadAppropriateStoryboard() {
        if databaseManager.users().count != 0 {
            let mainStoryboard =  UIStoryboard(name: "Main", bundle: nil)
            let mnc = mainStoryboard.instantiateViewController(withIdentifier : "MainTabBarController") as! UITabBarController
            window?.rootViewController = mnc
        } else {
            let seriesStoryboard =  UIStoryboard(name: "Login", bundle: nil)
            let snc = seriesStoryboard.instantiateViewController(withIdentifier : "LoginViewController") as! LoginViewController
            window?.rootViewController = snc
        }
    }
}
