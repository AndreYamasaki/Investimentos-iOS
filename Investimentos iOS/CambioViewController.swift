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
    
    
    @IBOutlet var venderOutlet: UIButton!
    @IBOutlet var comprarOutlet: UIButton!
    
    var moeda: Price?
    var quantidade: Double?
    var carteira: Double = 100
    var saldoMoeda: Double = 0
    var usuario: Usuario?
    
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
        testarBotaoCompra()
        testarBotaoVenda()
        
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
        guard let quantidadeVenda = quantidade else { return }
        
        carteira = carteira + (moedaVenda * quantidadeVenda)
        saldoMoeda -= quantidadeVenda
        saldoLabel.text = "Saldo Disponível: R$\(carteira)"
        caixaLabel.text = "\(saldoMoeda) \(moeda!.name) em caixa"
        testarBotaoVenda()
        testarBotaoCompra()
        
    }
    
    @IBAction func comprarPressed(_ sender: UIButton) {
        
        guard let moedaCompra = moeda?.buy else { return }
        
        guard let quantidadeCompra = quantidade else { return }
        
        carteira = carteira - (moedaCompra * quantidadeCompra)
        saldoMoeda += quantidadeCompra
        saldoLabel.text = "Saldo Disponível: R$\(carteira)"
        caixaLabel.text = "\(saldoMoeda) \(moeda!.name) em caixa"
        testarBotaoVenda()
        testarBotaoCompra()
    }
    
    
    func adicionarValores() {
        guard let moeda = moeda else {return}
        moedaLabel.text = moeda.name
        compraLabel.text = "Compra: R$\(moeda.buy)"
        variacaoLabel.text = String(moeda.variation) + "%"
        if let venda = moeda.sell {
        vendaLabel.text = "Venda: R$\(venda)"
        }
        saldoLabel.text = "Saldo disponível: R$\(carteira)"
        caixaLabel.text = "\(saldoMoeda) \(moeda.name) em caixa"
        
    }
    
    func testarBotaoCompra() {
        
        guard let moedaCompra = moeda?.buy else { return }
        if moedaCompra > carteira || carteira == 0 {
            comprarOutlet.isEnabled = false
            comprarOutlet.alpha = 0.5
        } else {
            comprarOutlet.isEnabled = true
            comprarOutlet.alpha = 1
        }
    }
    
    func testarBotaoVenda() {
        
        if saldoMoeda == 0 {
            venderOutlet.isEnabled = false
            venderOutlet.alpha = 0.5
        } else {
            venderOutlet.isEnabled = true
            venderOutlet.alpha = 1
        }
    }
}

//MARK: - UItextFieldDelegate
extension CambioViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let valor = quantidadeTextField.text {
            if let doubleValor = Double(valor){
                quantidade = doubleValor
            }
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
                    return true
                } else {
                    textField.placeholder = "Quantidade"
                    return false
                }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        quantidadeTextField.endEditing(true)
                return true
    }
}


