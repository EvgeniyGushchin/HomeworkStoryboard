//
//  BenchMarkViewModel.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 14/09/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import Foundation

struct BenchMarkViewModel {
    
    let dataSource = [
        BenchmarkCellViewModel(),
        BenchmarkCellViewModel(),
        BenchmarkCellViewModel(),
        BenchmarkCellViewModel(),
        BenchmarkCellViewModel(),
        BenchmarkCellViewModel(),
        BenchmarkCellViewModel(),
        BenchmarkCellViewModel(),
        BenchmarkCellViewModel(),
        BenchmarkCellViewModel(),
        BenchmarkCellViewModel(),
        BenchmarkCellViewModel(),
        BenchmarkCellViewModel(),
        BenchmarkCellViewModel()
    ]
    
    func viewModelForCell(indexPath: IndexPath) -> BenchmarkCellViewModel {
        guard indexPath.row < dataSource.count else {
            fatalError("index out of bound")
        }
        return dataSource[indexPath.row]
    }
    
    func numberOfCells() -> Int {
        return dataSource.count
    }
    
    func selectCellAt(indexPath: IndexPath) {
        guard indexPath.row < dataSource.count else {
            fatalError("index out of bound")
        }
        dataSource[indexPath.row].toggleTimer()
    }
    
    func tickTimer() {
        for model in dataSource {
            model.tickTimer()
        }
    }
    
    func resetAllTimers() {
        for model in dataSource {
            model.resetTimer()
        }
    }
}


class BenchmarkCellViewModel {
    
    private var timer = 0
    private var isPaused = false
    
    func timerValue() -> String {
        let hours = timer / 3600
        let minutes = (timer / 60) % 60
        let seconds = timer % 60
        return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
    
    func tickTimer() {
        if isPaused {
            return
        }
        timer += 1
    }
    
    func resetTimer() {
        timer = 0
    }
    
    func toggleTimer() {
        isPaused = !isPaused
    }
}
