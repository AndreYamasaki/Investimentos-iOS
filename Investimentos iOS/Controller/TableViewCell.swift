//
//  TableViewCell.swift
//  Investimentos iOS
//
//  Created by user on 10/09/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var labelCurrency: UILabel!
    @IBOutlet var labelPercent: UILabel!
    @IBOutlet var viewCell: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
