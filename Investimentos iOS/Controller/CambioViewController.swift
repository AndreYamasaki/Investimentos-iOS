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
        
        venderOutlet.layer.cornerRadius = 21
        venderOutlet.layer.masksToBounds = true
        
        comprarOutlet.layer.cornerRadius = 21
        comprarOutlet.layer.masksToBounds = true
        
        testarBotao()
        
        quantidadeTextField.delegate = self
        
        configurarcAcessibilidade()
        
        
        
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
    
    func configurarcAcessibilidade() {
        
        guard let moeda = moeda else {return}
        guard let moedas = moedas else {return}
        
        moedaLabel.accessibilityTraits = .header
        moedaLabel.isAccessibilityElement = false
        moedaLabel.accessibilityLabel = moedas + " - " + moeda.name
        
        compraLabel.accessibilityTraits = .header
        compraLabel.isAccessibilityElement = false
        compraLabel.accessibilityLabel = "Compra: " + moeda.buyString
        
        variacaoLabel.isAccessibilityElement = false
        variacaoLabel.accessibilityTraits = .header
        variacaoLabel.accessibilityLabel = String(moeda.variation) + "%"
        
        vendaLabel.accessibilityTraits = .header
        vendaLabel.isAccessibilityElement = false
        vendaLabel.accessibilityLabel = "Venda: " + moeda.sellString
        
        saldoLabel.isAccessibilityElement = false
        saldoLabel.accessibilityTraits = .header
        saldoLabel.accessibilityLabel = "Saldo disponível: R$\(usuario.saldo)"
        
        caixaLabel.isAccessibilityElement = false
        caixaLabel.accessibilityTraits = .header
        caixaLabel.accessibilityLabel = "\(usuario.saldoMoeda[moedas] ?? 0) \(moedas) em caixa"
        
        venderOutlet.isAccessibilityElement = true
        venderOutlet.accessibilityLabel = "Botão vender"
        
        comprarOutlet.isAccessibilityElement = true
        comprarOutlet.accessibilityLabel = "Botão comprar"
        
        
        cambioView.isAccessibilityElement = true
        cambioView.accessibilityLabel = "Tela de câmbio - " + moeda.name
    }
    
    @IBAction func venderPressed(_ sender: UIButton) {
        
        textFieldDidEndEditing(quantidadeTextField)
        
        guard let moedaVenda = moeda?.sell, let quantidadeVenda = quantidade, let moedas = moedas else { return }
        
//        guard let quantidadeVenda = quantidade else { return }
//
//        guard let moedas = moedas else { return }
        
        let valorReal = moedaVenda * quantidadeVenda
        
        usuario.saldo += valorReal
        usuario.saldoMoeda[moedas]! -= quantidadeVenda
        saldoLabel.text = "Saldo Disponível: " + usuario.saldoString
        caixaLabel.text = "\(usuario.saldoMoeda[moedas] ?? 0) \(moedas) em caixa"
        
        if let vendaViewController = storyboard?.instantiateViewController(identifier: "venda") as? VendaViewController {
            
            let valorString = String(format: "%.2f", valorReal)
            vendaViewController.message = """
                Parabéns!
                Você acabou de vender \(quantidadeVenda) \(moedas) - \(moeda?.name ?? ""), totalizando R$\(valorString)
                """
            navigationController?.pushViewController(vendaViewController, animated: true)
            
        }
        testarBotao()
        configurarcAcessibilidade()
        
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
        
        if let compraViewController = storyboard?.instantiateViewController(identifier: "compra") as? CompraViewController {
            
            let valorString = String(format: "%.2f", valorReal)
            compraViewController.message = """
                Parabéns!
                Você acabou de comprar \(quantidadeCompra) \(moedas) - \(moeda?.name ?? ""), totalizando R$\(valorString)
                """
            navigationController?.pushViewController(compraViewController, animated: true)
            
        }
        testarBotao()
        configurarcAcessibilidade()
    }
    
    

    
    func testarBotao() {
        
        guard let moedaCompra = moeda?.buy else { return }
        guard let moedaVenda = moeda?.sell else { return }
        if moedaCompra > usuario.saldo || usuario.saldo == 0 {
            comprarOutlet.isEnabled = false
            comprarOutlet.alpha = 0.5
        } else {
            comprarOutlet.isEnabled = true
            comprarOutlet.alpha = 1
        }
        
        if usuario.saldoMoeda[moedas!] == 0 || usuario.saldo < moedaVenda {
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
        if textField.text != String(){
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


