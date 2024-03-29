//
//  NoticeView.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/29.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NoticeView: UIView {
    @IBOutlet weak var noticeTypeCollectionView: UICollectionView!
    @IBOutlet weak var userMoney: UILabel!
    @IBOutlet weak var noticeTableView: UITableView!
    
    public var noticeType: Int = 0
    public var noticeData: Array<noticeModel> = Array()
    public var nowNoticeType: String = ""
    
    override func awakeFromNib() {
        _GLobalService.noticeData.removeAll()
        nowNoticeType = "所有"
        self.userMoney.text = _GLobalService.userMoney
        
        self.noticeTableView.tableFooterView = UIView()
        self.noticeTableView.separatorStyle = .none
        
        self.noticeTypeCollectionView.delegate = self
        self.noticeTypeCollectionView.dataSource = self
        let collNib = UINib(nibName: "noticeTypeCollectionViewCell", bundle: nil)
        self.noticeTypeCollectionView.register(collNib, forCellWithReuseIdentifier: "noticeCollCell")
        self.noticeTypeCollectionView.showsHorizontalScrollIndicator = false
        self.noticeTypeCollectionView.showsVerticalScrollIndicator = false
        
        _GLobalService.loadingView.show(on: self)
        let parameters = ["_token" : _GLobalService.apiToken, "noticeType" : String(noticeType)]
        
        Alamofire.request(_GLobalService.apiAddress + "getNotice", method: .post, parameters: parameters).validate().responseJSON{ (response) in
            switch response.result {
            case .success(_):
                _GLobalService.loadingView.hide()
                let json = try? JSON(data: response.data!)
                for item in json!["noticeData"].array! {
                    _GLobalService.noticeData.append(noticeModel(noticeType: item["title"].string!, noticeDate: item["start_time"].string!, noticeContent: item["msg"].string!, isExpan: false))
                }
                
                self.noticeData = _GLobalService.noticeData
                
                self.noticeTableView.dataSource = self
                self.noticeTableView.delegate = self
                let nib = UINib(nibName: "NoticeTableViewCell", bundle: nil)
                self.noticeTableView.register(nib, forCellReuseIdentifier: "noticeCell")
                
                self.noticeTableView.reloadData()
            case .failure(_):
                _GLobalService.loadingView.hide()
                _GLobalService.nowViewController?.showAlertDialog("錯誤", "請檢查網路連線")
            }
        }
    }
    
    public static func create() -> NoticeView {
        let selfView = Bundle.main.loadNibNamed("NoticeView", owner: self, options: nil)?.first as! NoticeView
        return selfView
    }
    
}

extension NoticeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell") as! NoticeTableViewCell
        
        do {
            cell.noticeType.text = noticeData[indexPath.row].noticeType
            cell.noticeDate.text = noticeData[indexPath.row].noticeDate
            cell.noticeContent.text = noticeData[indexPath.row].noticeContent
            
            if noticeData[indexPath.row].isExpan == false {
                cell.noticeContent.numberOfLines = 1
                cell.noticeExpanLabel.text = "▼"
            }
            else {
                cell.noticeContent.numberOfLines = 0
                cell.noticeExpanLabel.text = "▲"
            }
            
            return cell
            
        } catch {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 8
        
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
}

extension NoticeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if noticeData[indexPath.row].isExpan == false {
            return 90
        }else {
            return 140
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noticeData[indexPath.row].isExpan = !noticeData[indexPath.row].isExpan
        noticeTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}

extension NoticeView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _GLobalService.noticeTypeItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noticeCollCell", for: indexPath) as! noticeTypeCollectionViewCell
        
        cell.noticeTypeLabel.text = _GLobalService.noticeTypeItems[indexPath.row]
        cell.noticeTypeLabel.layer.cornerRadius = 10
        cell.noticeTypeLabel.layer.borderColor = UIColor.white.cgColor
        
        if cell.noticeTypeLabel.text! == nowNoticeType {
            cell.noticeTypeLabel.layer.borderWidth = 1
        }else{
            cell.noticeTypeLabel.layer.borderWidth = 0
        }
        
        let myTap = TapClass(target: self, action: #selector(noticeTypeBtn_onClick(sender:)))
        myTap.title = _GLobalService.noticeTypeItems[indexPath.row]
        cell.noticeTypeLabel.addGestureRecognizer(myTap)
        
        return cell
    }
    
    class TapClass: UITapGestureRecognizer {
        var title: String = ""
    }
    
    @objc func noticeTypeBtn_onClick(sender: TapClass){
        let noticeType = sender.title
        
        if noticeType == "所有" {
            noticeData = _GLobalService.noticeData
        }else{
            var newArrayData: Array<noticeModel> = Array()
            let newData = _GLobalService.noticeData.filter({$0.noticeType == noticeType})
            for item in newData{
                newArrayData.append(item.self)
            }
            noticeData = newArrayData
        }
        
        nowNoticeType = sender.title
        noticeTableView.reloadData()
        noticeTypeCollectionView.reloadData()
    }
    
}
