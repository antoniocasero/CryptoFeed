//
//  CryptoFeed.swift
//  Uttopia
//
//  Created by Antonio Casero on 27.08.17.
//  Copyright © 2017 Uttopia. All rights reserved.
//

import Foundation
import SocketIO


open class CryptoFeed {

    public enum coinProperties  {
        case volume
        case gain
        case marketCap
    }
    

    private var socket : SocketIOClient
    private var market = MarketCoin.shared
    
    public init() {
        socket = SocketIOClient(socketURL: URL(string: "http://socket.coincap.io")!, config: [.log(false), .compress])
    }
    
    open func fetch(_ input: @escaping (Coin)->()) {
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on("trades") { (data, _) in
            if let dic = data.first as? [String: AnyObject] {
                let crypto = Coin(dic: dic)
                self.market.allCoins[crypto.id.name] = crypto
                if (!self.market.preferableCoins.isEmpty && !self.market.preferableCoins.contains(crypto.id.name)) {
                    return
                }
                self.market.currentStatus[crypto.id.name] = crypto
                self.market[crypto.id.name] = crypto.price
                self.addToHistory(crypto, each: TimeInterval(60))
                input(crypto)
            }
        }
        socket.connect()
    }
    
    open func closeConnection() {
        socket.disconnect()
    }
    
    open func preferableCoins(_ coins:[String]) {
        market.preferableCoins = coins
    }
    
    open func topCoins(limit:Int, by property:coinProperties) -> [Coin] {
        
        var sortArray:[Coin] = []
        switch property {
        case .volume:
            sortArray = market.allCoins.values.sorted { $0.volume24 > $1.volume24 }
        case .gain:
            sortArray = market.allCoins.values.sorted { $0.change24 > $1.change24 }
        case .marketCap:
            sortArray = market.allCoins.values.sorted {
                $0.marketCapitalization > $1.marketCapitalization
            }
        }
        let subArray : [Coin] = Array(sortArray[0...limit])
        return subArray
    }
    
    func addToHistory(_ coin:Coin, each seconds:TimeInterval) {
        var mutableArray = self.market.historyStatus[coin.id.name]
        if let lastUpdate = self.market.historyStatus[coin.id.name]?.last?.timeStamp {
            if(Date().timeIntervalSince(lastUpdate) > TimeInterval(seconds)) {
                mutableArray?.append(coin)
            }
        } else {
            mutableArray?.append(coin)
        }
        self.market.historyStatus[coin.id.name] = mutableArray
    }
    
    deinit {
        socket.disconnect()
    }
}


public enum Result<Value> {
    case success(Value)
    case failure(Error?)
}
