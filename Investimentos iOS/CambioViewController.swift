//
//  CambioViewController.swift
//  Investimentos iOS
//
//  Created by user on 14/09/21.
//

import UIKit

class CambioViewController: UIViewController {
    
    //MARK: - Attributes
    
    @IBOutlet var moedaLabel: UILabel!
    @IBOutlet var variacaoLabel: UILabel!
    @IBOutlet var compraLabel: UILabel!
    @IBOutlet var vendaLabel: UILabel!
    @IBOutlet var saldoLabel: UILabel!
    @IBOutlet var caixaLabel: UILabel!
    
    @IBOutlet var cambioView: UIView!
    
    @IBOutlet var quantidadeTextField: UITextField!
    var quantidade: Double?
    
    @IBOutlet var venderOutlet: UIButton!
    @IBOutlet var comprarOutlet: UIButton!
    
    var moeda: Price?
    
    var carteira: Double = 1000
    var saldoMoeda: Double = 0
    
    //MARK: - viewDidLoad
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
        
        quantidadeTextField.attributedPlaceholder = NSAttributedString(string: "quantidade", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 97, green: 97, blue: 97, alpha: 0.6)])
        quantidadeTextField.layer.borderWidth = 1
        quantidadeTextField.layer.borderColor = UIColor(red: 97, green: 97, blue: 97, alpha: 0.6).cgColor
        quantidadeTextField.layer.cornerRadius = 10
        quantidadeTextField.layer.masksToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        
        quantidadeTextField.delegate = self
        
    }
    
    //MARK: - Methods
    
    @IBAction func venderPressed(_ sender: UIButton) {
        
        guard let moedaVenda = moeda?.sell else { return }
        
        carteira += moedaVenda
        saldoMoeda -= moedaVenda
        saldoLabel.text = "Saldo Disponível: R$\(carteira)"
        caixaLabel.text = "\(saldoMoeda) \(moeda!.name) em caixa"
        
    }
    
    @IBAction func comprarPressed(_ sender: UIButton) {
        
        
        guard let moedaCompra = moeda?.buy else { return }
        
        if moedaCompra < carteira && carteira != 0 {
        
        carteira -= moedaCompra
        saldoMoeda += moedaCompra
        saldoLabel.text = "Saldo Disponível: R$\(carteira)"
        caixaLabel.text = "\(saldoMoeda) \(moeda!.name) em caixa"
        } else {
            sender.isEnabled = false
        }
        
    }
    
    
    func adicionarValores() {
        guard let moeda = moeda else {return}
        moedaLabel.text = moeda.name
        compraLabel.text = "Compra: R$\(moeda.buy)"
        variacaoLabel.text = String(moeda.variation) + "%"
        if let venda = moeda.sell {
            vendaLabel.text = "Vendaaa: R$\(venda)"
        }
        saldoLabel.text = "Saldo disponível: R$\(carteira)"
        caixaLabel.text = "\(saldoMoeda) \(moeda.name) em caixa"
        
    }
}

extension CambioViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //implementar
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
                    return true
                } else {
                    textField.placeholder = "Type a location"
                    return false
                }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        quantidadeTextField.endEditing(true)
                return true
    }
}


