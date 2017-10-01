//
//  Indicator.swift
//  Pods
//
//  Created by Antonio Casero Palmero on 08.09.17.
//
//

import Foundation


public protocol Indicator {
var indicatorString: String { get set }
}

extension Indicator {
    public var market : MarketCoin? {
        get { return MarketCoin.shared }
    }
 
}
