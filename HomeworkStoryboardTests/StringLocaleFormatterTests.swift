//
//  HomeworkStoryboardTests.swift
//  HomeworkStoryboardTests
//
//  Created by Evgeniy Gushchin on 15.10.2019.
//  Copyright © 2019 EG. All rights reserved.
//

import XCTest
@testable import HomeworkStoryboard

class StringLocaleFormatterTests: XCTestCase {
    
    let formatter = StringLocaleFormatter(dateFormatTemplate: "dMMMMyEEEE")

    func testConversionUS_to_FR() {
        let string = "aaa 31.12.2019 12:00:01 16-inch +500.0 yd 100 tons"
        let result = formatter.replaceMesureUnits(string: string, locale: SharedTextLocale("France"))
         XCTAssertEqual(result, "aaa 31.12.2019 12:00:01 0,406 m +457,2 m 100 tons")
    }
    
    func testConversionFR_to_US() {
        let string = "aaa 31.12.2019 12:00:01 0,406 m +457,2 m 100 tons"
        let result = formatter.replaceMesureUnits(string: string, locale: SharedTextLocale("USA"))
         XCTAssertEqual(result, "aaa 31.12.2019 12:00:01 15.984 in +500 yd 100 tons")
    }

    func testAllConversionsUS_to_FR() {
        let string = "31.12.2019 16-inch +500.0 yards 100 tons"
        let locale = SharedTextLocale("France")
        let tmp = formatter.replaceDates(string: string, locale: locale)
        let result = formatter.replaceMesureUnits(string: tmp, locale: locale)
        XCTAssertEqual(result, "mardi 31 décembre 2019 0,406 m +457,2 m 100 tons")
    }
    
}
