//
//  CoinManager.swift
//  ByteCoin
//
//  Created by 🧔🏻Alikhan Batchaev on 03.02.2020.
//  Copyright © 2020 Alikhan Batchaev. All rights reserved.
//

import UIKit

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E581F91E-4DB5-47C5-AA1D-24E7B7163359"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
        // Use String concatenation to add the selected currency at the end of the baseURL along with the API key
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        //Use optional binding to unwrap the URL that's created from the urlString
        if let url = URL(string: urlString) {
            
            //Create a new URLSession object with default configuration.
            let session = URLSession(configuration: .default)
            
            //Create a new data task for the URLSession
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                if let safeData = data {
                    let bitcoinPrice = self.parseJSON(safeData)
                }
            }
            //Start task
            task.resume()
        }
        
    }
    
    func parseJSON(_ data: Data) -> Double? {
        
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(CoinData.self, from: data)
            
            let lastPrice = decoderData.last
            print(lastPrice)
            return lastPrice
            
        } catch {
            print(error)
            return nil
        }
    }
}
