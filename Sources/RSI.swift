//
//  CryptoFeed.swift
//  Uttopia
//
//  Created by Antonio Casero on 27.08.17.
//  Copyright © 2017 Uttopia. All rights reserved.
//


import Foundation


public class RSI {
    
    var previousPrice : Float = 0.0
    var isFeeded = false
    
    
    public init(coin:String) {
        History.for(timeFrame:.week, coin: coin) {
            print(self.feed(history: $0.price))
        }
    }
    
    @discardableResult
    open func feed(history:[Float], iterations:Float=14) -> [Float] {
        var currentUpwardMovent = 0.0
        var average = 0.0
        //Upward movement
        var upwardMovement : [Float] = []
        var downwardMovement : [Float] = []
        history.iterateWithPrevious { (previous, current) in
            if (current > previous) {
                upwardMovement.append(current - previous)
            }
            else {
                upwardMovement.append(0.0)
            }
            
            if (previous > current) {
                downwardMovement.append(previous - current)
            }
            else {
                downwardMovement.append(0.0)
            }
        }
        
        var upwardAverage : [Float] = []
        var downwardAverage : [Float] = []
        
        let previousUpwardAverage = Array(upwardMovement[0...Int(iterations-1)]).average()
        let previousDownwardAverage = Array(downwardMovement[0...Int(iterations-1)]).average()
        
        Array(upwardMovement[Int(iterations-1)...upwardMovement.count-1]).iterateWithPrevious { (previous, current) in
            let upwardAverageValue = ((previousUpwardAverage * (iterations - 1)) + current) / iterations
            upwardAverage.append(upwardAverageValue)
        }
        
        Array(downwardMovement[Int(iterations-1)...downwardMovement.count-1]).iterateWithPrevious { (previous, current) in
            let downwardAverageValue = ((previousDownwardAverage * (iterations - 1)) + current) / iterations
            downwardAverage.append(downwardAverageValue)
        }
        
        var RS :[Float] = []
        
        for (index, up) in upwardAverage.enumerated() {
            let down = downwardAverage[index]
            RS.append(up/down)
        }
        
        let RSI = RS.map { 100 - (100/($0+1))}
        isFeeded = true
        return RSI
    }
    
    
    public func calculate(current: Coin,history:HistoryModel, length: Int) {
        if history.count >= length {
            var gainSum, lossSum, lastClose : Float
            history[0...length].forEach({ coinPeriod in
                if(lastClose != nil) {
                    if (coinPeriod.price > lastClose ) {
                        gainSum += coinPeriod - lastClose
                    }
                    else {
                        lossSum += lastClose - coinPeriod.price
                    }
                    lastClose = coinPeriod.price
                    //Save this average somewhere
                    history.priceHistory = [NSDate]
                    
                } else {
                    
                }
            })
        }
    }
    
}
