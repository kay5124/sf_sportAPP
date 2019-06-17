//
//  m_Game_TeamTableViewCell.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/6/6.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class m_Game_TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var gameDate: UILabel!
    @IBOutlet weak var teamH: UILabel!
    @IBOutlet weak var teamA: UILabel!
    @IBOutlet weak var moreBet: UILabel!
    @IBOutlet weak var betTableView: UITableView!
    
    public var betData: Array<gameDataDetailModel> = Array()
    
    public var gameid: String?
    public var playCode: String?
    public var leaId: String?
    public var h_teamId: String?
    public var a_teamId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        betTableView.delegate = self
        betTableView.dataSource = self
        betTableView.tableFooterView = UIView()
        betTableView.separatorInset = .zero
        betTableView.separatorColor = UIColor.lightGray
        betTableView.separatorStyle = .singleLine
        let nib = UINib(nibName: "m_Game_BetTableViewCell", bundle: nil)
        betTableView.register(nib, forCellReuseIdentifier: "betCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension m_Game_TeamTableViewCell: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return betData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "betCell", for: indexPath) as! m_Game_BetTableViewCell
        
        var h_bet_view: Array<UIView> = Array()
        var a_bet_view: Array<UIView> = Array()
        
        h_bet_view.append(cell.h_bet_0)
        h_bet_view.append(cell.h_bet_1)
        h_bet_view.append(cell.h_bet_2)
        h_bet_view.append(cell.h_bet_3)

        a_bet_view.append(cell.a_bet_0)
        a_bet_view.append(cell.a_bet_1)
        a_bet_view.append(cell.a_bet_2)
        a_bet_view.append(cell.a_bet_3)
        
        var idx: Int = 0
        for views in h_bet_view {
            let h_con = views.subviews[0] as! UILabel
            let h_odds = views.subviews[1] as! UILabel
            
            h_con.text = betData[indexPath.row].homeCon[idx]
            h_odds.text = betData[indexPath.row].homeBet[idx]
            
            let tap = oddsTap(target: self, action: #selector(odds_onClick(sender:)))
            tap.gameid = gameid ?? ""
            tap.leaId = leaId ?? ""
            tap.playCode = playCode ?? ""
            tap.sport = _GLobalService.nowSport
            tap.teamId = h_teamId ?? ""
            tap.type = "H"
            tap.con = betData[indexPath.row].homeCon[idx]
            tap.odds = betData[indexPath.row].homeBet[idx]
            tap.h_team = teamH.text!
            tap.a_team = teamA.text!
            views.addGestureRecognizer(tap)
            
            idx += 1
        }
        
        idx = 0
        
        for views in a_bet_view {
            let a_con = views.subviews[0] as! UILabel
            let a_odds = views.subviews[1] as! UILabel
            
            a_con.text = betData[indexPath.row].awayCon[idx]
            a_odds.text = betData[indexPath.row].awayBet[idx]
            
            let tap = oddsTap(target: self, action: #selector(odds_onClick(sender:)))
            tap.gameid = gameid ?? ""
            tap.leaId = leaId ?? ""
            tap.playCode = playCode ?? ""
            tap.sport = _GLobalService.nowSport
            tap.teamId = h_teamId ?? ""
            tap.type = "C"
            tap.con = betData[indexPath.row].awayCon[idx]
            tap.odds = betData[indexPath.row].awayBet[idx]
            tap.h_team = teamH.text!
            tap.a_team = teamA.text!
            views.addGestureRecognizer(tap)
            
            idx += 1
        }
        
        return cell
    }
    
    @objc func odds_onClick(sender: oddsTap){
        (_GLobalService.nowViewController as! HomeViewController).showBetDeatilView(sender: sender)
    }
}
extension m_Game_TeamTableViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
}
