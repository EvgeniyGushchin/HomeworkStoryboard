//
//  StringLocaleFormatter.swift
//  HomeworkStoryboard
//
//  Created by Evgeniy Gushchin on 15.10.2019.
//  Copyright © 2019 EG. All rights reserved.
//

import Foundation

enum SharedTextLocale: String {
    case USA = "en-US"
    case French = "fr"
    case China = "zh-Hans"
}

extension SharedTextLocale {
    init(_ localeName: String) {
        switch localeName {
        case "USA": self = .USA
        case "China": self = .China
        case "France": self = .French
        default: self = .USA
        }
    }
}
// TODO: find better name
struct StringLocaleFormatter {
    
    let dateFormatTemplate: String
    
    func replaceDates(string: String, locale: SharedTextLocale) -> String {
        let range = NSRange(string.startIndex..<string.endIndex, in: string)

        let types: NSTextCheckingResult.CheckingType = [.date]
        guard let detector = try? NSDataDetector(types: types.rawValue) else {
            return string
        }
        
        let matches = detector.matches(in: string, options: [], range: range)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: locale.rawValue)
        dateFormatter.setLocalizedDateFormatFromTemplate(dateFormatTemplate)

        let result: String = matches.reversed().reduce(into: string) { (current, result) in
            let range = Range(result.range, in: string)!
            current.replaceSubrange(range, with: dateFormatter.string(from: result.date!))
        }

        return result
    }
    
    func unitFrom(string: String) -> Unit {
        switch string {
        case "in", "in.", "inch", "inches":
            return UnitLength.inches
        case "m", "meter", "meters":
            return UnitLength.meters
        case "MM", "megameter", "megameters":
            return UnitLength.megameters
        case "mm":
            return UnitLength.millimeters
        case "cm":
            return UnitLength.centimeters
        case "km":
            return UnitLength.kilometers
        case "foot", "feet", "ft", "ft.":
            return UnitLength.feet
        case "yard", "yd", "yd.", "yards":
            return UnitLength.yards
        case "mile", "miles", "mi", "mi.":
            return UnitLength.miles
        default:
            return Unit(symbol: string)
        }
    }

    func replaceMesureUnits(string: String, locale: SharedTextLocale) -> String {
        
        guard let regExp = try? NSRegularExpression(pattern:"[-]?(\\d+([\\.,]\\d+)?)(E[+-]?\\d+)?(\\s*|-)?(<prefix>[PTGMkmunpf])?(meter(s)?|mile(s)?|m|mm|cm|km|inch(es)?|in(\\.)?|ft.?|foot|feet|yards?|yd(\\.)?|mi(\\.)?)", options: []) else {
            return string
        }
        
        let formatter  = MeasurementFormatter()
        formatter.locale = Locale(identifier: locale.rawValue)
        formatter.unitOptions = .naturalScale
        
        let range = NSRange(string.startIndex..<string.endIndex, in: string)
        let matches = regExp.matches(in: string, options: [], range: range)
        
        let result: String = matches.reversed().reduce(into: string) { (current, match) in
            
            guard let range = Range(match.range, in: string),
                let unitRange = Range(match.range(at: 6), in: string),
                let valueRange = Range(match.range(at: 1), in: string) else {
                    return
            }
            
            let valueString = string[valueRange].replacingOccurrences(of: ",", with: ".")
            guard let value = Double(valueString) else { return }
            
            let unit = unitFrom(string: String(string[unitRange]))
            let measurement = Measurement(value: value, unit: unit)
            let replaceString = formatter.string(from: measurement)
            
            current.replaceSubrange(range, with: replaceString)
        }
        
        return result
    }
}
