//
//  m_Game_BetTableViewCell.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/6/6.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class m_Game_BetTableViewCell: UITableViewCell {

    @IBOutlet weak var h_con_0: UILabel!
    @IBOutlet weak var h_odds_0: UILabel!
    
    @IBOutlet weak var h_con_1: UILabel!
    @IBOutlet weak var h_odds_1: UILabel!
    
    @IBOutlet weak var h_con_2: UILabel!
    @IBOutlet weak var h_odds_2: UILabel!
    
    @IBOutlet weak var h_con_3: UILabel!
    @IBOutlet weak var h_odds_3: UILabel!
    
    @IBOutlet weak var a_con_0: UILabel!
    @IBOutlet weak var a_odds_0: UILabel!
    
    @IBOutlet weak var a_con_1: UILabel!
    @IBOutlet weak var a_odds_1: UILabel!
    
    @IBOutlet weak var a_con_2: UILabel!
    @IBOutlet weak var a_odds_2: UILabel!
    
    @IBOutlet weak var a_con_3: UILabel!
    @IBOutlet weak var a_odds_3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
