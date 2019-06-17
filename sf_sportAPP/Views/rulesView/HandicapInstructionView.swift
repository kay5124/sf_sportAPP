//
//  HandicapInstructionView.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/24.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class HandicapInstructionView: UIView {
    
    @IBOutlet weak var sampleDesView: UIView!
    @IBOutlet weak var sampleHeaderStackView: UIStackView!
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var pageBtn: UISegmentedControl!
    @IBOutlet weak var HandicapView: UIView!
    @IBOutlet weak var HandicapTableView: UITableView!
    @IBOutlet weak var constaint_height: NSLayoutConstraint!
    override func awakeFromNib() {
        HandicapView.layer.cornerRadius = 10
        HandicapView.layer.borderColor = UIColor.lightGray.cgColor
        HandicapView.layer.borderWidth = 1
        bigView.corner(byRoundingCorners: [.topLeft,.topRight], radii: 10)
        //去除多餘的行數
        HandicapTableView.tableFooterView = UIView()
        //分隔線樣式
        HandicapTableView.separatorStyle = .singleLine
        //分隔線寬度填滿
//        HandicapTableView.separatorInset = .zero
        self.HandicapTableView.separatorInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
    }
    
    public static func create() -> HandicapInstructionView {
        let selfView = Bundle.main.loadNibNamed("HandicapInstructionView", owner: self, options: nil)?.first as! HandicapInstructionView
        return selfView
    }
    
}
