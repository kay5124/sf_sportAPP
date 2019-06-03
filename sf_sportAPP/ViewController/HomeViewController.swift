//
//  HomeViewController.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/20.
//  Copyright © 2019 Ray  . All rights reserved.
//

import Foundation
import UIKit
import SideMenu

class HomeViewController: UIViewController {
    var nowCusView: String = ""
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerStackView: UIStackView!
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!

    @IBOutlet weak var refreshStackView: UIStackView!
    @IBOutlet weak var sportStackView: UIStackView!
    @IBOutlet weak var leagueStackView: UIStackView!
    @IBOutlet weak var betRecordStackView: UIStackView!
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var sportImgView: UIImageView!
    @IBOutlet weak var sportNameLabel: UILabel!
    
    @IBOutlet weak var gameLineBtn: UIButton!
    @IBOutlet weak var gameLiveBtn: UIButton!
    @IBOutlet weak var gameCrossBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        InitView()
    }
    
    public func InitView(){
        var maskHeight: CGFloat = self.view.frame.height - (footerStackView.frame.height + 10)
        
        if _GLobalService.thisPhoneModel.contains("X") {
            maskHeight -= 34
        }
        maskView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: maskHeight)
        
        let refreshTap = UITapGestureRecognizer(target: self, action: #selector(self.refreshStack_onClick))
        refreshStackView.addGestureRecognizer(refreshTap)
        
        let betRecordTap = UITapGestureRecognizer(target: self, action: #selector(self.betRecordStackView_onClick))
        betRecordStackView.addGestureRecognizer(betRecordTap)
        
        let sportTap = UITapGestureRecognizer(target: self, action: #selector(self.sportStackView_onClick))
        sportStackView.addGestureRecognizer(sportTap)
        
        let leagueTap = UITapGestureRecognizer(target: self, action: #selector(self.LeagueStackView_onClick))
        leagueStackView.addGestureRecognizer(leagueTap)
        
        gameLineBtn.layer.cornerRadius = 10
        gameLiveBtn.layer.cornerRadius = 10
        gameCrossBtn.layer.cornerRadius = 10
        
        gameLineBtn.layer.borderColor = UIColor.white.cgColor
        gameLineBtn.layer.borderWidth = 0.5
        gameLiveBtn.layer.borderColor = UIColor.white.cgColor
        gameLiveBtn.layer.borderWidth = 0.5
        gameCrossBtn.layer.borderColor = UIColor.white.cgColor
        gameCrossBtn.layer.borderWidth = 0.5
        
        gameLineBtn.backgroundColor = .white
        gameLineBtn.setTitleColor(.black, for: .normal)
        
        gameLineBtn.addTarget(self, action: #selector(gameType_onClick(_:)), for: .touchUpInside)
        gameLiveBtn.addTarget(self, action: #selector(gameType_onClick(_:)), for: .touchUpInside)
        gameCrossBtn.addTarget(self, action: #selector(gameType_onClick(_:)), for: .touchUpInside)
        
        _GLobalService.LeagueSelectList.removeAll()
        _GLobalService.tempLeagueSelectList.removeAll()
        _GLobalService.nowSport = ""
        
        //league data
        for i in 1 ... 10 {
            _GLobalService.LeagueList.append("聯盟測試\(i)號")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        if touch.view == maskView {
            customViewService.customViewWillRemove()
        }
    }
    
    @objc func refreshStack_onClick(){
        customViewService.customViewWillRemove()
    }
    
    @objc func betRecordStackView_onClick(){
        customViewService.customViewWillRemove()
    }
    
    @objc func sportStackView_onClick(){
        
        let SportView = sportView.create()
        SportView.frame = CGRect(x: 0, y: 0, width: customView.frame.width, height: customView.frame.height)
        
        customView.DirectView(selfView: customView, directView: SportView, time: 0, transitionMode: .init())
        
        nowCusView = "sport"
        customView.isHidden = false
        maskView.isHidden = false
    }
    
    @objc func LeagueStackView_onClick(){
        
        let leagueView = LeagueView.create()
        leagueView.frame = CGRect(x: 0, y: 0, width: customView.frame.width, height: customView.frame.height)
        
        customView.DirectView(selfView: customView, directView: leagueView, time: 0, transitionMode: .init())
        
        leagueView.cancelBtn.addTarget(self, action: #selector(leagueCancel_onClick), for: .touchUpInside)
        leagueView.confirmBtn.addTarget(self, action: #selector(leagueConfirm_onClick), for: .touchUpInside)
        
        nowCusView = "league"
        customView.isHidden = false
        maskView.isHidden = false
    }
    
    @objc func leagueCancel_onClick(){
        customView.isHidden = true
        maskView.isHidden = true
    }
    
    @objc func leagueConfirm_onClick(){
        customView.isHidden = true
        maskView.isHidden = true
        
        _GLobalService.LeagueSelectList = _GLobalService.tempLeagueSelectList
    }
    
    @IBAction func menuBtn_onClick(_ sender: Any) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    @objc func gameType_onClick(_ sender: UIButton){
        
        gameLineBtn.backgroundColor = UIColor(displayP3Red: 135, green: 212, blue: 255, alpha: 0)
        gameLineBtn.setTitleColor(.white, for: .normal)
        gameLiveBtn.backgroundColor = UIColor(displayP3Red: 135, green: 212, blue: 255, alpha: 0)
        gameLiveBtn.setTitleColor(.white, for: .normal)
        gameCrossBtn.backgroundColor = UIColor(displayP3Red: 135, green: 212, blue: 255, alpha: 0)
        gameCrossBtn.setTitleColor(.white, for: .normal)
        
        let btn = sender
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
    }
    
}

class customViewService {
    public static func customViewWillRemove(){
        
        let vc_home = _GLobalService.nowViewController as! HomeViewController
        
        if vc_home.nowCusView == "sport" {
            let Item = _GLobalService.sportItems.filter{$0.key.contains(_GLobalService.nowSport)}
            
            vc_home.sportImgView.image = UIImage(named: Item.first?.value ?? "ic_sc")
            vc_home.sportNameLabel.text = Item.first?.key.components(separatedBy: "_")[1] ?? "足球"
        }
    
        vc_home.customView.isHidden = true
        vc_home.maskView.isHidden = true
    }
}
