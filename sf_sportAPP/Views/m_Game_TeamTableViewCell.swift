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
        
        var home_conCell: Array<UILabel> = Array()
        var home_oddsCell: Array<UILabel> = Array()
        
        var away_conCell: Array<UILabel> = Array()
        var away_oddsCell: Array<UILabel> = Array()
        
        home_conCell.append(cell.h_con_0)
        home_conCell.append(cell.h_con_1)
        home_conCell.append(cell.h_con_2)
        home_conCell.append(cell.h_con_3)
        
        home_oddsCell.append(cell.h_odds_0)
        home_oddsCell.append(cell.h_odds_1)
        home_oddsCell.append(cell.h_odds_2)
        home_oddsCell.append(cell.h_odds_3)
        
        away_conCell.append(cell.a_con_0)
        away_conCell.append(cell.a_con_1)
        away_conCell.append(cell.a_con_2)
        away_conCell.append(cell.a_con_3)
        
        away_oddsCell.append(cell.a_odds_0)
        away_oddsCell.append(cell.a_odds_1)
        away_oddsCell.append(cell.a_odds_2)
        away_oddsCell.append(cell.a_odds_3)
//        print("home bet",betData[indexPath.row].homeBet)
//        print("away bet",betData[indexPath.row].awayBet)
//        print("home con",betData[indexPath.row].homeCon)
//        print("away con",betData[indexPath.row].awayBet)
//
        var idx = 0
        for con in betData[indexPath.row].homeCon {
            home_conCell[idx].text = con.isEmpty ? "" : con
            idx += 1
        }
        
        idx = 0
        
        for odds in betData[indexPath.row].homeBet {
            home_oddsCell[idx].text = odds.isEmpty ? "" : odds
            idx += 1
        }
        
        idx = 0
        
        for con in betData[indexPath.row].awayCon {
            away_conCell[idx].text = con.isEmpty ? "" : con
            idx += 1
        }
        
        idx = 0
        
        for odds in betData[indexPath.row].awayBet {
            away_oddsCell[idx].text = odds.isEmpty ? "" : odds
            idx += 1
        }
        
        
        return cell
    }
    
    
}
extension m_Game_TeamTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
}
