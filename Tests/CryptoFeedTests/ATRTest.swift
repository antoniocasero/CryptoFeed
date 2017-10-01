//
//  ATRTest.swift
//  CryptoFeed
//
//  Created by Antonio Casero Palmero on 23.09.17.
//  Copyright © 2017 Uttopia. All rights reserved.
//

import Foundation
import XCTest


class ATRTest : XCTest {
    //Source :http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:average_true_range_atr
    
    func testATRwithHistory() {
      
    }
    
    func testATRwithoutHistory() {
    
    }
    
    func testATRNotEnoughHistory() {
   
    }
    
    static var allTests = [
        ("testATRwithHistory", testRSIwithHistory),
        ("testATRwithoutHistory", testRSIwithoutHistory),
        ("testsATRNotEnoughHistory", testRSINotEnoughHistory),
        ]
}
