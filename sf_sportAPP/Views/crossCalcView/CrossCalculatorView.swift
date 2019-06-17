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
    
    @IBOutlet weak var betMoney: UITextField!
    @IBOutlet weak var winMoney: UITextField!
    
    @IBOutlet weak var bottomBetView: UIView!
    @IBOutlet weak var bottomBetViewHeight: NSLayoutConstraint!
    @IBOutlet weak var betMoneyKeyboardView: UIView!
    @IBOutlet weak var betMoneyNum_0: UIButton!
    @IBOutlet weak var betMoneyNum_1: UIButton!
    @IBOutlet weak var betMoneyNum_2: UIButton!
    @IBOutlet weak var betMoneyNum_3: UIButton!
    @IBOutlet weak var betMoneyNum_4: UIButton!
    @IBOutlet weak var betMoneyNum_5: UIButton!
    @IBOutlet weak var betMoneyNum_6: UIButton!
    @IBOutlet weak var betMoneyNum_7: UIButton!
    @IBOutlet weak var betMoneyNum_8: UIButton!
    @IBOutlet weak var betMoneyNum_9: UIButton!
    @IBOutlet weak var betMoneyBack: UIButton!
    @IBOutlet weak var betMoneyDot: UIButton!
    @IBOutlet weak var betMoneyKeyboardViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnCalc: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    public var isBetMoneyKB_Show = false
    public var nowClickBet: Int = -1
    public var isFirstAwake = true
    
    override func awakeFromNib() {
        initViews()
        isFirstAwake = false
    }
    
    public func initViews(){
        betMoneyKeyboardView.layer.borderColor = UIColor.blue.cgColor
        betMoneyKeyboardView.layer.borderWidth = 0.5
        betMoneyKeyboardView.layer.cornerRadius = 10
        betMoney.layer.borderColor = UIColor.blue.cgColor
        HideBetMoneyKeyBoard()
        
        headerView.layer.cornerRadius = 10
        headerView.layer.borderWidth = 1
        headerView.layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        noticeView.layer.cornerRadius = 10
        noticeView.layer.borderWidth = 1
        noticeView.layer.borderColor = UIColor.lightGray.cgColor
        
        btnCalc.layer.cornerRadius = 10
        btnClear.layer.cornerRadius = 10
        
        _GLobalService.oddsList.removeAll()
        _GLobalService.oddsPersent.removeAll()
        
        for i in 0...10 {
            _GLobalService.oddsList[i] = ""
            _GLobalService.oddsPersent[i] = ""
            _GLobalService.oddsCrossType[i] = "全贏"
        }
        
        //延遲cell物件點擊
        crossTableView.delaysContentTouches = false
        crossTableView.delegate = self
        crossTableView.dataSource = self
        let nib = UINib(nibName: "CrossCalculatorTableViewCell", bundle: nil)
        crossTableView.register(nib, forCellReuseIdentifier: "crossCell")
        
        
        betMoney.addTarget(self, action: #selector(ShowBetMoneyKeyBoard), for: .editingDidBegin)
        betMoneyNum_0.addTarget(self, action: #selector(betMoneyKeyboard_onClick(_:)), for: .touchUpInside)
        betMoneyNum_1.addTarget(self, action: #selector(betMoneyKeyboard_onClick(_:)), for: .touchUpInside)
        betMoneyNum_2.addTarget(self, action: #selector(betMoneyKeyboard_onClick(_:)), for: .touchUpInside)
        betMoneyNum_3.addTarget(self, action: #selector(betMoneyKeyboard_onClick(_:)), for: .touchUpInside)
        betMoneyNum_4.addTarget(self, action: #selector(betMoneyKeyboard_onClick(_:)), for: .touchUpInside)
        betMoneyNum_5.addTarget(self, action: #selector(betMoneyKeyboard_onClick(_:)), for: .touchUpInside)
        betMoneyNum_6.addTarget(self, action: #selector(betMoneyKeyboard_onClick(_:)), for: .touchUpInside)
        betMoneyNum_7.addTarget(self, action: #selector(betMoneyKeyboard_onClick(_:)), for: .touchUpInside)
        betMoneyNum_8.addTarget(self, action: #selector(betMoneyKeyboard_onClick(_:)), for: .touchUpInside)
        betMoneyNum_9.addTarget(self, action: #selector(betMoneyKeyboard_onClick(_:)), for: .touchUpInside)
        betMoneyBack.addTarget(self, action: #selector(betMoneyKeyboard_onClick(_:)), for: .touchUpInside)
        betMoneyDot.addTarget(self, action: #selector(betMoneyKeyboard_onClick(_:)), for: .touchUpInside)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(backBtn_onLongPress(_:)))
        longGesture.minimumPressDuration = 0.6
        betMoneyBack.addGestureRecognizer(longGesture)
        
        
        btnCalc.addTarget(self, action: #selector(CalcBetMoney), for: .touchUpInside)
        btnClear.addTarget(self, action: #selector(ClearAll), for: .touchUpInside)
    }
    
    @objc public func backBtn_onLongPress(_ sender: UILongPressGestureRecognizer){
        if sender.state == .ended{
            _GLobalService.isBackStillTOuch = false
            _GLobalService.timer_RemoveLastChar?.invalidate()
            return
        }else if sender.state == .began{
            _GLobalService.isBackStillTOuch = true
            _GLobalService.timer_RemoveLastChar = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(RemoveLastStr), userInfo: nil, repeats: true)
        }
    }
    
    @objc public func RemoveLastStr(){
        if _GLobalService.isBackStillTOuch {
            var tempText = betMoney.text!
            tempText = String(tempText.dropLast())
            betMoney.text = tempText
        }
    }
    
    @objc func betMoneyKeyboard_onClick(_ sender: UIButton) {
        var tempText = betMoney.text!
        
        //減號 最後位數捨去
        if sender.titleLabel?.text == "←"
        {
            tempText = String(tempText.dropLast())
        }
            //逗號 只能容許一個
        else if sender.titleLabel?.text == "."
        {
            if !tempText.isEmpty && !tempText.contains("."){
                tempText += sender.titleLabel?.text ?? ""
            }
        }
            //其餘數字
        else
        {
            //首位數不能給0
            if tempText.isEmpty && sender.titleLabel!.text == "0" { return }
            
            tempText += sender.titleLabel?.text ?? ""
        }
        
        betMoney.text = tempText
    }
    
    @objc public func ShowBetMoneyKeyBoard(){
        
        if isBetMoneyKB_Show && !isFirstAwake { return }
        
        //隱藏上方鍵盤
        //        self.nowClickBet = -1
        //        self.crossTableView.reloadData()
        HideAllOddsKB(type: 0)
        
        self.bottomBetViewHeight.constant = self.bottomBetViewHeight.constant + 90
        self.betMoneyKeyboardViewHeight.constant = 90
        self.betMoneyKeyboardView.isHidden = false
        self.betMoney.layer.borderWidth = 1
        self.betMoney.layer.cornerRadius = 5
        
        self.isBetMoneyKB_Show = true
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionFlipFromBottom, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @objc public func HideBetMoneyKeyBoard(){
        
        if !isBetMoneyKB_Show && !isFirstAwake { return }
        
        self.bottomBetViewHeight.constant = self.bottomBetViewHeight.constant - 90
        self.betMoneyKeyboardViewHeight.constant = 0
        self.betMoneyKeyboardView.isHidden = true
        self.betMoney.layer.borderWidth = 0
        self.betMoney.layer.cornerRadius = 0
        
        self.isBetMoneyKB_Show = false
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionFlipFromTop, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    public func HideAllOddsKB(type: Int){
        for cells in crossTableView.visibleCells {
            let cel = cells as! CrossCalculatorTableViewCell
            let idx = crossTableView.indexPath(for: cel)
            
            cel.keyboardHeight.constant = 0
            cel.keyboardView.isHidden = true
            cel.oddsText.layer.borderWidth = 0
            cel.oddsText.layer.cornerRadius = 0
            cel.crossPersentText.layer.borderWidth = 0
            cel.crossPersentText.layer.cornerRadius = 0
            
            if type == 0 && idx?.row == self.nowClickBet {
                self.nowClickBet = -1
                self.crossTableView.reloadRows(at: [idx!], with: .automatic)
            }
        }
    }
    
    @objc func crossType_onClick(sender: crossTypeTap){
        GlobalViewController.crossTypeCell = sender.cell
        GlobalViewController.nowCellCrossType = (sender.cell as! CrossCalculatorTableViewCell).crossTypeLabel.text!
        GlobalViewController.dialogType = 1
        GlobalViewController.ShowDialog()
    }
    
    @objc func CalcBetMoney(){
        
        if betMoney.text!.isEmpty { return }
        
        let _betMoney = Float(betMoney.text!)
        var result: Float = 0
        var calc: Float = 1
        var isNotCross: Bool = false
        for item in crossTableView.visibleCells {
            let cell = item as! CrossCalculatorTableViewCell
            if !cell.oddsText.text!.isEmpty {
                let odds = Float(cell.oddsText.text!)
                
                if cell.crossTypeLabel.text! == "全贏" {
                    calc *= Float( 1 + odds! )
                }
                else if cell.crossTypeLabel.text! == "全輸" {
                    isNotCross = true
                }
                else if cell.crossTypeLabel.text! == "+" {
                    let oddsPersent = Float(cell.crossPersentText.text!)! / 100
                    calc *= Float( 1 + Float( odds! * oddsPersent ) )
                }
                else if cell.crossTypeLabel.text! == "-" {
                    let oddsPersent = Float(cell.crossPersentText.text!)! / 100
                    calc *= Float( 1 - oddsPersent )
                }
            }
        }
        result += (_betMoney! * calc) - _betMoney!
        
        if isNotCross {
            result = 0 - _betMoney!
        }
        
        winMoney.text = String(lroundf(result))
    }
    
    @objc func ClearAll(){
        nowClickBet = -1
        for i in 0...10 {
            _GLobalService.oddsList[i] = ""
            _GLobalService.oddsPersent[i] = ""
            _GLobalService.oddsCrossType[i] = "全贏"
        }
        betMoney.text = ""
        winMoney.text = ""
        HideBetMoneyKeyBoard()
        self.endEditing(true)
        crossTableView.reloadData()
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
        
        cell.selectionStyle = .none
        
        cell.crossNumber.text = String(indexPath.row + 1)
        cell.oddsText.text = _GLobalService.oddsList[indexPath.row]
        cell.crossTypeLabel.text = _GLobalService.oddsCrossType[indexPath.row]
        cell.crossTypeLabel.textColor = .blue
        cell.crossTypeLabel.layer.cornerRadius = 10
        cell.crossTypeLabel.layer.borderWidth = 1
        cell.crossTypeLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.crossPersentText.placeholder = "100"
        //        cell.crossPersentText.text = _GLobalService.oddsPersent[indexPath.row]
        
        cell.oddsText.layer.borderColor = UIColor.blue.cgColor
        cell.crossPersentText.layer.borderColor = UIColor.blue.cgColor
        
        if indexPath.row == nowClickBet {
            cell.keyboardHeight.constant = 110
            cell.keyboardView.isHidden = false
            
            if _GLobalService.calcTextType == 0 {
                cell.oddsText.becomeFirstResponder()
                
                cell.oddsText.layer.borderWidth = 1
                cell.oddsText.layer.cornerRadius = 5
                
                cell.crossPersentText.layer.borderWidth = 0
                cell.crossPersentText.layer.cornerRadius = 0
            }else{
                cell.crossPersentText.becomeFirstResponder()
                
                cell.oddsText.layer.borderWidth = 0
                cell.oddsText.layer.cornerRadius = 0
                
                cell.crossPersentText.layer.borderWidth = 1
                cell.crossPersentText.layer.cornerRadius = 5
            }
            
        }else{
            cell.keyboardHeight.constant = 0
            cell.keyboardView.isHidden = true
            cell.oddsText.layer.borderWidth = 0
            cell.oddsText.layer.cornerRadius = 0
            cell.crossPersentText.layer.borderWidth = 0
            cell.crossPersentText.layer.cornerRadius = 0
        }
        
        //賠率輸入匡事件
        let myTapOdds = textFieldTap(target: self, action: #selector(oddsText_onClick))
        myTapOdds.cell = cell
        myTapOdds.idxPath = indexPath
        myTapOdds.type = 0
        cell.oddsText.addGestureRecognizer(myTapOdds)
        cell.oddsText.inputView = UIView()
        
        let myTapPersent = textFieldTap(target: self, action: #selector(oddsText_onClick))
        myTapPersent.cell = cell
        myTapPersent.idxPath = indexPath
        myTapPersent.type = 1
        cell.crossPersentText.addGestureRecognizer(myTapPersent)
        cell.crossPersentText.inputView = UIView()
        
        //註冊狀況
        let myTapTypeLabel = crossTypeTap(target: self, action: #selector(crossType_onClick))
        myTapTypeLabel.cell = cell
        myTapTypeLabel.idxPath = indexPath
        cell.crossTypeLabel.addGestureRecognizer(myTapTypeLabel)
        
        if cell.crossTypeLabel.text! == "全贏" || cell.crossTypeLabel.text! == "全輸" || cell.crossTypeLabel.text! == "平" {
            cell.crossPersentText.isEnabled = false
            cell.crossPersentText.text = "100"
        }else if  cell.crossTypeLabel.text! == "平"{
            cell.crossPersentText.isEnabled = false
            cell.crossPersentText.text = "0"
        }else{
            cell.crossPersentText.isEnabled = true
            //            cell.crossPersentText.text = ""
            cell.crossPersentText.text = _GLobalService.oddsPersent[indexPath.row]
        }
        
        if cell.crossTypeLabel.text! == "全贏" || cell.crossTypeLabel.text! == "+" {
            cell.crossTypeLabel.textColor = UIColor.blue
        }else if cell.crossTypeLabel.text! == "全輸" || cell.crossTypeLabel.text! == "-" {
            cell.crossTypeLabel.textColor = UIColor.red
        }else {
            cell.crossTypeLabel.textColor = UIColor.black
        }
        
        return cell
    }
    
    @objc func oddsText_onClick(sender: textFieldTap){
        //隱藏下注金額的鍵盤
        HideBetMoneyKeyBoard()
        
        let cell = sender.cell as! CrossCalculatorTableViewCell
        
        if _GLobalService.calcTextType != sender.type {
            
            if sender.type == 0 {
                cell.oddsText.becomeFirstResponder()
                
                cell.oddsText.layer.borderWidth = 1
                cell.oddsText.layer.cornerRadius = 5
                
                cell.crossPersentText.layer.borderWidth = 0
                cell.crossPersentText.layer.cornerRadius = 0
                
                cell.oddsText.inputView = UIView()
            }else{
                cell.crossPersentText.becomeFirstResponder()
                
                cell.oddsText.layer.borderWidth = 0
                cell.oddsText.layer.cornerRadius = 0
                
                cell.crossPersentText.layer.borderWidth = 1
                cell.crossPersentText.layer.cornerRadius = 5
                
                cell.crossPersentText.inputView = UIView()
            }
            
            _GLobalService.calcTextType = sender.type
        }
        
        if nowClickBet == Int(cell.crossNumber.text ?? "0")! - 1 { return }
        
        HideAllOddsKB(type: 1)
        
        _GLobalService.calcTextType = sender.type
        
        nowClickBet = Int(cell.crossNumber.text ?? "0")! - 1
        crossTableView.reloadRows(at: [sender.idxPath!], with: .automatic)
    }
    
    class textFieldTap: UITapGestureRecognizer{
        var cell: UITableViewCell?
        var idxPath: IndexPath?
        //0：賠率 1：趴數
        var type: Int = 0
    }
    
    class crossTypeTap: UITapGestureRecognizer{
        var cell: UITableViewCell?
        var idxPath: IndexPath?
    }
}

extension CrossCalculatorView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == nowClickBet {
            return 160
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
}
