//
//  LeagueView.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/21.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class LeagueView: UIView {
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var allChkImageView: UIImageView!
    @IBOutlet weak var leagueTableView: UITableView!
    
    override func awakeFromNib() {
        leagueTableView.delegate = self
        leagueTableView.dataSource = self
        
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        leagueTableView.register(nib, forCellReuseIdentifier: "leagueCell")
     
        confirmBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        
        //去除多餘的行數
        leagueTableView.tableFooterView = UIView()
        
        _GLobalService.tempLeagueSelectList = _GLobalService.LeagueSelectList
    }
    
    public static func create() -> LeagueView {
        let selfView = Bundle.main.loadNibNamed("LeagueView", owner: nil, options: nil)?.first as! LeagueView
        return selfView
    }
    
}

extension LeagueView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _GLobalService.LeagueList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueTableViewCell
        
        let leaName: String = _GLobalService.LeagueList[indexPath.row]
        
        let filter = _GLobalService.LeagueSelectList.filter({$0.contains(leaName)})
        
        if filter.count > 0 {
            cell.leagueCheckBoxImgView.image = UIImage(named: "ic_chk_true")
        }else{
            cell.leagueCheckBoxImgView.image = UIImage(named: "ic_chk_false")
        }
        
        cell.leagueNameLabel.text = leaName
        
        return cell
    }
    
}

extension LeagueView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LeagueTableViewCell
        
        let leaName: String = cell.leagueNameLabel.text ?? ""
        
        let filter = _GLobalService.LeagueSelectList.filter({$0.contains(leaName)})
        
        if filter.count > 0 {
            _GLobalService.tempLeagueSelectList.removeAll{$0 == leaName}
            cell.leagueCheckBoxImgView.image = UIImage(named: "ic_chk_false")
        }else{
            _GLobalService.tempLeagueSelectList.append(leaName)
//            _GLobalService.LeagueSelectList.append(leaName)
            cell.leagueCheckBoxImgView.image = UIImage(named: "ic_chk_true")
        }
    }
}
