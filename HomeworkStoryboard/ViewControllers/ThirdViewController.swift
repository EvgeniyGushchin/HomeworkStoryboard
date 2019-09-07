//
//  ThirdViewController.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 07/09/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onPushToRoot(_ sender: Any) {
        
        guard let navVC = navigationController, let first = navVC.viewControllers.first else {
            return
        }
        let viewControllers = [first]
        navVC.setViewControllers(viewControllers, animated: true)
        
        // or just pop to Root
//        navigationController?.popToRootViewController(animated: true)
    }
    
    
}
