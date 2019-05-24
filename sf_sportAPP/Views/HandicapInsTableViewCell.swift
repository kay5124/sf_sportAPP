//
//  HandicapInsTableViewCell.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/24.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class HandicapInsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var handicapLabel: UILabel!
    @IBOutlet weak var conLabel: UILabel!
    @IBOutlet weak var descritionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
