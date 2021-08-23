//
//  AppDelegate.swift
//  PicSplash
//
//  Created by Sergio Lechini on 23.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        createAndShowStartScreen()
        return true
    }
}

private extension AppDelegate {
    func createAndShowStartScreen() {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [MenuViewController()]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

