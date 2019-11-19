//
//  ArrayViewController.swift
//  DataStructures
//
//  Created by Ellen Shapiro on 8/2/14.
//  Copyright (c) 2014 Ray Wenderlich Tutorial Team. All rights reserved.
//

private enum ArrayVCRow: Int {
    case creation = 0,
    insertAt0,
    insertAtMid,
    insertAtEnd,
    deleteAt0,
    deleteAtMid,
    deleteAtEnd,
    lookupByIndex,
    lookupByObject,
    lookupByCharSequence,
    lookupByCharSequenceRepeatCount
}

import UIKit

class ArrayViewController: DataStructuresViewController {
    
    //MARK: - Variables
    
    let arrayManipulator: ArrayManipulator = SuffixArrayManipulator(array: AlgoProvider().allSuffixSequences)
    
    var creationTime: TimeInterval = 0
    var insertAt0Time: TimeInterval = 0
    var insertAtMidTime: TimeInterval = 0
    var insertAtEndTime: TimeInterval = 0
    var removeAt0Time: TimeInterval = 0
    var removeAtMidTime: TimeInterval = 0
    var removeAtEndTime: TimeInterval = 0
    var lookupByIndexTime: TimeInterval = 0
    var lookupByObjectTime: TimeInterval = 0
    var lookupByCharSequence: TimeInterval = 0
    var lookupByCharSequenceRepeatCount: TimeInterval = 0
    
    var numberOfSearch: Int = 10
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchCountLabel: UILabel!
    //MARK: - Methods
    
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAndTestButton.setTitle("Create Array and Test", for: [])
        updateSearchCountLabel()
    }
    
    // MARK: - IBActions
    
    @IBAction func searchCountChanged(_ sender: UISlider) {
        self.numberOfSearch = Int(ceil(sender.value))
        updateSearchCountLabel()
    }
    
    // MARK: -
    
    func updateSearchCountLabel() {
        searchCountLabel.text = "Number of char sequence searches: \(self.numberFormatter.string(from: numberOfSearch as NSNumber)!)"
    }
    
    //MARK: Superclass creation/testing overrides
    
    override func create(_ size: Int) {
        creationTime = arrayManipulator.setupWithObjectCount(size)
    }
    
    override func test() {
        if (arrayManipulator.arrayHasObjects()) {
            insertAt0Time = arrayManipulator.insertNewObjectAtBeginning()
            insertAtMidTime = arrayManipulator.insertNewObjectInMiddle()
            insertAtEndTime = arrayManipulator.addNewObjectAtEnd()
            removeAt0Time = arrayManipulator.removeFirstObject()
            removeAtMidTime = arrayManipulator.removeMiddleObject()
            removeAtEndTime = arrayManipulator.removeLastObject()
            lookupByIndexTime = arrayManipulator.lookupByIndex()
            lookupByObjectTime = arrayManipulator.lookupByObject()
            lookupByCharSequence = arrayManipulator.searchThreeCharSequence()
            lookupByCharSequenceRepeatCount = arrayManipulator.searchThreeCharSequence(searchCount: numberOfSearch)
        } else {
            print("Array not set up yet!")
        }
    }
    
    //MARK: Table View Override
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 11
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        switch (indexPath as NSIndexPath).row {
        case ArrayVCRow.creation.rawValue:
            cell.textLabel!.text = "Array Creation:"
            cell.detailTextLabel!.text = formattedTime(creationTime)
        case ArrayVCRow.insertAt0.rawValue:
            cell.textLabel!.text = "Insert At Index 0:"
            cell.detailTextLabel!.text = formattedTime(insertAt0Time)
        case ArrayVCRow.insertAtMid.rawValue:
            cell.textLabel!.text = "Insert In Middle:"
            cell.detailTextLabel!.text = formattedTime(insertAtMidTime)
        case ArrayVCRow.insertAtEnd.rawValue:
            cell.textLabel!.text = "Insert At End:"
            cell.detailTextLabel!.text = formattedTime(insertAtEndTime)
        case ArrayVCRow.deleteAt0.rawValue:
            cell.textLabel!.text = "Remove From Index 0:"
            cell.detailTextLabel!.text = formattedTime(removeAt0Time)
        case ArrayVCRow.deleteAtMid.rawValue:
            cell.textLabel!.text = "Remove From Middle:"
            cell.detailTextLabel!.text = formattedTime(removeAtMidTime)
        case ArrayVCRow.deleteAtEnd.rawValue:
            cell.textLabel!.text = "Remove From End:"
            cell.detailTextLabel!.text = formattedTime(removeAtEndTime)
        case ArrayVCRow.lookupByIndex.rawValue:
            cell.textLabel!.text = "Lookup By Index:"
            cell.detailTextLabel!.text = formattedTime(lookupByIndexTime)
        case ArrayVCRow.lookupByObject.rawValue:
            cell.textLabel!.text = "Lookup By Object:"
            cell.detailTextLabel!.text = formattedTime(lookupByObjectTime)
        case ArrayVCRow.lookupByCharSequence.rawValue:
            cell.textLabel!.text = "Lookup By Char Sequence:"
            cell.detailTextLabel!.text = formattedTime(lookupByCharSequence)
        case ArrayVCRow.lookupByCharSequenceRepeatCount.rawValue:
            cell.textLabel!.text = "Lookup By Char Sequence with Count:"
            cell.detailTextLabel!.text = formattedTime(lookupByCharSequenceRepeatCount)
        default:
            print("Unhandled row! \((indexPath as NSIndexPath).row)")
        }
        
        return cell
    }
}
