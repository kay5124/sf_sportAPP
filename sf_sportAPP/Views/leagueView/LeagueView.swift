//
//  LeagueView.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/21.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class LeagueView: UIView {
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var allChkImageView: UIImageView!
    @IBOutlet weak var leagueTableView: UITableView!
    
    public var leaguesData: Array<leagueModel> = Array()
    
    override func awakeFromNib() {
        
        leaguesData = _GLobalService.leaguesData
        
        self.leagueTableView.delegate = self
        self.leagueTableView.dataSource = self
        
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        self.leagueTableView.register(nib, forCellReuseIdentifier: "leagueCell")
        
        self.confirmBtn.layer.cornerRadius = 10
        self.cancelBtn.layer.cornerRadius = 10
        
        //去除多餘的行數
        self.leagueTableView.tableFooterView = UIView()
        leagueTableView.allowsSelection = false
        
    }
    
    public static func create() -> LeagueView {
        let selfView = Bundle.main.loadNibNamed("LeagueView", owner: nil, options: nil)?.first as! LeagueView
        return selfView
    }
    
}

extension LeagueView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueTableViewCell
        
        if leaguesData[indexPath.row].isChecked {
            cell.leagueCheckBoxImgView.image = UIImage(named: "ic_chk_true")
        }else{
            cell.leagueCheckBoxImgView.image = UIImage(named: "ic_chk_false")
        }
        
        cell.leagueNameLabel.text = leaguesData[indexPath.row].leagueName
        cell.leagueId.text = leaguesData[indexPath.row].leaguesId
        
        let tap = leagueTapClass(target: self, action: #selector(leagueTap))
        tap.Cell = cell
        tap.idxPath = indexPath
        cell.addGestureRecognizer(tap)
        
        return cell
    }
    
    class leagueTapClass: UITapGestureRecognizer {
        var Cell: UITableViewCell?
        var idxPath: IndexPath?
    }
    
    @objc func leagueTap(sender: leagueTapClass){
//        let cell = leagueTableView.indexPath(for: sender.Cell!) as! LeagueTableViewCell
        leaguesData[sender.idxPath!.row].isChecked = !leaguesData[sender.idxPath!.row].isChecked
        leagueTableView.reloadRows(at: [sender.idxPath!], with: .automatic)
    }
}

extension LeagueView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LeagueTableViewCell
        
        if leaguesData[indexPath.row].isChecked {
            cell.leagueCheckBoxImgView.image = UIImage(named: "ic_chk_true")
        }else{
            cell.leagueCheckBoxImgView.image = UIImage(named: "ic_chk_false")
        }
    
        leaguesData[indexPath.row].isChecked = !leaguesData[indexPath.row].isChecked
    }
}
