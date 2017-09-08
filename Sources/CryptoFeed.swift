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
    
    public var preferableCoins : [String] = []
    public var currentStatus : [String : Coin] = [:]
    public var historyStatus : [String : [Coin]] = [:]
    

    private var allCoins: [String : Coin] = [:]
    private var socket : SocketIOClient
    
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
                self.allCoins[crypto.id.name] = crypto
                if (!self.preferableCoins.isEmpty && !self.preferableCoins.contains(crypto.id.name)) {
                    return
                }
                self.currentStatus[crypto.id.name] = crypto
                self.addToHistory(crypto, each: TimeInterval(60))
                input(crypto)
            }
        }
        socket.connect()
    }
    
    open func closeConnection() {
        socket.disconnect()
    }
    
    open func topCoins(limit:Int, by property:coinProperties) -> [Coin] {
        
        var sortArray:[Coin] = []
        switch property {
        case .volume:
            sortArray = Array(self.allCoins.values).sorted { $0.0.volume24 > $0.1.volume24 }
        case .gain:
            sortArray = Array(self.allCoins.values).sorted { $0.0.change24 > $0.1.change24 }
        case .marketCap:
            sortArray = Array(self.allCoins.values).sorted {
                $0.0.marketCapitalization > $0.1.marketCapitalization
            }
        }
        let subArray : [Coin] = Array(sortArray[0...limit])
        return subArray
    }
    
    func addToHistory(_ coin:Coin, each seconds:TimeInterval) {
        if let lastUpdate = self.historyStatus[coin.id.name]?.last?.timeStamp {
            if(Date().timeIntervalSince(lastUpdate) > TimeInterval(seconds)) {
                self.historyStatus.appending(coin.id.name,coin)
            }
        } else {
            self.historyStatus.appending(coin.id.name,coin)
        }
    }
    
    deinit {
        socket.disconnect()
    }
}


public enum Result<Value> {
    case success(Value)
    case failure(Error?)
}
