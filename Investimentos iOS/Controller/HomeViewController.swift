//
//  ViewController.swift
//  Investimentos iOS
//
//  Created by user on 10/09/21.
//

import UIKit

class HomeViewController: UITableViewController {
    
    //MARK: - Attributes
//    var arrayMoedas = [
//    "USD", "EUR", "ARS"
//    ]
//    var arrayPorcentagem = [
//    "0,53%", "0%", "1,12%"
//    ]
    
    
    let tableViewCell = TableViewCell()
    let baseURL = "https://api.hgbrasil.com/finance"
    var moedas = [Price]()
    let currencyArray = ["ARS", "AUD", "BTC", "CAD", "CNY", "EUR", "GBP", "JPY", "USD"]
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
          title = "Moedas"
        
        performRequest()
        
//        moedaManager.delegate = self
//        moedaManager.performRequest()
    }
    
    //MARK: - TablewView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return moedas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! TableViewCell
        cell.labelCurrency.text = currencyArray[indexPath.section]
        cell.labelPercent.text = String(format: "%.2f", moedas[indexPath.section].variation) + "%"
        
        if moedas[indexPath.section].variation > 0 {
            cell.labelPercent.textColor = .green
        } else if moedas[indexPath.section].variation < 0 {
            cell.labelPercent.textColor = .red
        } else {
            cell.labelPercent.textColor = .white
        }
        
        cell.viewCell.layer.borderWidth = 1
        cell.viewCell.layer.borderColor = UIColor.white.cgColor
        cell.viewCell.layer.cornerRadius = 10
        cell.viewCell.layer.masksToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "cambio") as? CambioViewController {
            vc.moeda = moedas[indexPath.section]
            vc.moedas = currencyArray[indexPath.section]
            navigationController?.pushViewController(vc, animated: true)
        }
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
//                    let dataString = String(data: safeData, encoding: .utf8)
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
            
            moedas.append(decodedData.results.currencies.ARS)
            moedas.append(decodedData.results.currencies.AUD)
            moedas.append(decodedData.results.currencies.BTC)
            moedas.append(decodedData.results.currencies.CAD)
            moedas.append(decodedData.results.currencies.CNY)
            moedas.append(decodedData.results.currencies.EUR)
            moedas.append(decodedData.results.currencies.GBP)
            moedas.append(decodedData.results.currencies.JPY)
            moedas.append(decodedData.results.currencies.USD)
            
            
        } catch {
            print(error)
        }
        
        DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
    }
    

}
