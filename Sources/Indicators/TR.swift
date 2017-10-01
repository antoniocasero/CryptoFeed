//
//  TR.swift
//  CryptoFeed
//
//  Created by Antonio Casero Palmero on 26.09.17.
//

import Foundation


public class TR : Indicator {
    
    let periods: Int
    let lengh: TimeInterval
    public var indicatorString: String = "TR"

    
    public init(periods:Int, lengh: TimeInterval){
        self.periods = periods
        self.lengh = lengh
    }
    public func calculateTR(periodValues:[PeriodValues]) -> Double? {
        //At the begining it's just the absolute value of the last 14 days (periods)
        guard periodValues.count > periods else {
            return nil
        }
        
        let tr =  Array(periodValues[periodValues.count-1-periods...periodValues.count-1]).map{$0.TR1}
            .reduce(0, +)/Double(periods)
        return tr
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
