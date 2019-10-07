//
//  Profiler.swift
//  DataStructures
//
//  Created by Ellen Shapiro on 8/2/14.
//  Copyright (c) 2014 Ray Wenderlich Tutorial Team. All rights reserved.
//

import Foundation

class Profiler {
  class func runClosureForTime(_ closure: (() -> Void)!) -> TimeInterval {
    //Timestamp before
    let startDate = CFAbsoluteTimeGetCurrent()
    //Run the closure
    closure()
    
    //Timestamp after
    let endDate = CFAbsoluteTimeGetCurrent()
    
    //Calculate the interval.
    let interval = endDate - startDate
    
    return interval
  }
}
