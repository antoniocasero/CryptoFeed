//
//  History.swift
//  Pods
//
//  Created by Antonio Casero Palmero on 29.08.17.
//
//

import Foundation

public struct History {

    let marketCapHistory : [[Int]]
    let priceHistory : [[Int]]
    let coinName : String
    
    init(name:String,dic:[String:Any]) {
        guard let priceArray = dic["price"] as? [[Int]], let marketCapArray = dic["market_cap"] as? [[Int]] else {
            fatalError()
        }
        self.coinName = name
        self.marketCapHistory = marketCapArray
        self.priceHistory = priceArray
    }
}
