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
    
    public enum historyTime : String {
        case day = "1day"
        case week = "7day"
        case month = "30day"
        case trimeseter = "90day"
        case halfyear = "180day"
        case year = "360day"
    }
    
    public enum coinProperties  {
        case volume
        case gain
        case marketCap
    }
    
    public var preferableCoins : [String] = []
    public typealias AsyncOperation = (Result<[String : Any]>) -> Void
    public var currentStatus : [String : Coin] = [:]
    
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
                input(crypto)
            }
        }
        socket.connect()
    }
    
    open func closeConnection() {
        socket.disconnect()
    }
    
    open func history(timeFrame:historyTime, coin:String, completion: @escaping (History) -> ()) {
        let request = URLRequest(url: URL(string: "http://www.coincap.io/history/\(timeFrame.rawValue)/\(coin)")!)
        rawRequest(request) { result in
            switch result {
            case .success(let dic): completion(History(name: coin, dic:dic))
            case .failure(_): print("Error")
            }
        }
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
    
    private func rawRequest(_ request: URLRequest, completion: @escaping AsyncOperation) {
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, let _ = response else {
                return completion(.failure(error!))
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String : AnyObject] else {
                    return completion(.failure(nil))
                }
                if let errorArray = json["error"] as? [String] {
                    if !errorArray.isEmpty {
                        return completion(.failure(nil))
                    }
                }
                return completion(.success(json))
                
            } catch _ {
                return completion(.failure(nil))
            }
            
            }.resume()
    }
    
    deinit {
        socket.disconnect()
    }
}


public enum Result<Value> {
    case success(Value)
    case failure(Error?)
}
