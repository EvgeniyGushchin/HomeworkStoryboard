//
//  BenchMarkCollectionViewCell.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 14/09/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

@IBDesignable class BenchMarkCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timerLabel: UILabel!
    
    var isPaused = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateWith(viewModel: BenchmarkCellViewModel) {
        timerLabel.text = viewModel.timerValue()
    }
}
