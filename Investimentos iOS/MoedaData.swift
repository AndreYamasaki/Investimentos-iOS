//
//  MoedaData.swift
//  Investimentos iOS
//
//  Created by user on 13/09/21.
//

import Foundation

// MARK: - MoedaData
struct MoedaData: Codable {
    let by: String
    let validKey: Bool
    let results: Results
}

// MARK: - Results
struct Results: Codable {
    let currencies: Currencies
}

// MARK: - Currencies
struct Currencies: Codable {
    let source: String
    let usd, eur, gbp, ars, cad, aud, jpy, cny, btc: Price
}

// MARK: - Ars
struct Price: Codable {
    let name: String
    let buy: Double
    let sell: Double?
    let variation: Double
}
