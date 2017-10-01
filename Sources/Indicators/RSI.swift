//
//  RSI.swift
//  Pods
//
//  Created by Antonio Casero Palmero on 08.09.17.
//
//

import Foundation

public class RSI: Indicator {
    public var indicatorString: String = "RSI"
    let periods: Int
    public init(periods:Int){
        self.periods = periods
    }
    
    //Dependency with RS.
    public func calculate(average: Average) -> Double {
        let rs = average.averageGain / average.averageLoss
        return 100 - (100 / (1 + rs))
    }
    
}
