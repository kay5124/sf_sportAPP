//
//  ConfirmBetView.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/6/16.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class ConfirmBetView: UIView {
    @IBOutlet weak var betTitle: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var awayTeam: UILabel!
    @IBOutlet weak var betDetailView: UIView!
    @IBOutlet weak var betType: UILabel!
    @IBOutlet weak var con: UILabel!
    @IBOutlet weak var odds: UILabel!
    @IBOutlet weak var autoReciveBetterOddsBtn: UIButton!
    @IBOutlet weak var setDefaultBetMoneyBtn: UIButton!
    @IBOutlet weak var betMoney: UITextField!
    @IBOutlet weak var quickSetMoneyView: UIView!
    @IBOutlet weak var moneyKeyboardView: UIView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var titleView: UIView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        betDetailView.layer.cornerRadius = 10
        
        autoReciveBetterOddsBtn.layer.cornerRadius = 10
        
        setDefaultBetMoneyBtn.layer.cornerRadius = 10
        
        quickSetMoneyView.layer.cornerRadius = 10
        quickSetMoneyView.layer.borderWidth = 1
        quickSetMoneyView.layer.borderColor = UIColor.lightGray.cgColor
        
        moneyKeyboardView.layer.cornerRadius = 10
        moneyKeyboardView.layer.borderWidth = 1
        moneyKeyboardView.layer.borderColor = UIColor.blue.cgColor
        
        confirmBtn.layer.cornerRadius = 10
    }
    
    public static func create() -> ConfirmBetView{
        let selfView = Bundle.main.loadNibNamed("ConfirmBetView", owner: self, options: nil)?.first as! ConfirmBetView
        return selfView
    }

}
