//
//  AppDelegate.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 28/08/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: - Launching
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(#function)
        
        guard let splitViewController = window?.rootViewController as? UISplitViewController,
          let rightNavController = splitViewController.viewControllers.last as? UINavigationController,
          let detailViewController = rightNavController.topViewController
          else { fatalError() }
        
        splitViewController.delegate = self
        
        detailViewController.navigationItem.leftItemsSupplementBackButton = true
        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print(#function)
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function)
    }
    
    // MARK: - Terminating
    
    func applicationWillResignActive(_ application: UIApplication) {
        print(#function)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print(#function)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let host = url.host, host == "text" {
            switchToProfile()
        }
        return true
    }
}

extension AppDelegate {
    
    func switchToProfile() {
        guard let splitViewController = window?.rootViewController as? UISplitViewController,
        let leftNavController = splitViewController.viewControllers.first as? UITabBarController
        else { fatalError() }
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let sharedTextVC = storyboard.instantiateViewController(withIdentifier: String(describing: SharedTextViewController.self))
        leftNavController.selectedIndex = 2
        
        guard let navController = leftNavController.selectedViewController as? UINavigationController else {
            fatalError("didn't find Navigation controller. Get \(String(describing: leftNavController.selectedViewController)) instead")
        }
        navController.pushViewController(sharedTextVC, animated: false)
    }
}

extension AppDelegate: UISplitViewControllerDelegate {
  
    func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
        if splitViewController.isCollapsed {
            
            guard let tabViewController = splitViewController.viewControllers.first as? UITabBarController,
                let selectedNavigationViewController = tabViewController.selectedViewController as? UINavigationController else {
                    return false
            }
            
            var viewControllerToPush = vc
            if let navController = vc as? UINavigationController {
                viewControllerToPush = navController.topViewController!
            }
            
            viewControllerToPush.hidesBottomBarWhenPushed = true
            selectedNavigationViewController.pushViewController(viewControllerToPush, animated: true)
            return true
        }
        
        return false
    }
}
