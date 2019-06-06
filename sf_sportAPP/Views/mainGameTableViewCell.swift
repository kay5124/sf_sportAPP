//
//  MenuTableViewCell.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/20.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class mainGameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var expanLabel: UILabel!
    @IBOutlet weak var teamTableView: UITableView!
    
    public var teamArray: Array<gameDataModel> = Array()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        teamTableView.delegate = self
        teamTableView.dataSource = self
        let nib = UINib(nibName: "m_Game_TeamTableViewCell", bundle: nil)
        teamTableView.register(nib, forCellReuseIdentifier: "teamCell")
        
        teamTableView.separatorStyle = .none
        teamTableView.separatorInset = .zero
        teamTableView.tableFooterView = UIView()
        teamTableView.allowsSelection = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    public func scrollToTop(){
        let indexPath = IndexPath(row: 0, section: 0)
        teamTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
}

extension mainGameTableViewCell: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! m_Game_TeamTableViewCell
        
        cell.gameDate.text = teamArray[indexPath.row].gameDate
        cell.teamH.text = teamArray[indexPath.row].homeTeam
        cell.teamA.text = teamArray[indexPath.row].awayTeam
        cell.moreBet.layer.cornerRadius = 15
        cell.moreBet.layer.borderWidth = 0.5
        cell.moreBet.layer.borderColor = UIColor.blue.cgColor
        
        cell.betData = teamArray[indexPath.row].gameDetail
        cell.betTableView.reloadData()
        
        return cell
    }
    
}

extension mainGameTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let detailCnt: Int = teamArray[indexPath.row].gameDetail.count
        var rowHeight: Int = 123
        
        if detailCnt != 1 {
            rowHeight = 103
        }
        
        print("detail Cnt:",detailCnt)
        let CellRowHeight: CGFloat = CGFloat(detailCnt * rowHeight)
        
        print("cell Height :",CellRowHeight)
        
        return CellRowHeight
    }
}
