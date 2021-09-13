//
//  ViewController.swift
//  Investimentos iOS
//
//  Created by user on 10/09/21.
//

import UIKit

class ViewController: UITableViewController, moedaManagerDelegate {
    
    //MARK: - Attributes
    var arrayMoedas = [
    "USD", "EUR", "ARS"
    ]
    var arrayPorcentagem = [
    "0,53%", "0%", "1,12%"
    ]
    
    var moedaModels = [MoedaModel]()
    
    let tableViewCell = TableViewCell()
        
    var moedaManager = MoedaManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Moedas"
        
        moedaManager.delegate = self
        moedaManager.performRequest()
    }
    
    //MARK: - Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return moedaModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! TableViewCell
        cell.labelCurrency.text = moedaModels[indexPath.section].name
        cell.labelPercent.text = moedaModels[indexPath.section].variationString
        
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
    
    func passarValores(_ moedaManager: MoedaManager, moedaModel: [MoedaModel]) {
        
            self.moedaModels = moedaModel
    }
}
