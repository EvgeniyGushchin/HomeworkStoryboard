//
//  NibLoadable.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 30/08/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

protocol NibLoadable where Self: UIView {
    var contentView: UIView! {get}
}

extension NibLoadable {
    
    @discardableResult func loadNib() -> UINib {

        let name = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        nib.instantiate(withOwner: self, options: nil)
        return nib
    }
    
    func setupFromNib() {
        loadNib()
        addSubview(contentView, constrainedTo: self)
    }
}
