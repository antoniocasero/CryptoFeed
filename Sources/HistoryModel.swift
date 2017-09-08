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
    let priceHistory : [[Float]]
    let coinName : String
    let price: [Float]

    init(name:String,dic:[String:Any]) {
        guard let priceArray = dic["price"] as? [[Float]], let marketCapArray = dic["market_cap"] as? [[Int]] else {
            fatalError()
        }
        self.coinName = name
        self.marketCapHistory = marketCapArray
        self.priceHistory = priceArray
        self.price = priceArray.map({ return $0[1] }).flatMap{$0}
    }
}


