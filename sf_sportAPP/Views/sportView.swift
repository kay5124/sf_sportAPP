//
//  sportView.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/22.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class sportView: UIView {
    @IBOutlet weak var sportTableView: UITableView!
    
    override func awakeFromNib() {
        sportTableView.dataSource = self
        sportTableView.delegate = self
        let nib = UINib(nibName: "sportTableViewCell", bundle: nil)
        sportTableView.register(nib, forCellReuseIdentifier: "sportCell")
    }
    
    public static func create() -> sportView {
        let selfView = Bundle.main.loadNibNamed("sportView", owner: self, options: nil)?.first as! sportView
        return selfView
    }
    
    @objc func sport_onClick(_ sender: MyTapGuesture){
        _GLobalService.nowSport = sender.selectSport
        HomeViewController.removeCustomView()
    }
    
    class MyTapGuesture: UITapGestureRecognizer {
        var selectSport: String = ""
    }
    
}

extension sportView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _GLobalService.sportItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath) as! sportTableViewCell
        
        let Item = _GLobalService.sportItems.filter{$0.key.contains(String(indexPath.row))}
        
        cell.sportIconImgView.image = UIImage(named: Item.first?.value ?? "")
        cell.sportNameLabel.text = Item.first?.key.replacingOccurrences(of: String(indexPath.row) + "_", with: "")
        
        cell.liveLabel.isHidden = false
        cell.sportGameCountLabel.text = String(indexPath.row)
        
        let cellTap = MyTapGuesture(target: self, action: #selector(self.sport_onClick(_:)))
        cellTap.selectSport = cell.sportNameLabel.text ?? ""
        cell.addGestureRecognizer(cellTap)
        
        return cell
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

extension sportView: UITableViewDelegate {
    // Set the spacing between sections
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 5
//    }
}
