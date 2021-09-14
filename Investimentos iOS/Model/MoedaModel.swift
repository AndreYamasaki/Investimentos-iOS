//
//  MoedaModel.swift
//  Investimentos iOS
//
//  Created by user on 13/09/21.
//

import Foundation

struct MoedaModel {
    
    let name: String
    let variation: Double
    
    var variationString: String {
        return String(format: "%.2f", variation)
    }
}
