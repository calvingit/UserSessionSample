//
//  AppDelegate.swift
//  UserSessionSample
//
//  Created by zen on 08/08/15.
//  Copyright (c) 2015 dimazen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let userSessionController = UserSessionController(userDefaults: UserDefaults.standard)
    private var rootRouter: RootRouter!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        rootRouter = RootRouter(userSessionController: userSessionController, window: window!)
        rootRouter.execute()
        
        return true
    }
}

