//
//  GlobalViewController.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/24.
//  Copyright © 2019 Ray  . All rights reserved.
//

import Foundation
import UIKit
import SideMenu
import SwiftyJSON

class GlobalViewController: UIViewController {
    @IBOutlet weak var customView: UIView!
    public var tempViewController: UIViewController?
    public var nowView: UIView?
    public var dialogViewController: UIViewController?
    public var noticeType = "所有"
    public var tempNoticeType = "所有"
    public var handicapType: Int = 0
    public static var dialogType = -1
    public static var crossTypeCell: UITableViewCell?
    public var crossType = "全贏"
    public var tempCrossType = "全贏"
    public static var nowCellCrossType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        enableSideMenu(false)
        
        InitView()
    }
    
    public func InitView(){
        tempViewController = _GLobalService.nowViewController
        _GLobalService.nowViewController = self
        dialogViewController = storyboard?.instantiateViewController(withIdentifier: "vc_Dialog") as! CustomDialogViewController
        
        let item = _GLobalService.sideMenuItems.filter({$0.key.contains(String(_GLobalService.menuClickIdx))}).first
        self.title = item?.key.components(separatedBy: "_")[1] ?? ""
        
        var changeView: UIView?
        //過關計算器
        if _GLobalService.menuClickIdx == 2 {
            
            changeView = CrossCalculatorView.create()
            // MARK: - 键盘即将弹出
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        }
        //盤口說明
        else if _GLobalService.menuClickIdx == 3 {
            changeView = HandicapInstructionView.create()
            (changeView as! HandicapInstructionView).pageBtn.addTarget(self, action: #selector(handicapPage_onChange(_:)), for: .valueChanged)
            (changeView as! HandicapInstructionView).sampleDesView.layer.borderColor = UIColor.lightGray.cgColor
            (changeView as! HandicapInstructionView).sampleDesView.layer.borderWidth = 1
            (changeView as! HandicapInstructionView).sampleDesView.layer.cornerRadius = 10
            (changeView as! HandicapInstructionView).constaint_height.constant = 0
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
            swipeLeft.direction = .left
            
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
            swipeRight.direction = .right
            
            (changeView as! HandicapInstructionView).HandicapTableView.addGestureRecognizer(swipeLeft)
            (changeView as! HandicapInstructionView).HandicapTableView.addGestureRecognizer(swipeRight)
        }
        //公告
        else if _GLobalService.menuClickIdx == 7 {
            changeView = NoticeView.create()
            let dialogView = changeView as! NoticeView
            dialogView.noticeTypeBtn.addTarget(self, action: #selector(noticeTypeBtn_onClick), for: .touchUpInside)
        }
        
        changeView?.frame = CGRect(x: 0, y: 0, width: self.customView.frame.width, height: self.customView.frame.height)
        customView.addSubview(changeView ?? UIView())
        nowView = changeView ?? UIView()
        
        if _GLobalService.menuClickIdx == 3 { reloadTableData() }
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        view.endEditing(true)
    }
    
    @objc func swipe(_ recognizer:UISwipeGestureRecognizer){
        if _GLobalService.menuClickIdx == 3 {
            let handicapView = (nowView as! HandicapInstructionView)
            //左滑
            if recognizer.direction == .left{
                if handicapView.pageBtn.selectedSegmentIndex == 0 {
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        handicapView.pageBtn.selectedSegmentIndex = 1
                        handicapView.headerStackView.isHidden = true
                        handicapView.sampleHeaderStackView.isHidden = false
                        handicapView.sampleDesView.isHidden = false
                        handicapView.constaint_height.constant = 140
                    })
                }
            }
            //右滑
            else if recognizer.direction == .right{
                
                if handicapView.pageBtn.selectedSegmentIndex == 1 {
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        handicapView.pageBtn.selectedSegmentIndex = 0
                        handicapView.headerStackView.isHidden = false
                        handicapView.sampleHeaderStackView.isHidden = true
                        handicapView.sampleDesView.isHidden = true
                        handicapView.constaint_height.constant = 0
                    })
                }
            }
            reloadTableData()
        }
//        let point=recognizer.location(in: self.view)
//        //这个点是滑动的起点
//        print(point.x)
//        print(point.y)
    }
    
    @objc func handicapPage_onChange(_ sender: UISegmentedControl){
        let handicapView = (nowView as! HandicapInstructionView)
        //        let height = handicapView.HandicapView.frame.height + handicapView.sampleDesView.frame.height
        if handicapView.pageBtn.selectedSegmentIndex == 0 {
            handicapView.headerStackView.isHidden = false
            handicapView.sampleHeaderStackView.isHidden = true
            handicapView.sampleDesView.isHidden = true
            handicapView.constaint_height.constant = 0
        }else{
            handicapView.headerStackView.isHidden = true
            handicapView.sampleHeaderStackView.isHidden = false
            handicapView.sampleDesView.isHidden = false
            handicapView.constaint_height.constant = 140
        }
        reloadTableData()
    }
    
    public func reloadTableData(){
        let handicapView = (nowView as! HandicapInstructionView)
        handicapView.HandicapTableView.dataSource = self
        
        //註冊nib
        let nib = UINib(nibName: "HandicapInsTableViewCell", bundle: nil)
        handicapView.HandicapTableView.register(nib, forCellReuseIdentifier: "handicapCell")
        let nib2 = UINib(nibName: "HandicapSampleTableViewCell", bundle: nil)
        handicapView.HandicapTableView.register(nib2, forCellReuseIdentifier: "handicapCell2")
        
        //設定每列row的高度
        let height = handicapView.HandicapTableView.frame.height
        if handicapView.pageBtn.selectedSegmentIndex == 0
        {
            handicapView.HandicapTableView.rowHeight = 40
        }
        else
        {
            handicapView.HandicapTableView.rowHeight = height / CGFloat(HandicapInstructionService.handicapSampleData.count) - 5
        }
        
        //重新讀取資料
        handicapView.HandicapTableView.reloadData()
    }
    
    @objc func noticeTypeBtn_onClick(){
        GlobalViewController.dialogType = 0
        dialogShow()
    }
    
    @objc func dialogConfirmBtn_onClick(){
        let dialog = dialogViewController as! CustomDialogViewController
        
        if GlobalViewController.dialogType == 0
        {
            noticeType = tempNoticeType
            (nowView as! NoticeView).noticeTypeBtn.setTitle(noticeType, for: .normal)
            
            if noticeType == "所有" {
                (nowView as! NoticeView).noticeData = _GLobalService.noticeData
            }else {
                var newArrayData: Array<noticeModel> = Array()
                let newData = _GLobalService.noticeData.filter({$0.noticeType == noticeType})
                for item in newData{
                    newArrayData.append(item.self)
                }
                (nowView as! NoticeView).noticeData = newArrayData
            }
            
            (nowView as! NoticeView).noticeTableView.reloadData()
        }
        else if GlobalViewController.dialogType == 1
        {
            crossType = tempCrossType
            let cell = GlobalViewController.crossTypeCell as! CrossCalculatorTableViewCell
            let idx = (nowView as! CrossCalculatorView).crossTableView.indexPath(for: cell)
            
            cell.crossTypeLabel.text = crossType
            _GLobalService.oddsCrossType[idx!.row] = crossType
            
            if crossType == "+" || crossType == "-" {
                _GLobalService.oddsPersent[idx!.row] = ""
                cell.crossPersentText.text = ""
                cell.crossPersentText.isEnabled = true
               
                if crossType == "+" {
                    cell.crossTypeLabel.textColor = UIColor.blue
                }else{
                    cell.crossTypeLabel.textColor = UIColor.red
                }
            }
            else {
                _GLobalService.oddsPersent[idx!.row] = "100"
                cell.crossPersentText.text = "100"
                cell.crossPersentText.isEnabled = false
                
                if crossType == "全輸" {
                    cell.crossTypeLabel.textColor = UIColor.red
                }
                else if crossType == "平" {
                    _GLobalService.oddsPersent[idx!.row] = "0"
                    cell.crossPersentText.text = "0"
                    cell.crossTypeLabel.textColor = UIColor.black
                }
                else {
                    cell.crossTypeLabel.textColor = UIColor.blue
                }
                
            }
            
        }
        
        dialog.dismiss(animated: true, completion: nil)
    }
    
    @objc func dialogCancelBtn_onClick(){
        let dialog = dialogViewController as! CustomDialogViewController
        dialog.dismiss(animated: true, completion: nil)
    }
    
    public static func ShowDialog(){
        let nowVC = _GLobalService.nowViewController as! GlobalViewController
        nowVC.dialogShow()
    }
    
    public func dialogShow(){
        let dialog = dialogViewController as! CustomDialogViewController
        present(dialog, animated: true, completion: nil)
        
        let dialogView = CusDataPickerView.create()
        dialogView.frame = CGRect(x: 0, y: 0, width: dialog.CusView.frame.width, height: dialog.CusView.frame.height)
        dialogView.dataPicker.dataSource = self
        dialogView.dataPicker.delegate = self
        dialogView.confirmBtn.addTarget(self, action: #selector(dialogConfirmBtn_onClick), for: .touchUpInside)
        dialogView.cancelBtn.addTarget(self, action: #selector(dialogCancelBtn_onClick), for: .touchUpInside)
        dialog.CusView.addSubview(dialogView)
        
        if GlobalViewController.dialogType == 0 {
            let noticeTypeIdx = _GLobalService.noticeTypeItems.firstIndex(where: { (item) -> Bool in item == noticeType })
            dialogView.dataPicker.selectRow(noticeTypeIdx!, inComponent: 0, animated: true)
        }else if GlobalViewController.dialogType == 1 {
            let crossTypeIdx = _GLobalService.crossTypeItems.firstIndex(where: { (item) -> Bool in item == GlobalViewController.nowCellCrossType })
            dialogView.dataPicker.selectRow(crossTypeIdx!, inComponent: 0, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        enableSideMenu(true)
        
        _GLobalService.nowViewController = tempViewController
    }
    
}

extension GlobalViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let handicapView = (nowView as! HandicapInstructionView)
        if handicapView.pageBtn.selectedSegmentIndex == 0 { return HandicapInstructionService.handicapData.count }
        else { return HandicapInstructionService.handicapSampleData.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell: UITableViewCell?
        let handicapView = (nowView as! HandicapInstructionView)
        if handicapView.pageBtn.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "handicapCell", for: indexPath) as! HandicapInsTableViewCell
            let Item = HandicapInstructionService.handicapData[indexPath.row].components(separatedBy: "_")
            
            cell.handicapLabel.text = Item[0]
            cell.conLabel.text = Item[1]
            cell.descritionLabel.text = Item[2]
            
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: Item[2])
            attributedString.setColor(color: UIColor.blue, forText: "讓分隊伍")
            attributedString.setColor(color: UIColor.green, forText: "受讓隊伍")
            
            cell.descritionLabel.attributedText = attributedString
            
            returnCell = cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "handicapCell2", for: indexPath) as! HandicapSampleTableViewCell
            let Item = HandicapInstructionService.handicapSampleData[indexPath.row].components(separatedBy: "_")
            
            cell.topLeftLabel.text = Item[0]
            cell.topCenterLabel.text = Item[1]
            cell.bTopLabel.text = Item[2]
            cell.bBottomLabel.text = Item[3]
            cell.bTopRightLabel.text = Item[4]
            cell.bBottomRightLabel.text = Item[5]
            
            //            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: Item[4])
            //            attributedString.setColor(color: UIColor.blue, forText: "35%")
            //            attributedString.setColor(color: UIColor.blue, forText: "$315")
            //            attributedString.setColor(color: UIColor.blue, forText: "65%")
            //            attributedString.setColor(color: UIColor.blue, forText: "$585")
            //            attributedString.setColor(color: UIColor.blue, forText: "25%")
            //            attributedString.setColor(color: UIColor.blue, forText: "$225")
            //            attributedString.setColor(color: UIColor.blue, forText: "75%")
            //            attributedString.setColor(color: UIColor.blue, forText: "$675")
            //            cell.bTopRightLabel.attributedText = attributedString
            //
            //            let attributedString2: NSMutableAttributedString = NSMutableAttributedString(string: Item[5])
            //            attributedString2.setColor(color: UIColor.red, forText: "35%")
            //            attributedString2.setColor(color: UIColor.red, forText: "$-350")
            //            attributedString2.setColor(color: UIColor.red, forText: "65%")
            //            attributedString2.setColor(color: UIColor.red, forText: "$-650")
            //            attributedString2.setColor(color: UIColor.red, forText: "25%")
            //            attributedString2.setColor(color: UIColor.red, forText: "$-250")
            //            attributedString2.setColor(color: UIColor.red, forText: "75%")
            //            attributedString2.setColor(color: UIColor.red, forText: "$-750")
            //            cell.bBottomRightLabel.attributedText = attributedString2
            
            returnCell = cell
        }
        
        
        return returnCell ?? UITableViewCell()
    }
    
}

extension GlobalViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let type = GlobalViewController.dialogType
        if type == 0 {
            return _GLobalService.noticeTypeItems.count
        }
        else if type == 1 {
            return _GLobalService.crossTypeItems.count
        }
        
        return 0
    }
    
}

extension GlobalViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let type = GlobalViewController.dialogType
        if type == 0
        {
            return _GLobalService.noticeTypeItems[row]
        }
        else if type == 1
        {
            return _GLobalService.crossTypeItems[row]
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        let type = GlobalViewController.dialogType
        if type == 0
        {
            return 60
        }
        else if type == 1
        {
            return 30
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let type = GlobalViewController.dialogType
        
        if type == 0
        {
            tempNoticeType = _GLobalService.noticeTypeItems[row]
        }
        else if type == 1
        {
            tempCrossType = _GLobalService.crossTypeItems[row]
        }
    }
    
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer();
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x:0, y:self.frame.height + 9, width:self.frame.width, height:thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x:self.frame.width - thickness, y: 0, width: thickness, height:self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}
