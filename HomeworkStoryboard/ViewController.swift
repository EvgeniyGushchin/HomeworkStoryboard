//
//  ViewController.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 28/08/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func showDetailVC(_ sender: Any) {
        if let vc = splitViewController?.viewControllers.last as? UINavigationController {
            splitViewController?.showDetailViewController(vc.topViewController!, sender: nil)
        }
        
    }
    
}

