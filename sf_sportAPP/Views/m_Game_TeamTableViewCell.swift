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
