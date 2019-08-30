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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let splitViewController = window?.rootViewController as? UISplitViewController,
          let rightNavController = splitViewController.viewControllers.last as? UINavigationController,
          let detailViewController = rightNavController.topViewController
          else { fatalError() }
        
        splitViewController.delegate = self
        
        detailViewController.navigationItem.leftItemsSupplementBackButton = true
        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        return true
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
