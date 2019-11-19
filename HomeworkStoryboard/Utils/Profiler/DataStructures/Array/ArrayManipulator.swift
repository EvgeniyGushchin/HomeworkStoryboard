//
//  ArrayManipulator.swift
//  DataStructures
//
//  Created by Ellen Shapiro on 8/2/14.
//  Copyright (c) 2014 Ray Wenderlich Tutorial Team. All rights reserved.
//

import Foundation

/**
 * A protocol which will allow the easy swapping out of array subtypes
 */
protocol ArrayManipulator {
    func arrayHasObjects() -> Bool
    func setupWithObjectCount(_ count: Int) -> TimeInterval
    func insertNewObjectAtBeginning() -> TimeInterval
    func insertNewObjectInMiddle() -> TimeInterval
    func addNewObjectAtEnd() -> TimeInterval
    func removeFirstObject() -> TimeInterval
    func removeMiddleObject() -> TimeInterval
    func removeLastObject() -> TimeInterval
    func lookupByIndex() -> TimeInterval
    func lookupByObject() -> TimeInterval
    
    func searchThreeCharSequence() -> TimeInterval
    func searchThreeCharSequence(searchCount: Int) -> TimeInterval
}

extension ArrayManipulator {
    func searchThreeCharSequence() -> TimeInterval {
        print("Optional method")
        return 0
    }
    
    func searchThreeCharSequence(searchCount: Int) -> TimeInterval {
        print("Optional method")
        return 0
    }
}
