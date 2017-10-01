//
//  ATR.swift
//  CryptoIndicators
//
//  Created by Antonio Casero Palmero on 10.09.17.
//  Copyright © 2017 Uttopia. All rights reserved.
//
//  http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:average_true_range_atr

import Foundation

public class ATR : Indicator {
    public var indicatorString: String = "ATR"
    var valuesTR : [Double] = []
    let TRIndicator : TR
    let periods: Int
    let lengh: TimeInterval
    public init(periods: Int, lengh: TimeInterval = 3600){
        self.periods = periods
        self.lengh = lengh
        self.TRIndicator = TR(periods:periods, lengh: lengh)
    }
    //TimeInterval define the time pairs inside lookback to calculate open/close
    public func calculate(_ values: [(Date, Double)], previousATR: Double?) -> Double? {
        let periodsArray = groupByDate(lookup: values, seconds: Int(lengh))
        guard periodsArray.count > periods else {
            return nil
        }
        let currentTR = self.TRIndicator.calculateTR(periodValues: periodsArray)
        print("Enought info to calculate ATR");
        
        if let previousATR = previousATR, let tr = currentTR {
            let currentATR = ((previousATR * (Double(periods) - 1)) * tr) / Double(periods)
            print("Calculated ATR: \(currentATR), with previous ATR \(previousATR) and current TR: \(tr)")
            return currentATR
        }
        return nil
    }
    
    public func groupByDate(lookup:[(Date,Double)], seconds:Int)->[PeriodValues] {
        //Period come in seconds
        var baseline : (Date, Double)? = nil
        var result : [PeriodValues] = []
        for (date, price) in lookup {
            guard let _baseline = baseline else {
                baseline = (date, price)
                continue
            }
            if (_baseline.0.seconds(from: date) > seconds) {
                let hprice = max(price, _baseline.1)
                let lprice = min(price, _baseline.1)
                let periodValue = PeriodValues(hprice,lprice,_baseline.0)
                result.append(periodValue)
                baseline=nil
            }
        }
        return result
    }
    
}

