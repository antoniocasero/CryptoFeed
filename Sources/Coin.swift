//
//  Crypto.swift
//  Pods-CryptoFeedSocket
//
//  Created by Antonio Casero Palmero on 27.08.17.
//

import Foundation

public struct Coin {
    struct Id {
        let marketId:String
        let name: String
        let longName: String
    }
    struct Trade {
        let exhange: String
        let volume: Int
    }
    
    let id : Id
    let price : Float
    let change24 : Float
    let marketCapitalization: Float
    let volume24: Int
    let supply: Int
    let trade: Trade
    
    init(dic: [String: AnyObject]) {
        
        guard let tradeInfo = dic["trade"] as? [String: AnyObject],
            let tradeDic = tradeInfo["data"],
            let messageDic = dic["msg"]
            else {
                fatalError("Error parsing the structure of the object")
        }
        
        guard let _marketId = tradeDic["market_id"] as? String,
            let _exhange = tradeDic["exchange_id"] as? String,
            let _price = messageDic["price"] as? Float,
            let _change24 = messageDic["cap24hrChange"] as? Float,
            let _lname = messageDic["long"] as? String,
            let _supply = messageDic["supply"] as? Int,
            let _mCap = messageDic["mktcap"] as? Float,
            let _name = dic["coin"] as? String,
            let _volume = messageDic["volume"] as? Int
            else {
                fatalError("Error parsing the object")
        }
        
        let id = Id(marketId: _marketId, name: _name, longName: _lname )
        let trade  = Trade(exhange: _exhange , volume: _volume )
        self.price = _price
        self.change24 = _change24
        self.marketCapitalization = _mCap
        self.volume24 = _volume
        self.supply = _supply
        self.trade = trade
        self.id = id
    }
}

extension Coin: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "[\(self.id.name)] \(self.id.longName): \(self.price) - it has a 24 h change rate: \(change24), volume: \(volume24)"
    }
}
