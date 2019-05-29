//
//  NoticeView.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/29.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class NoticeView: UIView {
    @IBOutlet weak var noticeTypeBtn: UIButton!
    @IBOutlet weak var userMoney: UILabel!
    @IBOutlet weak var noticeTableView: UITableView!
    
    override func awakeFromNib() {
        noticeTableView.tableFooterView = UIView()
        noticeTableView.separatorStyle = .none
        
        userMoney.text = _GLobalService.userMoney
        noticeTypeBtn.layer.cornerRadius = 10
        noticeTypeBtn.layer.borderColor = UIColor.white.cgColor
        noticeTypeBtn.layer.borderWidth = 1
    }

    public static func create() -> NoticeView {
        let selfView = Bundle.main.loadNibNamed("NoticeView", owner: self, options: nil)?.first as! NoticeView
        return selfView
    }
    
}
