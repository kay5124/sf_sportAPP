//
//  HandicapInstructionView.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/24.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class HandicapInstructionView: UIView {
    
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var pageBtn: UISegmentedControl!
    @IBOutlet weak var HandicapView: UIView!
    @IBOutlet weak var HandicapTableView: UITableView!
    override func awakeFromNib() {
        HandicapView.layer.cornerRadius = 10
        HandicapView.layer.borderColor = UIColor.lightGray.cgColor
        HandicapView.layer.borderWidth = 1
        bigView.corner(byRoundingCorners: [.topLeft,.topRight], radii: 10)
        headerStackView.layer.borderWidth = 1
        headerStackView.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 1)
        //去除多餘的行數
        HandicapTableView.tableFooterView = UIView()
    }
    
    public static func create() -> HandicapInstructionView {
        let selfView = Bundle.main.loadNibNamed("HandicapInstructionView", owner: self, options: nil)?.first as! HandicapInstructionView
        return selfView
    }
    
}
