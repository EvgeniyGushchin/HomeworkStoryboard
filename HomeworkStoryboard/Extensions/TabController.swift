//
//  TabController.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 07/09/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    open override var childForStatusBarStyle: UIViewController? {
        if let navigationController = self.selectedViewController as? UINavigationController {
            return navigationController.viewControllers.last
        } else {
             return self.selectedViewController
        }
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        if let navigationController = self.selectedViewController as? UINavigationController {
            return navigationController.viewControllers.last
        } else {
             return self.selectedViewController
        }
    }
}
