//
//  UserCard.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 28/08/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

@IBDesignable class UserCard: UIView, NibLoadable {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var avatarView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupFromNib()
    }

    override func prepareForInterfaceBuilder() {
        setupFromNib()
        contentView.prepareForInterfaceBuilder()
    }
}

