//
//  RS.swift
//  CryptoFeed
//
//  Created by Antonio Casero Palmero on 26.09.17.
//

import Foundation

public class RS: Indicator {
    public var indicatorString: String = "RS"
    let periods: Int

    public init(periods: Int){
        self.periods = periods
    }
    
    public func calculateAverage(_ values: [Double], _ previousAverage: Average?) -> Average {
        if let previousAverage = previousAverage {
            let current = values[values.count - 1]
            let previous = values[values.count - 2]
            let currentGain = ((current - previous) > 0) ? (current-previous) : 0.0
            let avgGain = ((previousAverage.averageGain * (Double(periods) - 1)) + currentGain)/Double(periods)
            let currentLoss = (previous - current > 0) ? (previous - current) : 0.0
            let avgLoss = ((previousAverage.averageLoss * (Double(periods) - 1)) + currentLoss)/Double(periods)
            print("Gain: \(avgGain) - Loss: \(avgLoss)")
            return Average(averageGain: avgGain, averageLoss: avgLoss)
        }
        else {
            var gainSum, lossSum, lastClose : Double
            gainSum = 0.0
            lossSum = 0.0
            lastClose = 0.0
            values[0...periods].forEach({ pricePeriod in
                if(lastClose > 0 ) {
                    if (pricePeriod > lastClose ) {
                        gainSum += pricePeriod - lastClose
                    }
                    else {
                        lossSum += lastClose - pricePeriod
                    }
                }
                print("Gain: \(gainSum/Double(periods)) - Loss: \(lossSum/Double(periods))")
                lastClose = pricePeriod
            })
            return  Average(averageGain: gainSum/Double(periods), averageLoss: lossSum/Double(periods))
        }
    }
}
