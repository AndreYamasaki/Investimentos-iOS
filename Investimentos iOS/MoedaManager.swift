//
//  MoedaManager.swift
//  Investimentos iOS
//
//  Created by user on 13/09/21.
//

import Foundation

struct MoedaManager {
    
    //MARK: - Attributes
    
    let baseURL = "https://api.hgbrasil.com/finance"
    
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
                    print(dataString as Any)
                }
            }
            task.resume()
        }
    }
    
    func parseJSon(_ moedaData: Data) {
        
        let decoder = JSONDecoder()
        do {
            
        } catch {
            
        }
    }
}
