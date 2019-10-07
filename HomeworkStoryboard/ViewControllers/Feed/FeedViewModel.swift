//
//  FeedViewModel.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 07/10/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

struct FeedViewModel {
    
    let dataSource = FeedDataProvider()
    
    func numberOfCells() -> Int {
        return dataSource.feedMockData().count
    }
    
    func valueForCell(indexPath: IndexPath) -> String {
        guard indexPath.row < dataSource.feedMockData().count else {
            fatalError("index out of bound")
        }
        return dataSource.feedMockData()[indexPath.row].name
    }
    
    func viewController(indexPath: IndexPath) -> UIViewController? {
        let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
        var vc: UIViewController?
        
        let name = valueForCell(indexPath: indexPath)
        
        switch name {
        case "Array":
            vc = storyboard.instantiateViewController(withIdentifier: "ArrayViewController")
        case "Set":
            vc = storyboard.instantiateViewController(withIdentifier: "SetViewController")
        case "Dictionary":
            vc = storyboard.instantiateViewController(withIdentifier: "DictionaryViewController")
        case "SuffixArray":
            // TODO
            vc = storyboard.instantiateViewController(withIdentifier: "DictionaryViewController")
        default:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "BSceneController")
        }
        return vc
    }

}
