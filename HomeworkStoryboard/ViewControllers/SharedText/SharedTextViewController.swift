//
//  SharedTextViewController.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 14.10.2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

class SharedTextViewController: UIViewController {

    @IBOutlet weak var sharedTextLabel: UILabel!
    
    var viewModel = SharedTextViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bindLabel(label: sharedTextLabel)
    
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification,
                                               object: nil,
                                               queue: nil,
                                               using: reloadData)
    }
    
    @IBAction func localeChanged(_ sender: UISegmentedControl) {
        if let title = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            viewModel.onLocaleChange(locale: title)
        }
    }
    
    func reloadData(notification: Notification) {
        viewModel.reloadText()
    }
}
