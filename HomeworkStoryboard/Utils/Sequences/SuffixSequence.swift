//
//  SuffixSequence.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 07/10/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import Foundation

struct SuffixIterator: IteratorProtocol {
    let string: String
    var last: String.Index
    var offset: String.Index
    
    init(string: String) {
        self.string = string
        self.last = string.endIndex
        self.offset = string.startIndex
    }
    
    mutating func next() -> Substring? {
        guard offset < last else {
            return nil
        }
        
        let sub = string.suffix(from: offset)
        string.formIndex(after: &offset)
        return sub
    }
}

struct SuffixSequence: Sequence {
    let string: String
    
    func makeIterator() -> SuffixIterator {
        return SuffixIterator(string: string)
    }
}