//
//  BenchmarkViewController.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 07/09/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

class BenchmarkViewController: UIViewController, RunTimerProtocol {

    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addBehaviors(behaviors: [RunTimerBehavior()])
    }
    
    func setTimer(timer: Timer?) {
        self.timer = timer
    }
}
