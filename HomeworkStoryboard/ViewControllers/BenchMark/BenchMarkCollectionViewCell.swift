//
//  BenchMarkCollectionViewCell.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 14/09/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit
import MyHomeWorkUIKit

@IBDesignable class BenchMarkCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    
    private var canRefreshChart = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pieChartView.animated = false
    }
    
    func populateWith(viewModel: BenchmarkCellViewModel) {
        timerLabel.text = viewModel.timerValue()
        if canRefreshChart {
            pieChartView.segments = viewModel.chartSegments()
            canRefreshChart = false
        }
    }
    
    func refreshPieChart() {
        pieChartView.animated = true
        canRefreshChart = true
    }
}
