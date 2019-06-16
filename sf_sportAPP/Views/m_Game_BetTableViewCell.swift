//
//  m_Game_BetTableViewCell.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/6/6.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class m_Game_BetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var h_bet_0: UIView!
    @IBOutlet weak var h_bet_1: UIView!
    @IBOutlet weak var h_bet_2: UIView!
    @IBOutlet weak var h_bet_3: UIView!
    
    @IBOutlet weak var a_bet_0: UIView!
    @IBOutlet weak var a_bet_1: UIView!
    @IBOutlet weak var a_bet_2: UIView!
    @IBOutlet weak var a_bet_3: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
