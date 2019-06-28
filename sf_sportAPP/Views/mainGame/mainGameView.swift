//
//  mainGameView.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/6/3.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class mainGameView: UIView {

    @IBOutlet weak var mainGameTableView: UITableView!
    
    public var gameData: Array<gameModel> = Array()
    
    override func awakeFromNib() {
        InitViews()
    }
    
    private func InitViews()
    {
//        mainGameTableView.allowsSelection = false
        mainGameTableView.delaysContentTouches = false
        mainGameTableView.separatorInset = .zero
        mainGameTableView.separatorStyle = .singleLine
        mainGameTableView.separatorColor = UIColor.black
//        mainGameTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mainGameTableView.tableFooterView = UIView()
        mainGameTableView.delegate = self
        mainGameTableView.dataSource = self
        let mainGmaeNib = UINib(nibName: "mainGameTableViewCell", bundle: nil)
        mainGameTableView.register(mainGmaeNib, forCellReuseIdentifier: "mainGameCell")
        mainGameTableView.allowsSelection = false
    }
    
    public static func create() -> mainGameView {
        let selfView = Bundle.main.loadNibNamed("mainGameView", owner: self, options: nil)?.first as! mainGameView
        return selfView
    }

}

extension mainGameView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainGameCell") as! mainGameTableViewCell
        
        cell.leagueName.text = gameData[indexPath.row].leagueName
        //如果未展開就
        if !gameData[indexPath.row].isExpan {
            cell.expanLabel.text = "▼"
        }else{
            cell.expanLabel.text = "▲"
            cell.teamArray = gameData[indexPath.row].gameData
            cell.leaId = gameData[indexPath.row].leaId
            cell.teamTableView.reloadData()
            
            mainGameTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            
            cell.scrollToTop()
        }
        
        let myTap = cellTap(target: self, action: #selector(cell_onTap(sender:)))
        myTap.idx = indexPath.row
        myTap.idxPath = indexPath
        cell.leagueView.addGestureRecognizer(myTap)
        
        return cell
    }
    
    class cellTap: UITapGestureRecognizer {
        var idx : Int = -1
        var idxPath: IndexPath?
    }
    
    @objc func cell_onTap(sender: cellTap){
        let index = sender.idx
        
        for item in mainGameTableView.visibleCells {
            let cell = item as! mainGameTableViewCell
            let idx = mainGameTableView.indexPath(for: cell)
            if gameData[idx!.row].isExpan && sender.idxPath!.row != idx!.row {
                gameData[idx!.row].isExpan = !gameData[idx!.row].isExpan
                mainGameTableView.reloadRows(at: [idx!], with: .automatic)
            }
        }
        
        gameData[index].isExpan = !gameData[index].isExpan
        mainGameTableView.reloadRows(at: [sender.idxPath!], with: .automatic)
    }
}

extension mainGameView: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        for item in mainGameTableView.visibleCells {
//            let cell = item as! mainGameTableViewCell
//            let idx = mainGameTableView.indexPath(for: cell)
//            if gameData[idx!.row].isExpan && indexPath.row != idx!.row {
//                gameData[idx!.row].isExpan = !gameData[idx!.row].isExpan
//                mainGameTableView.reloadRows(at: [idx!], with: .automatic)
//            }
//        }
//
//        gameData[indexPath.row].isExpan = !gameData[indexPath.row].isExpan
//        mainGameTableView.reloadRows(at: [indexPath], with: .automatic)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if gameData[indexPath.row].isExpan {
            return self.frame.height
        }
        return UITableView.automaticDimension
    }
}
