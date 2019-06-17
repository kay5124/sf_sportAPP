//
//  HandicapSampleTableViewCell.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/28.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class HandicapSampleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var topCenterLabel: UILabel!
    @IBOutlet weak var bTopLabel: UILabel!
    @IBOutlet weak var bBottomLabel: UILabel!
    @IBOutlet weak var bTopRightLabel: UILabel!
    @IBOutlet weak var bBottomRightLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
