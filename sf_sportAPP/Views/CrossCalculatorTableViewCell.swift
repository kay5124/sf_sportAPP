//
//  CrossCalculatorTableViewCell.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/29.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class CrossCalculatorTableViewCell: UITableViewCell {

    @IBOutlet weak var crossNumber: UILabel!
    @IBOutlet weak var oddsText: UITextField!
    @IBOutlet weak var crossTypeLabel: UILabel!
    @IBOutlet weak var crossPersentText: UITextField!
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var oddsKeyboardView: UIView!
    @IBOutlet weak var keyboardHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var oddsBtnNum_0: UIButton!
    @IBOutlet weak var oddsBtnNum_1: UIButton!
    @IBOutlet weak var oddsBtnNum_2: UIButton!
    @IBOutlet weak var oddsBtnNum_3: UIButton!
    @IBOutlet weak var oddsBtnNum_4: UIButton!
    @IBOutlet weak var oddsBtnNum_5: UIButton!
    @IBOutlet weak var oddsBtnNum_6: UIButton!
    @IBOutlet weak var oddsBtnNum_7: UIButton!
    @IBOutlet weak var oddsBtnNum_8: UIButton!
    @IBOutlet weak var oddsBtnNum_9: UIButton!
    @IBOutlet weak var oddsBtnBack: UIButton!
    @IBOutlet weak var oddsBtnDot: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        oddsKeyboardView.layer.borderColor = UIColor.blue.cgColor
        oddsKeyboardView.layer.borderWidth = 0.5
        oddsKeyboardView.layer.cornerRadius = 10
        
//        keyboardHeight.constant = 0
//        keyboardView.isHidden = true
        oddsBtnNum_0.addTarget(self, action: #selector(oddsKeyboard_onClick(_:)), for: .touchUpInside)
        oddsBtnNum_1.addTarget(self, action: #selector(oddsKeyboard_onClick(_:)), for: .touchUpInside)
        oddsBtnNum_2.addTarget(self, action: #selector(oddsKeyboard_onClick(_:)), for: .touchUpInside)
        oddsBtnNum_3.addTarget(self, action: #selector(oddsKeyboard_onClick(_:)), for: .touchUpInside)
        oddsBtnNum_4.addTarget(self, action: #selector(oddsKeyboard_onClick(_:)), for: .touchUpInside)
        oddsBtnNum_5.addTarget(self, action: #selector(oddsKeyboard_onClick(_:)), for: .touchUpInside)
        oddsBtnNum_6.addTarget(self, action: #selector(oddsKeyboard_onClick(_:)), for: .touchUpInside)
        oddsBtnNum_7.addTarget(self, action: #selector(oddsKeyboard_onClick(_:)), for: .touchUpInside)
        oddsBtnNum_8.addTarget(self, action: #selector(oddsKeyboard_onClick(_:)), for: .touchUpInside)
        oddsBtnNum_9.addTarget(self, action: #selector(oddsKeyboard_onClick(_:)), for: .touchUpInside)
        oddsBtnBack.addTarget(self, action: #selector(oddsKeyboard_onClick(_:)), for: .touchUpInside)
        oddsBtnDot.addTarget(self, action: #selector(oddsKeyboard_onClick(_:)), for: .touchUpInside)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(backBtn_onLongPress(_:)))
        longGesture.minimumPressDuration = 0.6
        oddsBtnBack.addGestureRecognizer(longGesture)
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
            var tempText = oddsText.text!
            let idx = Int(crossNumber.text!)! - 1
            tempText = String(tempText.dropLast())
            
            if _GLobalService.calcTextType == 0 {
                oddsText.text = tempText
                _GLobalService.oddsList[idx] = tempText
            }else{
                crossPersentText.text = tempText
                _GLobalService.oddsPersent[idx] = tempText
            }
        }
    }

    @objc func oddsKeyboard_onClick(_ sender: UIButton) {
        var tempText = oddsText.text!
        let idx = Int(crossNumber.text!)! - 1
        
        //判斷是不是趴數
        if _GLobalService.calcTextType == 1 { tempText = crossPersentText.text! }
    
        //減號 最後位數捨去
        if sender.titleLabel?.text == "←"
        {
            tempText = String(tempText.dropLast())
        }
        //逗號 只能容許一個 只有賠率有。 趴數直接跳過
        else if sender.titleLabel?.text == "."
        {
            if _GLobalService.calcTextType == 1 { return }
            
            if !tempText.isEmpty && !tempText.contains(".") && _GLobalService.calcTextType == 0 {
                tempText += sender.titleLabel?.text ?? ""
            }
        }
        //其餘數字
        else
        {
            //首位數不能給0
            if tempText.isEmpty && sender.titleLabel!.text == "0" && _GLobalService.calcTextType == 1 { return }
            
            tempText += sender.titleLabel?.text ?? ""
        }
        
        //如果趴數超過100則歸零
        if !tempText.isEmpty  && _GLobalService.calcTextType == 1 && Float(tempText)! > 100
        {
            tempText = ""
        }
        
        if _GLobalService.calcTextType == 0 {
            oddsText.text = tempText
            _GLobalService.oddsList[idx] = tempText
        }else{
            crossPersentText.text = tempText
            _GLobalService.oddsPersent[idx] = tempText
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

