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
    
    @IBOutlet var venderOutlet: CustomButton!
    @IBOutlet var comprarOutlet: CustomButton!
    
    let formatter = NumberFormatter()
    var usuario = Usuario()
    var moeda: Price?
    var quantidade: Double? //pega o valor da textField
    var moedas:  String?
    
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Câmbio"
        
        configurarBordaView() //borda branca, arredondada, fundo preto
        configurartextField() //borda e placeholder cinza, arredondados
        adicionarValores()
        
        venderOutlet.setLayer()
        comprarOutlet.setLayer()
        
        testarBotao()
        
        quantidadeTextField.delegate = self
        
        
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        
    }
    
    //MARK: - Methods
    
    func adicionarValores() {
        
        guard let moeda = moeda else {return}

        guard let moedas = moedas else {return}
        
        moedaLabel.text = moedas + " - " + moeda.name
        let moedaCompra = moeda.buyString
            compraLabel.text = "Compra: " + moedaCompra
        variacaoLabel.text = String(moeda.variation) + "%"
        let moedaVenda = moeda.sellString
        vendaLabel.text = "Venda: " + moedaVenda
        
        saldoLabel.text = "Saldo disponível: R$\(usuario.saldo)"
        caixaLabel.text = "\(usuario.saldoMoeda[moedas] ?? 0) \(moedas) em caixa"
    }
    
    func configurarBordaView() {
        cambioView.layer.borderWidth = 1
        cambioView.layer.borderColor = UIColor.white.cgColor
        cambioView.layer.backgroundColor = UIColor.black.cgColor
        cambioView.layer.cornerRadius = 15
        cambioView.layer.masksToBounds = true
    }
    
    func configurartextField() {
        quantidadeTextField.attributedPlaceholder = NSAttributedString(string: "quantidade", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 97, green: 97, blue: 97, alpha: 0.6)])
        quantidadeTextField.layer.borderWidth = 1
        quantidadeTextField.layer.borderColor = UIColor(red: 97, green: 97, blue: 97, alpha: 1).cgColor
        quantidadeTextField.layer.cornerRadius = 10
        quantidadeTextField.layer.masksToBounds = true
    }
    
    @IBAction func venderPressed(_ sender: UIButton) {
        
        textFieldDidEndEditing(quantidadeTextField)
        guard let moedaVenda = moeda?.sell else { return }
        
        guard let quantidadeVenda = quantidade else { return }
        
        guard let moedas = moedas else { return }
        
        let valorReal = moedaVenda * quantidadeVenda
        
        usuario.saldo += valorReal
        usuario.saldoMoeda[moedas]! -= quantidadeVenda
        saldoLabel.text = "Saldo Disponível: " + usuario.saldoString
        caixaLabel.text = "\(usuario.saldoMoeda[moedas] ?? 0) \(moedas) em caixa"
        
        if let vc = storyboard?.instantiateViewController(identifier: "venda") as? VendaViewController {
            
            let valorString = String(format: "%.2f", valorReal)
            vc.message = """
                Parabéns!
                Você acabou de vender \(quantidadeVenda) \(moedas) - \(moeda?.name ?? ""), totalizando R$\(valorString)
                """
            navigationController?.pushViewController(vc, animated: true)
            
        }
        testarBotao()
        
    }
    
    @IBAction func comprarPressed(_ sender: UIButton) {
        
        textFieldDidEndEditing(quantidadeTextField)
        
        guard let moedaCompra = moeda?.buy else { return }
        
        guard let quantidadeCompra = quantidade else { return }
        
        guard let moedas = moedas else { return }
        
        let valorReal = moedaCompra * quantidadeCompra
        
        usuario.saldo -= valorReal
        usuario.saldoMoeda[moedas]! += quantidadeCompra
        saldoLabel.text = "Saldo Disponível: " + usuario.saldoString
        caixaLabel.text = "\(usuario.saldoMoeda[moedas] ?? 0) \(moedas) em caixa"
        
        if let vc = storyboard?.instantiateViewController(identifier: "compra") as? CompraViewController {
            
            let valorString = String(format: "%.2f", valorReal)
            vc.message = """
                Parabéns!
                Você acabou de comprar \(quantidadeCompra) \(moedas) - \(moeda?.name ?? ""), totalizando R$\(valorString)
                """
            navigationController?.pushViewController(vc, animated: true)
            
        }
        testarBotao()
    }
    
    

    
    func testarBotao() {
        
        guard let moedaCompra = moeda?.buy else { return }
        guard let moedaVenda = moeda?.sell else { return }
        if moedaCompra > usuario.saldo || usuario.saldo == 0 {
            comprarOutlet.disableButton()
        } else {
            comprarOutlet.enableButton()
        }
        
        if usuario.saldoMoeda[moedas!] == 0 || usuario.saldo < moedaVenda {
            venderOutlet.disableButton()
        } else {
            venderOutlet.enableButton()
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
                    textField.placeholder = "quantidade"
                    return false
                }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        quantidadeTextField.endEditing(true)
                return true
    }
}


