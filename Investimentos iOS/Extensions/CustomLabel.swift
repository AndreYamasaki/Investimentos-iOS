//
//  CustomLabelColor.swift
//  Investimentos iOS
//
//  Created by user on 28/09/21.
//

import UIKit

class CustomLabel: UILabel {

    func setColor(for variation: Double) {
            if variation > 0 {
                self.textColor = .green
            } else if variation < 0 {
                self.textColor = .red
            } else {
                self.textColor = .white
            }
        }

}
