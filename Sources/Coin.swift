//
//  Crypto.swift
//  Pods-CryptoFeedSocket
//
//  Created by Antonio Casero Palmero on 27.08.17.
//

import Foundation

public struct Coin {
    public struct Id {
        public let marketId:String
        public let name: String
        public let longName: String
    }
    public struct Trade {
        let exhange: String
        let volume: Double
    }
    
    public let id : Id
    public let price : Double
    public let change24 : Double
    public let marketCapitalization: Double
    let volume24: Double
    let supply: Int
    let trade: Trade
    let timeStamp : Date
    
    init(dic: [String: AnyObject]) {
        
        guard let tradeInfo = dic["trade"] as? [String: AnyObject],
            let tradeDic = tradeInfo["data"],
            let messageDic = dic["msg"]
            else {
                fatalError("Error parsing the object structure")
        }
        
        guard let _marketId = tradeDic["market_id"] as? String,
            let _exhange = tradeDic["exchange_id"] as? String,
            let _price = messageDic["price"] as? Double,
            let _change24 = messageDic["cap24hrChange"] as? Double,
            let _lname = messageDic["long"] as? String,
            let _supply = messageDic["supply"] as? Int,
            let _mCap = messageDic["mktcap"] as? Double,
            let _volume = messageDic["volume"] as? Double else{
                fatalError("Error parsing the object")
        }
        
        guard let _name = dic["coin"] as? String else {
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
        self.timeStamp = Date()
    }
}

extension Coin: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "[\(timeStamp)][\(self.id.name)] \(self.id.longName): \(self.price) - it has a 24 h change rate: \(change24), volume: \(volume24)"
    }
}
