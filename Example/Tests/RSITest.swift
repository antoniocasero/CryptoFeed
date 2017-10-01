//
//  RSITest.swift
//  CryptoFeed
//
//  Created by Antonio Casero Palmero on 23.09.17.
//  Copyright © 2017 Uttopia. All rights reserved.
//

import Foundation
import XCTest
import CryptoFeed


class CryptoIndicatorsTests: XCTestCase {
    //Source :http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:relative_strength_index_rsi
    var values = [44.34,44.09,44.15,43.61,44.33,44.83,45.10,45.42,45.84,46.08,45.89,46.03,45.61,46.28,46.28,46.00,46.03,46.41,46.22,45.64,46.21,46.25,45.71,46.45,45.78,45.35,44.03,44.18,44.22,44.57,43.42,42.66,43.13]
    func testRSIwithHistory() {
        let market = MarketCoin.shared
        market.lookback["BTC"] = values.map{ (Date(),$0) }
        market.average["BTC"] = Average(averageGain:0.97, averageLoss:0.31)
        let rsi = RSI()
        let rsiValue = rsi.calculate(coin: "BTC", periods: 14)
        XCTAssertEqual(Int(rsiValue!), 76)
    }
    
    func testRSIwithoutHistory() {
        let market = MarketCoin.shared
        market.lookback["XTC"] = Array(values[0...15]).map{ (Date(),$0) }
        let rsi = RSI()
        let rsiValue = rsi.calculate(coin: "XTC",periods: 14)
        XCTAssertEqual(Int(rsiValue!), 70)
    }
    
    func testRSINotEnoughHistory() {
        let market = MarketCoin.shared
        market.lookback["BTC"] = Array(values[0...3]).map{ (Date(),$0) }
        let rsi = RSI()
        let rsiValue = rsi.calculate(coin: "BTC", periods: 14)
        XCTAssertNil(rsiValue)
    }
    
    static var allTests = [
        ("testRSIwithHistory", testRSIwithHistory),
        ("testRSIwithoutHistory", testRSIwithoutHistory),
        ("testRSINotEnoughHistory", testRSINotEnoughHistory),
        ]
}
