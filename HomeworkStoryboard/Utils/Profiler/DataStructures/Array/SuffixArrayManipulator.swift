//
//  AppDelegate.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 19/11/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import Foundation

open class SuffixArrayManipulator: ArrayManipulator {
    fileprivate var suffixArray = [AlgoSuffix]()
    
    init(array: [AlgoSuffix]) {
        self.suffixArray = array
    }
    
    open func arrayHasObjects() -> Bool {
        if suffixArray.count == 0 {
            return false
        } else {
            return true
        }
    }
    
    open func setupWithObjectCount(_ count: Int) -> TimeInterval {
        guard count < suffixArray.count else {
            fatalError()
        }
        return Profiler.runClosureForTime() {
            var testArray = [AlgoSuffix]()
            for i in 0 ..< count {
                testArray.append(self.suffixArray[i])
            }
        }
    }
    
    fileprivate func testElement() -> AlgoSuffix {
        let elements = UInt32(suffixArray.count)
        let randomIndex = Int(arc4random_uniform(elements))
        return suffixArray[randomIndex]
    }
    
    //MARK: Addition Tests
    
    open func insertNewObjectAtBeginning() -> TimeInterval {
        let testElement = self.testElement()
        let time = Profiler.runClosureForTime() {
            self.suffixArray.insert(testElement, at: 0)
        }
        
        assert(suffixArray[0] == testElement, "First object was not changed!")
        suffixArray.remove(at: 0)
        assert(suffixArray[0] != testElement, "First object not back to original!")
        
        return time
    }
    
    open func insertNewObjectInMiddle() -> TimeInterval {
        let half = Float(suffixArray.count) / Float(2)
        let middleIndex = Int(ceil(half))
        let testElement = self.testElement()
        
        let time = Profiler.runClosureForTime() {
            self.suffixArray.insert(testElement, at: middleIndex)
        }
        
        assert(suffixArray[middleIndex] == testElement, "Middle object didn't change!")
        
        //Reset
        self.suffixArray.remove(at: middleIndex)
        
        assert(suffixArray[middleIndex] != testElement, "Middle object is not the same after removal!")
        
        return time
    }
    
    open func addNewObjectAtEnd() -> TimeInterval {
        let testElement = self.testElement()
        let time = Profiler.runClosureForTime() {
            self.suffixArray.append(testElement)
        }
        self.suffixArray.removeLast()
        return time
    }
    
    //MARK: Removal tests
    
    func removeFirstObject() -> TimeInterval {
        let originalFirst = suffixArray[0]
        let time = Profiler.runClosureForTime() {
            self.suffixArray.remove(at: 0)
        }
        
        assert(suffixArray[0] != originalFirst, "First object didn't change!")
        suffixArray.insert(originalFirst, at: 0)
        assert(suffixArray[0] == originalFirst, "First object is not the same after removal!")
        return time
    }
    
    func removeMiddleObject() -> TimeInterval {
        let half = Float(suffixArray.count) / Float(2)
        let middleIndex = Int(ceil(half))
        let originalMiddle = suffixArray[middleIndex]
        
        let time = Profiler.runClosureForTime() {
            self.suffixArray.remove(at: middleIndex)
        }
        
        assert(suffixArray[middleIndex] != originalMiddle, "Middle object didn't change!")
        suffixArray.insert(originalMiddle, at: middleIndex)
        assert(suffixArray[middleIndex] == originalMiddle, "Middle object is not the same after being added back!")
        
        return time
    }
    
    func removeLastObject() -> TimeInterval {
        suffixArray.append(testElement())
        return Profiler.runClosureForTime() {
            self.suffixArray.removeLast()
        }
    }
    
    //MARK: Lookup tests
    
    func lookupByIndex() -> TimeInterval {
        let elements = UInt32(suffixArray.count)
        let randomIndex = Int(arc4random_uniform(elements))
        
        let time = Profiler.runClosureForTime() {
            _ = self.suffixArray[randomIndex]
        }
        
        return time
    }
    
    func lookupByObject() -> TimeInterval {
        //Add a known object at a random index.
        let testElement = self.testElement()
        let elements = UInt32(suffixArray.count)
        let randomIndex = Int(arc4random_uniform(elements))
        suffixArray.insert(testElement, at: randomIndex)
        
        let time = Profiler.runClosureForTime() {
            let _ = self.suffixArray.first(where: {
                return $0.suffix == testElement.suffix && $0.algoName == testElement.algoName
            })
        }
        
        return time
    }
    
    // MARK: - Lookup by char sequences
    
    func searchThreeCharSequence() -> TimeInterval {
        return searchThreeCharSequence(searchCount: 10)
    }
    
    func searchThreeCharSequence(searchCount: Int) -> TimeInterval {
        
        let generator = StringGenerator()
        var searchSequences = [String]()
        for _ in 0..<searchCount {
            searchSequences.append(generator.generateRandomString(3))
        }
        
        let time = Profiler.runClosureForTime() {
            for seq in searchSequences {
                let _ = self.suffixArray.firstIndex { algoSuffix -> Bool in
                    return algoSuffix.suffix == seq
                }
            }
        }
        
        return time
    }
}
