//
//  CoinCollection.swift
//  CryptoFeed
//
//  Created by Antonio Casero Palmero on 22.09.17.
//

import Foundation

struct CoinCollection {
    
    typealias CoinCollection = [String : [Coin]]
    
    // Underlying, private storage, that is the same type of dictionary
    // that we previously was using at the call site
    private var market = CoinCollection()
    
    // Enable our collection to be initialized with a dictionary
    init(coins: CoinCollection) {
        self.market = coins
    }
}

extension CoinCollection: Collection {
//     Required nested types, that tell Swift what our collection contains
    typealias Index = CoinCollection.Index
    typealias Element = CoinCollection.Element
    
    // The upper and lower bounds of the collection, used in iterations
    var startIndex: Index { return market.startIndex }
    var endIndex: Index { return market.endIndex }
    
    // Required subscript, based on a dictionary index
    subscript(index: Index) -> Iterator.Element {
        get { return market[index] }
    }
    
    // Method that returns the next index when iterating
    func index(after i: Index) -> Index {
        return market.index(after: i)
    }
}

extension CoinCollection {
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
        init(hPrice:Double, lPrice:Double, timestamp:Date = Date()) {
            highPrice = hPrice
            lowPrice = lPrice
            timeStamp = timestamp
        }
    }
}
