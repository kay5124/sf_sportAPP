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
//        setSeparator()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setSeparator() {
        let separator = UIView(frame: CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: bounds.width + 100, height: 1.5))
        separator.backgroundColor = UIColor(white: 216/255, alpha: 100)
        addSubview(separator)
    }
    
}
