//
//  NoticeView.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/29.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit
//import SwiftyJSON

class NoticeView: UIView {
    @IBOutlet weak var noticeTypeCollectionView: UICollectionView!
    @IBOutlet weak var userMoney: UILabel!
    @IBOutlet weak var noticeTableView: UITableView!
    
    public var noticeData: Array<noticeModel> = Array()
    public var nowNoticeType: String = ""
    public var isFirst: Bool = true
    
    //    private var noticeObj: noticeModel
    
    override func awakeFromNib() {
        nowNoticeType = "所有"
        
        if _GLobalService.noticeData.count == 0
        {
            for notice in _GLobalService.noticeTypeItems {
                _GLobalService.noticeData.append(noticeModel(noticeType: notice, noticeDate: "2019/05/02 17:15:00", noticeContent: "測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試", isExpan: false))
            }
        }
        
        noticeData = _GLobalService.noticeData
        
        noticeTableView.tableFooterView = UIView()
        noticeTableView.separatorStyle = .none
        
        userMoney.text = _GLobalService.userMoney
        
        noticeTableView.dataSource = self
        noticeTableView.delegate = self
        let nib = UINib(nibName: "NoticeTableViewCell", bundle: nil)
        noticeTableView.register(nib, forCellReuseIdentifier: "noticeCell")
        
        noticeTypeCollectionView.delegate = self
        noticeTypeCollectionView.dataSource = self
        let collNib = UINib(nibName: "noticeTypeCollectionViewCell", bundle: nil)
        noticeTypeCollectionView.register(collNib, forCellWithReuseIdentifier: "noticeCollCell")
        noticeTypeCollectionView.showsHorizontalScrollIndicator = false
        noticeTypeCollectionView.showsVerticalScrollIndicator = false
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
