//
//  FeedViewController.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 14/09/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    let viewModel = FeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") else {
            fatalError("couldn't deque FeedCell")
        }
        cell.textLabel?.text = viewModel.titleForCell(index: indexPath)
        return cell
    }
    
    
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SessionSummaryViewController")
        vc.title = "Item \(indexPath.row)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
