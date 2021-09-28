//
//  CustomButton.swift
//  Investimentos iOS
//
//  Created by user on 28/09/21.
//

import UIKit

class CustomButton: UIButton {

    func setLayer() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 21
    }
    
    func disableButton() {
        self.isEnabled = false
        self.alpha = 0.5
    }
    
    func enableButton(){
        self.isEnabled = true
        self.alpha = 1
    }

}
