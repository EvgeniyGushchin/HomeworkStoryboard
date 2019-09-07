//
//  ViewController.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 28/08/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    weak var delegate: UIViewController?
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBehaviors(behaviors: [NightModeBehavior()])
    }
    
}

