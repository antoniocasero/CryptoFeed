//
//  ViewController.swift
//  Example
//
//  Created by Antonio Casero Palmero on 30.08.17.
//  Copyright © 2017 Antonio Casero Palmero. All rights reserved.
//

import UIKit
import CryptoFeed

class ViewController: UIViewController {
    
    var feed : CryptoFeed = CryptoFeed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //If you want to observe some of the coins, keep it empty to get all of them.
        feed.preferableCoins(["BTC", "ETH", "LTC"])
        //Start ticking
        feed.fetch {
            print($0)
            print("RSI \($0.id.name) : \(String(describing: rsi))")
        }
        //You get the history of the coin, mainly for charts.
//        feed.history(timeFrame: .week, coin: "BTC") { print($0) }
        
        
        Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { (_) in
//            print("The current status of your selected coins \(self.feed.historyStatus)")
            print("TOP : \(self.feed.topCoins(limit: 3, by: .gain))")
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

