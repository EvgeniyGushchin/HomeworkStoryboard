//
//  NightModeBehavior.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 07/09/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

struct NightModeBehavior: ViewControllerLifecycleBehavior {
    
    func afterAppearing(_ viewController: UIViewController) {
        
        guard let statusBar = UIApplication.shared.statusBarUIView else { return }
        statusBar.backgroundColor = .black
        viewController.view.backgroundColor = .black
    }
    
    func beforeDisappearing(_ viewController: UIViewController) {
        guard let statusBar = UIApplication.shared.statusBarUIView else { return }
        statusBar.backgroundColor = .clear
    }
}
