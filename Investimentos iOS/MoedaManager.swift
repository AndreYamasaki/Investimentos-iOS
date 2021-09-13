//
//  MoedaManager.swift
//  Investimentos iOS
//
//  Created by user on 13/09/21.
//

import Foundation

protocol moedaManagerDelegate {
    func passarValores(_ moedaManager: MoedaManager, moedaModel: [MoedaModel])
}

struct MoedaManager {
    
    //MARK: - Attributes
    
    let baseURL = "https://api.hgbrasil.com/finance"
    var delegate: moedaManagerDelegate?
    
    //MARK: - Methods
    
    func performRequest() {
        
        if let url = URL(string: baseURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString as Any)
                    if let arrayMoeda = parseJSon(safeData) {
                        self.delegate?.passarValores(self, moedaModel: arrayMoeda)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSon(_ moedaData: Data) -> [MoedaModel]? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MoedaData.self, from: moedaData)
//            print(decodedData)
            
            let usdName = decodedData.results.currencies.USD.name
            let usdVariation = decodedData.results.currencies.USD.variation
            let eurName = decodedData.results.currencies.EUR.name
            let eurVariation = decodedData.results.currencies.EUR.variation
            let arsName = decodedData.results.currencies.ARS.name
            let arsVariation = decodedData.results.currencies.ARS.variation
            
            let moeda = [MoedaModel(name: usdName, variation: usdVariation),
                         MoedaModel(name: eurName, variation: eurVariation),
                         MoedaModel(name: arsName, variation: arsVariation)
            ]
            return moeda
            
        } catch {
            print(error)
            return nil
        }
    }
}
