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
    
    let mask = PhoneMask(maskString: "+7 (000) 000 00 00")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ProfileViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // TO DO: improve delete handling
        let currentText = textField.text ?? ""
        guard let replaceRange = Range(range, in: currentText) else {
            return false
        }
        
        let replacedText = currentText.replacingCharacters(in: replaceRange, with: string)
        
        // get actual string to mask
        var textToMask: Substring
        if range.location == 0 && range.length == 1 {
            textToMask = ""
        } else {
            let cursorOffest = range.location > 0 ? range.location - range.length : 0
            let textToMaskEndIndex = replacedText.index(replacedText.startIndex, offsetBy: cursorOffest)
            textToMask = replacedText[...textToMaskEndIndex]
        }
        
        // mask ans set cursor to right position
        let masked = mask.fullAttributedMaskWithPositionOffset(string: String(textToMask))
        textField.attributedText = masked.string
        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: masked.offset) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        
        if textToMask.count == mask.maskString.count {
            textField.resignFirstResponder()
        }
        return false
    }
    
}
