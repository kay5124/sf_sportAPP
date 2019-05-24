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

class GlobalViewController: UIViewController {
    @IBOutlet weak var customView: UIView!
    public var nowView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        enableSideMenu(false)
        
        InitView()
    }
    
    public func InitView(){
        let item = _GLobalService.sideMenuItems.filter({$0.key.contains(String(_GLobalService.menuClickIdx))}).first
        self.title = item?.key.components(separatedBy: "_")[1] ?? ""
        
        var changeView: UIView?
        
        //盤口說明
        if _GLobalService.menuClickIdx == 3 {
            changeView = HandicapInstructionView.create()
            (changeView as! HandicapInstructionView).pageBtn.addTarget(self, action: #selector(handicapPage_onChange(_:)), for: .valueChanged)
        }
        
        changeView?.frame = CGRect(x: 0, y: 0, width: self.customView.frame.width, height: self.customView.frame.height)
        customView.addSubview(changeView ?? UIView())
        nowView = changeView ?? UIView()
        reloadTableData()
    }
    
    @objc func handicapPage_onChange(_ sender: UISegmentedControl){
        let handicapView = (nowView as! HandicapInstructionView)
        handicapView.HandicapTableView.reloadData()
    }
    
    public func reloadTableData(){
        let handicapView = (nowView as! HandicapInstructionView)
        handicapView.HandicapTableView.dataSource = self
        //設定每列row的高度
        let height = handicapView.HandicapTableView.frame.height
        handicapView.HandicapTableView.rowHeight = height / CGFloat(HandicapInstructionService.handicapData.count) - 5
        
        //註冊nib
        let nib = UINib(nibName: "HandicapInsTableViewCell", bundle: nil)
        handicapView.HandicapTableView.register(nib, forCellReuseIdentifier: "handicapCell")
        //重新讀取資料
        handicapView.HandicapTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        enableSideMenu(true)
    }
    
}


extension GlobalViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let handicapView = (nowView as! HandicapInstructionView)
        if handicapView.pageBtn.selectedSegmentIndex == 0 {
            return HandicapInstructionService.handicapData.count
        }else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let handicapView = (nowView as! HandicapInstructionView)
        if handicapView.pageBtn.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "handicapCell", for: indexPath) as! HandicapInsTableViewCell
            let Item = HandicapInstructionService.handicapData[indexPath.row].components(separatedBy: "_")
            
            cell.handicapLabel.text = Item[0]
            cell.conLabel.text = Item[1]
            cell.descritionLabel.text = Item[2]
            
            cell.layer.addBorder(edge: .top, color: .lightGray, thickness: 1)
            
            var attributedString: NSMutableAttributedString = NSMutableAttributedString(string: Item[2])
            attributedString.setColor(color: UIColor.blue, forText: "讓分隊伍")
            attributedString.setColor(color: UIColor.green, forText: "受讓隊伍")
            
            cell.descritionLabel.attributedText = attributedString
            
            return cell
        }else {
            return UITableViewCell()
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
