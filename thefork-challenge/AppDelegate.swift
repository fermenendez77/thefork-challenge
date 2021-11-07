//
//  AppDelegate.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let viewModel = RestaurantsListViewModel()
        let rootVC = RestaurantsViewController(viewModel: viewModel)
        let navigationView = ForkNavigationController(rootViewController: rootVC)
        self.window?.rootViewController = navigationView
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

