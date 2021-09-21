//
//  CompraViewController.swift
//  Investimentos iOS
//
//  Created by user on 21/09/21.
//

import UIKit

class CompraViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var homeButton: UIButton!
    
    var message: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Comprar"
        
        homeButton.layer.cornerRadius = 21
        homeButton.layer.masksToBounds = true
        
        label.text = message
    }

    @IBAction func homePressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
}
