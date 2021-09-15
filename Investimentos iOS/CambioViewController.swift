//
//  CambioViewController.swift
//  Investimentos iOS
//
//  Created by user on 14/09/21.
//

import UIKit

class CambioViewController: UIViewController {
    
    @IBOutlet var moedaLabel: UILabel!
    @IBOutlet var variacaoLabel: UILabel!
    @IBOutlet var compraLabel: UILabel!
    @IBOutlet var vendaLabel: UILabel!
    @IBOutlet var saldoLabel: UILabel!
    @IBOutlet var caixaLabel: UILabel!
    
    @IBOutlet var cambioView: UIView!
    
    @IBOutlet var quantidadeTextField: UITextField!
    
    @IBOutlet var venderOutlet: UIButton!
    @IBOutlet var comprarOutlet: UIButton!
    
    var moeda: Price?
    
    var carteira: Double = 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Câmbio"
        
        cambioView.layer.borderWidth = 1
        cambioView.layer.borderColor = UIColor.white.cgColor
        cambioView.layer.backgroundColor = UIColor.black.cgColor
        cambioView.layer.cornerRadius = 15
        cambioView.layer.masksToBounds = true
        
        venderOutlet.layer.cornerRadius = 21
        venderOutlet.layer.masksToBounds = true
        
        comprarOutlet.layer.cornerRadius = 21
        comprarOutlet.layer.masksToBounds = true
        
        adicionarValores()
        
    }
    
    func adicionarValores() {
        guard let moeda = moeda else {return}
        moedaLabel.text = moeda.name
        compraLabel.text = "Compra: R$\(moeda.buy)"
        variacaoLabel.text = String(moeda.variation) + "%"
        if let venda = moeda.sell {
            vendaLabel.text = "Vendaaa: R$\(venda)"
        }

    }
}
