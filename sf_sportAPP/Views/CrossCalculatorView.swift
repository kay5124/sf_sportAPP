//
//  CrossCalculatorView.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/29.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class CrossCalculatorView: UIView {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var crossTableView: UITableView!
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var calcBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var betMoney: UITextField!
    @IBOutlet weak var winMoney: UITextField!
    
    override func awakeFromNib() {
        headerView.layer.cornerRadius = 10
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        noticeView.layer.cornerRadius = 10
        noticeView.layer.borderWidth = 1
        noticeView.layer.borderColor = UIColor.lightGray.cgColor
        
        calcBtn.layer.cornerRadius = 10
        clearBtn.layer.cornerRadius = 10
        
        crossTableView.dataSource = self
        let nib = UINib(nibName: "CrossCalculatorTableViewCell", bundle: nil)
        crossTableView.register(nib, forCellReuseIdentifier: "crossCell")
        
        crossTableView.rowHeight = crossTableView.frame.height / 10 - 5
    }
    
    public static func create() -> CrossCalculatorView{
        let selfView = Bundle.main.loadNibNamed("CrossCalculatorView", owner: self, options: nil)?.first as! CrossCalculatorView
        return selfView
    }

}

extension CrossCalculatorView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "crossCell", for: indexPath) as! CrossCalculatorTableViewCell
        
        cell.crossNumber.text = String(indexPath.row + 1)
        cell.oddsText.text = ""
        cell.crossTypeLabel.text = "  全贏"
        cell.crossTypeLabel.textColor = .blue
        cell.crossTypeLabel.layer.cornerRadius = 10
        cell.crossTypeLabel.layer.borderWidth = 1
        cell.crossTypeLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.crossPersentText.placeholder = "100"
        
        return cell
    }
    
    
}
