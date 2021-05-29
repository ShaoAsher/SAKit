//
//  AppDelegate.swift
//  SAKit_Swift
//
//  Created by KerrDev on 29/05/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
    

        window!.rootViewController = ViewController()
        window!.frame = UIScreen.main.bounds


        
        return true
    }



}

