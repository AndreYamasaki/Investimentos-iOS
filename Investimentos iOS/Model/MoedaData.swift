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
    let USD, EUR, GBP, ARS, CAD, AUD, JPY, CNY, BTC: Price
}

// MARK: - Ars
struct Price: Codable {
    let name: String
    let buy: Double
    let sell: Double?
    let variation: Double
}
