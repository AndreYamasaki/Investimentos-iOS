//
//  ViewController.swift
//  Investimentos iOS
//
//  Created by user on 10/09/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var arrayMoedas = [
    "USD", "EUR", "ARS"
    ]
    var arrayPorcentagem = [
    "0,53%", "0%", "1,12%"
    ]
    
    let tableViewCell = TableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        tableViewCell.viewCell.layer.borderWidth = 1
//        tableViewCell.viewCell.layer.borderColor = UIColor.white.cgColor
        
        title = "Moedas"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMoedas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! TableViewCell
        cell.labelCurrency.text = arrayMoedas[indexPath.row]
        cell.labelPercent.text = arrayPorcentagem[indexPath.row]
        
        cell.viewCell.layer.borderWidth = 1
        cell.viewCell.layer.borderColor = UIColor.white.cgColor
        cell.viewCell.layer.cornerRadius = 10
        cell.viewCell.clipsToBounds = true
        return cell
    }
}

