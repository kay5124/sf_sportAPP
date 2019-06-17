//
//  LeagueTableViewCell.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/22.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {
    @IBOutlet weak var leagueId: UILabel!
    @IBOutlet weak var leagueCheckBoxImgView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
