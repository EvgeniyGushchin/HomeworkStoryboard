//
//  BenchmarkViewController.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 07/09/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

class BenchmarkViewController: UIViewController, RunTimerProtocol {

    var timer: Timer?
    var isGrid = true
    
    let viewModel = BenchMarkViewModel()
    
    private let cellIDentifier = "\(BenchMarkCollectionViewCell.self)"
    private let listLayout = ListLayout()
    private let gridLayout = SomeLayout()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var runTimer = RunTimerBehavior()
        runTimer.timerAction = { [weak self] in
            self?.fireTimer()
        }
        addBehaviors(behaviors: [runTimer])
        
        collectionView.register(UINib(nibName: cellIDentifier, bundle: nil), forCellWithReuseIdentifier: cellIDentifier)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.resetAllTimers()
        collectionView.reloadData()
    }
    
    
    func setTimer(timer: Timer?) {
        self.timer = timer
    }
    
    func fireTimer() {
        viewModel.tickTimer()
        for cell in collectionView.visibleCells {
            guard let benchmarkCell = cell as? BenchMarkCollectionViewCell,
            let index = collectionView.indexPath(for: benchmarkCell) else {
                return
            }
            
            benchmarkCell.populateWith(viewModel: viewModel.viewModelForCell(indexPath: index))
        }
    }
    @IBAction func toggleLayout(_ sender: Any) {
        isGrid.toggle()
        if isGrid {
            collectionView.setCollectionViewLayout(gridLayout, animated: true)
        } else {
            collectionView.setCollectionViewLayout(listLayout, animated: true)
        }
    }
    
    @IBAction func refreshCharts(_ sender: Any) {
        for cell in collectionView.visibleCells {
            guard let benchmarkCell = cell as? BenchMarkCollectionViewCell,
            let index = collectionView.indexPath(for: benchmarkCell) else {
                return
            }
            
            benchmarkCell.refreshPieChart()
        }
    }
}

extension BenchmarkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDentifier, for: indexPath)
            as? BenchMarkCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? BenchMarkCollectionViewCell {
            cell.populateWith(viewModel: viewModel.viewModelForCell(indexPath: indexPath))
        }
    }
    
}

extension BenchmarkViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectCellAt(indexPath: indexPath)
    }
}
