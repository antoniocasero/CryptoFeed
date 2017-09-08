//
//  Market.swift
//  Pods
//
//  Created by Antonio Casero Palmero on 03.09.17.
//
//

import Foundation

class Market  {

    public struct MarketTick {
        
        var price: Double
        let timestamp: TimeInterval = Date().timeIntervalSince1970
        var averageGain: Double
        var averageLoss: Double
        var previousPrice: Double?
        
        
        init(price: Double, avgGain: Double = 0.0, avgLoss:Double = 0.0) {
            self.price = price
            self.averageGain = avgGain
            self.averageLoss = avgLoss
        }
    }
    
    var history: [String : MarketTick] = [:]
    
    subscript(coin:String) -> MarketTick {
        get {
            return self.history[coin] ?? MarketTick(price:0.0)
        }
        
        set (newValue) {
            self.history[coin] = newValue
        }
    }
}
