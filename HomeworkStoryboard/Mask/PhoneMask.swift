//
//  PhoneMask.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 08/10/2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit

fileprivate struct Constants {
    static let letterMaskCharacter: Character = "A"
    static let numberMaskCharacter: Character = "0"
    static let alphanumericMaskCharacter: Character = "*"
}


struct PhoneMask {
    
    let maskString: String
    
    var textAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor : UIColor.black
    ]
    
    var placeholderAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor : UIColor.lightGray
    ]
    
    func mask(string: String) -> String {
        
        var formattedString = ""
        var maskIndex = 0
        
        for char in string {
            if maskString.index(maskString.startIndex, offsetBy: maskIndex) == maskString.endIndex {
                break
            }

            var maskCharacter = maskString[maskString.index(maskString.startIndex, offsetBy: maskIndex)]
            if maskCharacter == char {
                formattedString.append(char)
                maskIndex += 1
            }
            else {
                while maskCharacter != Constants.numberMaskCharacter {
                    formattedString.append(maskCharacter)
                    maskIndex += 1
                    maskCharacter = maskString[maskString.index(maskString.startIndex, offsetBy: maskIndex)]
                }
                if isValidNumberCharacter(char) {
                    formattedString.append(char)
                    maskIndex += 1
                }
            }
        }
        return formattedString
    }
    
    func fullAttributedMask(string: String) -> NSAttributedString {
        let masked = mask(string: string)
        let attributedString = NSMutableAttributedString(string: masked, attributes: textAttributes)
        autocompleteWithPlaceholder(masked: masked, attributed: attributedString)
        return attributedString
    }
    
    private func autocompleteWithPlaceholder(masked: String, attributed: NSMutableAttributedString) {
        if maskString.count > attributed.length {
            let placeholderRange = rangeOfPlaceholder(masked: masked)
            let placeholderString = maskString[placeholderRange]
            let placeholder = NSAttributedString(string: String(placeholderString), attributes: placeholderAttributes)
            attributed.append(placeholder)
        }
    }
    
    private func rangeOfPlaceholder(masked: String) -> Range<String.Index> {
        let startIndex = masked.endIndex
        let endIndex = maskString.index(startIndex, offsetBy: maskString.count - masked.count)
        return startIndex..<endIndex
    }
    
    private func isValidNumberCharacter(_ character: Character) -> Bool {
        
        let string = String(character)
        if string.unicodeScalars.count > 1 {
            return false
        }
        
        let lettersSet = NSCharacterSet.decimalDigits
        let unicodeScalars = string.unicodeScalars
        return lettersSet.contains(unicodeScalars[unicodeScalars.startIndex])
    }
}
