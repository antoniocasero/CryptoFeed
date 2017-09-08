//
//  History.swift
//  CryptoFeed
//
//  Created by Antonio Casero Palmero on 31.08.17.
//  Copyright © 2017 Uttopia. All rights reserved.
//

import Foundation

public struct History {
    
    public enum historyTime : String {
        case day = "1day"
        case week = "7day"
        case month = "30day"
        case trimeseter = "90day"
        case halfyear = "180day"
        case year = "360day"
    }
    
    public static func `for`(timeFrame:historyTime, coin:String, completion: @escaping (HistoryModel) -> ()) {
        let request = URLRequest(url: URL(string: "http://www.coincap.io/history/\(timeFrame.rawValue)/\(coin)")!)
        Network.rawRequest(request) { result in
            switch result {
            case .success(let dic): completion(HistoryModel(name: coin, dic:dic))
            case .failure(_): print("Error")
            }
        }
    }
}
