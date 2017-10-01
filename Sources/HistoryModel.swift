//
//  CryptoFeed.swift
//  Uttopia
//
//  Created by Antonio Casero on 27.08.17.
//  Copyright © 2017 Uttopia. All rights reserved.
//


import Foundation

public struct HistoryModel {

    let marketCapHistory : [[Int]]
    let priceHistory : [[Double]]
    let coinName : String
    let price: [Double]

    init(name:String,dic:[String:Any]) {
        guard let priceArray = dic["price"] as? [[Double]], let marketCapArray = dic["market_cap"] as? [[Int]] else {
            fatalError()
        }
        self.coinName = name
        self.marketCapHistory = marketCapArray
        self.priceHistory = priceArray
        self.price = priceArray.map({ return $0[1] }).flatMap{$0}
    }
}


