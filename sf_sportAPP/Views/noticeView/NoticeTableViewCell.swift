//
//  NoticeTableViewCell.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/6/3.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {

    @IBOutlet weak var noticeType: UILabel!
    @IBOutlet weak var noticeDate: UILabel!
    @IBOutlet weak var noticeExpanLabel: UILabel!
    @IBOutlet weak var noticeContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.separatorInset = .zero
        self.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
