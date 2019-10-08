//
//  ViewController.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 28/08/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    weak var delegate: UIViewController?
        
    @IBOutlet weak var phoneNumberField: UITextField!
    //    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mask = PhoneMask(maskString: "+7 (000) 000 00 00")
        var formatted = mask.mask(string: "95")
        for i in 0..<6 {
            let next2 = formatted + "\(i)"
            formatted = mask.mask(string: next2)
        }
        phoneNumberField.attributedText = mask.fullAttributedMask(string: "8782gg77")
//        addBehaviors(behaviors: [NightModeBehavior()])
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.text = "+7 ("
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
}
