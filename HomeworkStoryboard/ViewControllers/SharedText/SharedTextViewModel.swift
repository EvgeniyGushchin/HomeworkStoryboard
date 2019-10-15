//
//  SharedTextViewModel.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 14.10.2019.
//  Copyright © 2019 EG. All rights reserved.
//

import UIKit


struct SharedTextViewModel {
    
    let formatter = StringLocaleFormatter(dateFormatTemplate: "dMMMMyEEEE")
    
    private weak var textLabel: UILabel? {
        didSet {
            updateTextLabel(locale: selectedLocale)
        }
    }
    private var sharedText = ""
    private var selectedLocale = SharedTextLocale("USA")
    
    init() {
        reloadText()
    }
    
    mutating func reloadText() {
        let sharedDefaults = UserDefaults(suiteName: "group.com.egushchin.HomeworkStoryboard")
        self.sharedText = sharedDefaults?.string(forKey: "Shared Text") ?? ""
        updateTextLabel(locale: selectedLocale)
    }
    
    
    mutating func onLocaleChange(locale: String) {
        selectedLocale = SharedTextLocale(locale)
        updateTextLabel(locale: selectedLocale)
    }
    
    mutating func setSharedText(string: String) {
        sharedText = string
    }
    
    mutating func bindLabel(label: UILabel) {
        textLabel = label
    }
    
    private func updateTextLabel(locale: SharedTextLocale) {
        let tmpStr = formatter.replaceDates(string: sharedText, locale: locale)
        textLabel?.text = formatter.replaceMesureUnits(string: tmpStr, locale: locale)
    }
    
}
