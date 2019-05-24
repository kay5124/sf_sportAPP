//
//  HomeViewController.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/20.
//  Copyright © 2019 Ray  . All rights reserved.
//

import Foundation
import UIKit

class SideMenuViewController: UIViewController {
    public static var nowVC: SideMenuViewController?
    @IBOutlet weak var userHeadIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userMoney: UILabel!
    @IBOutlet weak var MenuItems: UITableView!
    public static var clickItem: String = ""
    
    override func viewDidLoad() {
        
        MenuItems.dataSource = self
        MenuItems.rowHeight = 60
        let nib = UINib(nibName: "MenuTableViewCell", bundle: nil)
        MenuItems.register(nib, forCellReuseIdentifier: "MenuTableViewCell")
        
        //hide tool bar
        navigationController?.setNavigationBarHidden(true, animated: false)
        //去除多餘的行數
        MenuItems.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        _GLobalService.menuClickIdx = -1
        userName.text = _GLobalService.userName
        userMoney.text = _GLobalService.userMoney
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (_GLobalService.myMainVC as! MainViewController).SideMenuCloseEvent()
    }
    
}

extension SideMenuViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _GLobalService.sideMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        let Item = _GLobalService.sideMenuItems.filter{$0.key.contains(String(indexPath.row))}
        
        cell.menuItemTitle.text = Item.first?.key.components(separatedBy: "_")[1]
        cell.menuItemIcon.image = UIImage(named: Item.first!.value)
        
        let myTapGesture = MyTapGesture(target: self, action: #selector(self.MenuItem_onClick))
        myTapGesture.clickIndex = indexPath.row
        cell.addGestureRecognizer(myTapGesture)
        
        return cell
    }
    
    @objc func MenuItem_onClick(sender: MyTapGesture){
        let idx = sender.clickIndex
        _GLobalService.menuClickIdx = idx
        dismiss(animated: true, completion: nil)
    }
    
    class MyTapGesture: UITapGestureRecognizer{
        var clickIndex: Int = -1
    }
    
}
