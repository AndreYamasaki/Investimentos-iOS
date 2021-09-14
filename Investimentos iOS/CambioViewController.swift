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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Câmbio"
        
        cambioView.layer.borderWidth = 1
        cambioView.layer.borderColor = UIColor.white.cgColor
        cambioView.layer.backgroundColor = UIColor.black.cgColor
        cambioView.layer.cornerRadius = 15
        cambioView.layer.masksToBounds = true
        
        venderOutlet.layer.cornerRadius = 21.5
        venderOutlet.layer.masksToBounds = true
        
        comprarOutlet.layer.cornerRadius = 21.5
        comprarOutlet.layer.masksToBounds = true
        
    }
    
}
