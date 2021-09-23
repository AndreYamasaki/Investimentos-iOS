//
//  MoedaData.swift
//  Investimentos iOS
//
//  Created by user on 13/09/21.
//

import Foundation

// MARK: - MoedaData
struct MoedaData: Codable {
    let results: Results
}

// MARK: - Results
struct Results: Codable {
    let currencies: Currencies
}

// MARK: - Currencies
struct Currencies: Codable {
    let source: String
    let USD, EUR, GBP, ARS, CAD, AUD, JPY, CNY, BTC: Price
}

// MARK: - Ars
struct Price: Codable {
    let name: String
    let buy: Double
    let sell: Double?
    let variation: Double
    
    var buyString: String {
            let buy = buy
                let NSNumberBuy = NSNumber(value: buy)
                let formatter = setFormatter()
                if let result = formatter.string(from: NSNumberBuy) {
                    return result
                }
        return "R$: 0.00"
        }
        
        var sellString: String {
            if let sell = sell {
                let NSNumberSell = NSNumber(value: sell)
                let formatter = setFormatter()
                if let result = formatter.string(from: NSNumberSell) {
                    return result
                }
            }
            return "Não disponível para venda"
        }
        
        func setFormatter() -> NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = "BRL"
            return formatter
        }
}
