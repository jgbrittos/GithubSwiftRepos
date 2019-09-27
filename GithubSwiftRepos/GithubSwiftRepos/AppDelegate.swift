//
//  AppDelegate.swift
//  GithubSwiftRepos
//
//  Created by João Gabriel de Britto e Silva on 27/09/19.
//  Copyright © 2019 JGBrittoS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let repoListVC = RepoListViewController()
        
        window?.rootViewController = repoListVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

