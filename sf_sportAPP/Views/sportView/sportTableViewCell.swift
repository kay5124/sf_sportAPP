//
//  sportTableViewCell.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/22.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class sportTableViewCell: UITableViewCell {
    @IBOutlet weak var sportIconImgView: UIImageView!
    @IBOutlet weak var sportNameLabel: UILabel!
    @IBOutlet weak var liveLabel: UILabel!
    @IBOutlet weak var sportGameCountLabel: UILabel!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
