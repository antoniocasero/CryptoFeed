//
//  MarketCoin.swift
//  CryptoFeed
//
//  Created by Antonio Casero Palmero on 14.09.17.
//

import Foundation

public struct Average: CustomDebugStringConvertible {
    public var averageGain: Double
    public var averageLoss: Double
    public var debugDescription: String {
        return "Average( Gain: \(averageGain), Loss: \(averageLoss))"
    }
    public init(averageGain: Double, averageLoss: Double) {
        self.averageGain = averageGain
        self.averageLoss = averageLoss
    }
    
}
public struct PeriodValues {
    public var highPrice: Double
    public var lowPrice: Double
    public let timeStamp : Date
    public var TR1: Double {
        get {
            return fabs(highPrice-lowPrice)
        }
    }
    public init(_ hPrice:Double, _ lPrice:Double, _ timestamp:Date = Date()) {
        highPrice = hPrice
        lowPrice = lPrice
        timeStamp = timestamp
    }
}

public final class MarketCoin {

    private init() { }
    
    public static let shared = MarketCoin()
    public var lookback: [String: [(Date,Double)]] = [:]
    public var average: [String: Average] = [:]
    public var ATR: [String : [Double]] = [:]
    public var preferableCoins : [String] = []
    public var currentStatus : [String : Coin] = [:]
    public var historyStatus : [String : [Coin]] = [:]
    
    
    
    public var allCoins: [String : Coin] = [:]
    
    func addCoin(_ coin: Coin){
        self[coin.id.name] = coin.price
    }
    
}

extension MarketCoin {
    subscript(coin: String) -> Double {
        get {
            if let lastValue = self.lookback[coin]?.last?.1 {
                return lastValue
            }
            return 0.0
        }
        set {
            var mutableArray = self.lookback[coin] ?? []
            mutableArray.append((Date(),newValue))
            self.lookback[coin] = mutableArray
        }
    }
    
}
