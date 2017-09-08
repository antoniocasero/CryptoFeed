//
//  Network.swift
//  CryptoFeed
//
//  Created by Antonio Casero Palmero on 31.08.17.
//  Copyright © 2017 Uttopia. All rights reserved.
//

import Foundation


internal struct Network {

    public typealias AsyncOperation = (Result<[String : Any]>) -> Void

    
    internal static func rawRequest(_ request: URLRequest, completion: @escaping AsyncOperation) {
        
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

}
