//
//  CrossCalculatorTableViewCell.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/29.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class CrossCalculatorTableViewCell: UITableViewCell {

    @IBOutlet weak var crossNumber: UILabel!
    @IBOutlet weak var oddsText: UITextField!
    @IBOutlet weak var crossTypeLabel: UILabel!
    @IBOutlet weak var crossPersentText: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
