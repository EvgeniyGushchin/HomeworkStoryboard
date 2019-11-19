//
//  FeedDataSource.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 28.10.2019.
//  Copyright © 2019 EG. All rights reserved.
//

import Foundation

protocol FeedDataSource {
    var numberOfElements: Int { get }
}

struct SimpleDataSource: FeedDataSource {
    
    var numberOfElements: Int = 20
    
}
