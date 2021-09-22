//
//  Usuario.swift
//  Investimentos iOS
//
//  Created by user on 17/09/21.
//

import Foundation

class Usuario {
    
    var saldo: Double
    var saldoMoeda: [String: Double]
    
    init() {
        saldoMoeda = ["USD": 0.0, "EUR": 0.0, "GBP": 0.0, "ARS": 0.0, "CAD": 0.0, "AUD": 0.0, "JPY": 0.0, "CNY": 0.0, "BTC": 0.0]
        saldo = 1000.0
    }
}
