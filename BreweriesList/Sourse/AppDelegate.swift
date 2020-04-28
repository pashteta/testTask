//
//  AppDelegate.swift
//  BreweriesList
//
//  Created by User on 4/13/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        RouterSerice.setupScreenFlow()
        
        return true
    }
}

