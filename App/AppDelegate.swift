//
//  AppDelegate.swift
//  PicSplash
//
//  Created by Sergio Lechini on 23.08.2021.
//

import UIKit
import SwiftLazy

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        regDI()
        createAndShowStartScreen()
                
        return true
    }
}

private extension AppDelegate {
    func regDI() {
        AppDI.reg()
    }
    
    func createAndShowStartScreen() {
        let router: LoginRouter = AppDI.resolve()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = router.navigationController
        window?.makeKeyAndVisible()
        
        router.start()
    }
}

