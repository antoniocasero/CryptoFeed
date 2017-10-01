//
//  ATRTest.swift
//  CryptoFeed
//
//  Created by Antonio Casero Palmero on 23.09.17.
//  Copyright © 2017 Uttopia. All rights reserved.
//

import Foundation
import CryptoFeed
import XCTest


class ATRTest : XCTest {
    //Source: http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:average_true_range_atr
    let values = [PeriodValues(48.70,47.79,Date()),
    PeriodValues(48.72,48.14, Date()),
    PeriodValues(48.90,48.39, Date()),
    PeriodValues(48.87,48.37, Date()),
    PeriodValues(48.82,48.24, Date()),
    PeriodValues(49.05,48.64, Date()),
    PeriodValues(49.20,48.94, Date()),
    PeriodValues(49.35,48.86, Date()),
    PeriodValues(49.92,49.50, Date()),
    PeriodValues(50.19,49.87, Date()),
    PeriodValues(50.12,49.20, Date()),
    PeriodValues(49.66,48.90, Date()),
    PeriodValues(49.88,49.43, Date()),
    PeriodValues(50.19,49.73, Date()),
    PeriodValues(50.36,49.26, Date()),
    PeriodValues(50.57,50.09, Date()),
    PeriodValues(50.65,50.30, Date()),
    PeriodValues(50.43,49.21, Date()),
    PeriodValues(49.63,48.98, Date()),
    PeriodValues(50.33,49.61, Date()),
    PeriodValues(50.29,49.20, Date()),
    PeriodValues(50.17,49.43, Date()),
    PeriodValues(49.32,48.08, Date()),
    PeriodValues(48.50,47.64, Date()),
    PeriodValues(48.32,41.55, Date()),
    PeriodValues(46.80,44.28, Date()),
    PeriodValues(47.80,47.31, Date()),
    PeriodValues(48.39,47.20, Date()),
    PeriodValues(48.66,47.90, Date()),
    PeriodValues(48.79,47.73, Date())]
    func testATRwithHistory() {
      
    }
    
    func testATRwithoutHistory() {
    
    }
    
    func testATRNotEnoughHistory() {
   
    }
    
    static var allTests = [
        ("testATRwithHistory", testATRwithHistory),
        ("testATRwithoutHistory", testATRwithoutHistory),
        ("testsATRNotEnoughHistory", testATRNotEnoughHistory),
        ]
}
