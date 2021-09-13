//
//  ViewController.swift
//  Investimentos iOS
//
//  Created by user on 10/09/21.
//

import UIKit

class ViewController: UITableViewController {
    
    //MARK: - Attributes
//    var arrayMoedas = [
//    "USD", "EUR", "ARS"
//    ]
//    var arrayPorcentagem = [
//    "0,53%", "0%", "1,12%"
//    ]
    
    
    let tableViewCell = TableViewCell()
    let baseURL = "https://api.hgbrasil.com/finance"
    var arrayName = [String]()
    var arrayVariation = [Double]()
        
//    var moedaManager = MoedaManager()
//    var moedaModels = [MoedaModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
          title = "Moedas"
        
        performRequest()
        
//        moedaManager.delegate = self
//        moedaManager.performRequest()
    }
    
    //MARK: - Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return arrayName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! TableViewCell
        cell.labelCurrency.text = arrayName[indexPath.section]
        cell.labelPercent.text = String(format: "%.2f", arrayVariation[indexPath.section]) + "%"
        
        cell.viewCell.layer.borderWidth = 1
        cell.viewCell.layer.borderColor = UIColor.white.cgColor
        cell.viewCell.layer.cornerRadius = 10
        cell.viewCell.layer.masksToBounds = true
        
        return cell
    }
    
    //espaçamento entre cada sessão
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
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
                    self.parseJSon(safeData)
                }
            }
            task.resume()
        }
    }
    
    func parseJSon(_ moedaData: Data) {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MoedaData.self, from: moedaData)
//            print(decodedData)
            arrayName.append(decodedData.results.currencies.ARS.name)
            arrayName.append(decodedData.results.currencies.AUD.name)
            arrayName.append(decodedData.results.currencies.BTC.name)
            arrayName.append(decodedData.results.currencies.CAD.name)
            arrayName.append(decodedData.results.currencies.CNY.name)
            arrayName.append(decodedData.results.currencies.EUR.name)
            arrayName.append(decodedData.results.currencies.GBP.name)
            arrayName.append(decodedData.results.currencies.JPY.name)
            arrayName.append(decodedData.results.currencies.USD.name)
            
            arrayVariation.append(decodedData.results.currencies.ARS.variation)
            arrayVariation.append(decodedData.results.currencies.AUD.variation)
            arrayVariation.append(decodedData.results.currencies.BTC.variation)
            arrayVariation.append(decodedData.results.currencies.CAD.variation)
            arrayVariation.append(decodedData.results.currencies.CNY.variation)
            arrayVariation.append(decodedData.results.currencies.EUR.variation)
            arrayVariation.append(decodedData.results.currencies.GBP.variation)
            arrayVariation.append(decodedData.results.currencies.JPY.variation)
            arrayVariation.append(decodedData.results.currencies.USD.variation)
            
            
        } catch {
            print(error)
        }
        
        DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
    }
    
//    func passarValores(_ moedaManager: MoedaManager, moedaModel: [MoedaModel]) {
//        
//            self.moedaModels = moedaModel
//    }
}

//            let usdName = decodedData.results.currencies.USD.name
//            let usdVariation = decodedData.results.currencies.USD.variation
//            let eurName = decodedData.results.currencies.EUR.name
//            let eurVariation = decodedData.results.currencies.EUR.variation
//            let arsName = decodedData.results.currencies.ARS.name
//            let arsVariation = decodedData.results.currencies.ARS.variation
//
//            let moeda = [MoedaModel(name: usdName, variation: usdVariation),
//                         MoedaModel(name: eurName, variation: eurVariation),
//                         MoedaModel(name: arsName, variation: arsVariation)
//            ]
