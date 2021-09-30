//
//  CustomView.swift
//  Investimentos iOS
//
//  Created by user on 28/09/21.
//

import UIKit

class CustomView: UIView {
    
    func setViewBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.backgroundColor = UIColor.black.cgColor
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }

}
