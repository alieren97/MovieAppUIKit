//
//  AppDelegate.swift
//  MovieApp
//
//  Created by AliEren on 2.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        navigationSetup()
        loadLocalData()
        
        return true
    }
    
}

// MARK: - Helpers
extension AppDelegate {
    func navigationSetup() {
        window = UIWindow()
        let tabBarViewController = TabBarViewController()
//        let navigationController = UINavigationController(rootViewController: tabBarViewController)
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
    }
    
    func loadLocalData() {
        UserDefaultsManager.shared.check24H()
    }
    
}
