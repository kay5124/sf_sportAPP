//
//  MenuTableViewCell.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/20.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuItemIcon: UIImageView!
    @IBOutlet weak var menuItemTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
