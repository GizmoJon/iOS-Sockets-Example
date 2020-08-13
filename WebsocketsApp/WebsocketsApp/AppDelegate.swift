//
//  AppDelegate.swift
//  WebsocketsApp
//
//  Created by Mohammed Al Waili on 03/02/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)

        
        // Supports all versions of iOS
        // let client = StarscreamSocketClient(with: URL(string: "ws://localhost:8080/")!)
        
        // Support iOS 13 and above
        // let client = URLSessionWebSocketClient(with: URL(string: "ws://localhost:8080/")!)
        
        // Uses URLSessionWebSocketClient under the hood for iOS 13 and above
        // And StarscreamSocketClient for versions below iOS 13
        // In the future when iOS 12 is not supported anymore
        // You can go ahead and remove both StarscreamSocketClient & CombinedSocketClient
        // And only keep URLSessionWebSocketClient
        let client = CombinedSocketClient(with: URL(string: "ws://localhost:8080/")!)
        
        let engine = SocketEngine(with: client)
        let viewModel = MainViewModel(with: engine)
        let mainViewController = MainViewController(with: viewModel)
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }


}

