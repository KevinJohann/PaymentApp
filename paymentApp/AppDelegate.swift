//
//  AppDelegate.swift
//  paymentApp
//
//  Created by Kevin on 08-06-22.
//

import UIKit

@main
class AppDelegate: UIResponder {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
}

// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setInitialVC()
        return true
    }
}

// MARK: - setInitialVC
extension AppDelegate {
    private func setInitialVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        
        appCoordinator = AppCoordinator(navigationController: navController)
        appCoordinator?.start()
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
