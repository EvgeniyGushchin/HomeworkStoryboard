//
//  FeedViewModel.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 28.10.2019.
//  Copyright © 2019 EG. All rights reserved.
//

import Foundation

struct FeedViewModel {
    
    let dataSource: FeedDataSource
    
    init(dataSource: FeedDataSource = SimpleDataSource(numberOfElements: 2)) {
        self.dataSource = dataSource
    }
    
    func numberOfCells() -> Int {
        return dataSource.numberOfElements
    }
    
    func titleForCell(index: IndexPath) -> String {
         
        return "Item \(index.row)"
    }
}
