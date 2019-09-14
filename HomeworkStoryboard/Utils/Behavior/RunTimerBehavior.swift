//
//  TimerBehavior.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 07/09/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

protocol RunTimerProtocol {
    var timer: Timer? { get }
    func setTimer(timer: Timer?)
}

struct RunTimerBehavior: ViewControllerLifecycleBehavior {

    func beforeDisappearing(_ viewController: UIViewController) {
        guard let vc = viewController as? RunTimerProtocol, let timer = vc.timer else {
            return
        }
        
        timer.invalidate()
        vc.setTimer(timer: nil)
    }

     func afterAppearing(_ viewController: UIViewController) {
        
        if let vc = viewController as? RunTimerProtocol {
            let timer = Timer(timeInterval: 1.0, repeats: true) { timer in
                print(Date())
            }
            RunLoop.current.add(timer, forMode: .common)
            vc.setTimer(timer: timer)
        }
    }
}
