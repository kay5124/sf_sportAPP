//
//  NoticeView.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/29.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit
import SwiftyJSON

class NoticeView: UIView {
    @IBOutlet weak var noticeTypeBtn: UIButton!
    @IBOutlet weak var userMoney: UILabel!
    @IBOutlet weak var noticeTableView: UITableView!
    
    public var noticeData: Array<noticeModel> = Array()
    
    //    private var noticeObj: noticeModel
    
    override func awakeFromNib() {
        
        if _GLobalService.noticeData.count == 0
        {
            _GLobalService.noticeData.append(noticeModel(noticeType: "公告", noticeDate: "2019/05/02 17:15:00", noticeContent: "測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試", isExpan: false))
            _GLobalService.noticeData.append(noticeModel(noticeType: "足球", noticeDate: "2019/05/02 17:15:00", noticeContent: "測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試", isExpan: false))
            _GLobalService.noticeData.append(noticeModel(noticeType: "其他", noticeDate: "2019/05/02 17:15:00", noticeContent: "測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試", isExpan: false))
            _GLobalService.noticeData.append(noticeModel(noticeType: "籃球", noticeDate: "2019/05/02 17:15:00", noticeContent: "測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試", isExpan: false))
            _GLobalService.noticeData.append(noticeModel(noticeType: "冰球", noticeDate: "2019/05/02 17:15:00", noticeContent: "測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試", isExpan: false))
        }
        
        noticeData = _GLobalService.noticeData
        
        noticeTableView.tableFooterView = UIView()
        noticeTableView.separatorStyle = .none
        
        userMoney.text = _GLobalService.userMoney
        noticeTypeBtn.layer.cornerRadius = 10
        noticeTypeBtn.layer.borderColor = UIColor.white.cgColor
        noticeTypeBtn.layer.borderWidth = 1
        
        noticeTableView.dataSource = self
        noticeTableView.delegate = self
        let nib = UINib(nibName: "NoticeTableViewCell", bundle: nil)
        noticeTableView.register(nib, forCellReuseIdentifier: "noticeCell")
        
    }
    
    public static func create() -> NoticeView {
        let selfView = Bundle.main.loadNibNamed("NoticeView", owner: self, options: nil)?.first as! NoticeView
        return selfView
    }
    
}

extension NoticeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        let noticeCnt = noticeData.filter({$1["noticeType"].string == noticeTypeBtn.title(for: .normal)!})
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
    
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 5
    //    }
}

