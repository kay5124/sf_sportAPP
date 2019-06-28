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
import SwiftyJSON
import Alamofire

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
    
    @IBOutlet weak var gameContainerView: UIView!
    
    public var lineGameData: Array<gameModel> = Array()
    public var liveGameData: Array<gameModel> = Array()
    public var crossGameData: Array<gameModel> = Array()
    
    public var totalGameData : Dictionary<String,Dictionary<String,Array<gameModel>>>?
    
    public let vc_mainGame = mainGameView.create()
    
    private var gameType: String = "line"
    
    private var nowShowController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InitView()
    }
    
    public func InitView(){
        nowShowController = self
        /* 初始化每個球種比賽資料 */
        totalGameData = Dictionary<String,Dictionary<String,Array<gameModel>>>()
        for sportType in _GLobalService.sportItems{
            let sport = sportType.key.components(separatedBy: "_")[1]
            
            let emptyData:[String : Array<gameModel>]  = [
                "line":Array(),
                "live":Array(),
                "cross":Array()
            ]
            
            totalGameData![sport] = emptyData
        }
        
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
        _GLobalService.nowSport = "足球"
        
        //取得比賽
        GetGames()
        //取得聯盟
        GetLeagues()
        
        vc_mainGame.frame = CGRect(x: 0, y: 0, width: gameContainerView.frame.width, height: gameContainerView.frame.height)
        gameContainerView.addSubview(vc_mainGame)
    }
    
    private func GetGames(){
//        _GLobalService.loadingView.show(on: view)
        
        let betH_0 = ["0.88","0.88","0.88","0.88"]
        let betC_0 = ["0.12","0.12","0.12","0.12"]
        
        let conH_0 = ["1+10","1+10","1+10","1+10"]
        let conC_0 = ["2+10","2+10","2+10","2+10"]
        
        let dataD_0 = gameDataDetailModel(homeBet: betH_0, awayBet: betC_0, homeCon: conH_0, awayCon: conC_0)
        
        let data_0 = gameDataModel(gameDate: "2019/06/05 09:00:00", homeTeamId: "123", homeTeam: "Test", awayTeam: "Test_2", awayTeamId: "456", gameDetail: [dataD_0])
//        let data_1 = gameDataModel(gameDate: "05/18\n17/10", homeTeam: "XX", awayTeam: "AA", gameDetail: [dataD_0,dataD_0])
//        let data_2 = gameDataModel(gameDate: "01/18\n10/10", homeTeam: "BB", awayTeam: "CC", gameDetail: [dataD_0,dataD_0,dataD_0])
        
        lineGameData.append(gameModel(gameid: "123", leagueName: "test", leaId: "123456", isExpan: false, gameData: [data_0]))
//        lineGameData.append(gameModel(leagueName: "MLB 國際職棒-國聯1", isExpan: false, gameData: [data_0,data_1,data_2]))
//        liveGameData.append(gameModel(leagueName: "MLB 國際職棒-國聯2", isExpan: false, gameData: [data_0,data_1,data_2]))
//        liveGameData.append(gameModel(leagueName: "MLB 國際職棒-國聯3", isExpan: false, gameData: [data_0,data_1,data_2]))
//        crossGameData.append(gameModel(leagueName: "MLB 國際職棒-國聯4", isExpan: false, gameData: [data_0,data_1,data_2]))
        
        totalGameData!["棒球"]!["line"] = lineGameData
//        totalGameData!["棒球"]!["live"] = liveGameData
//        totalGameData!["棒球"]!["cross"] = crossGameData
        
        vc_mainGame.gameData = totalGameData!["足球"]!["line"]!
        
//        let parameters = ["_token" : _GLobalService.apiToken, "sport" : _GLobalService.nowSport]
//        Alamofire.request(_GLobalService.apiAddress + "getGames", method: .post, parameters: parameters).validate().responseJSON{ (response) in
//            switch response.result {
//            case .success(_):
////                _GLobalService.loadingView.hide()
//                let json = try? JSON(data: response.data!)
//                for item in json!["gameData"].array! {
//
//                }
//            case .failure(_):
//                _GLobalService.loadingView.hide()
//                _GLobalService.nowViewController?.showAlertDialog("錯誤", "請檢查網路連線")
//            }
//        }
    }
    
    private func GetLeagues(){
        _GLobalService.loadingView.show(on: view)
        _GLobalService.leaguesData.removeAll()
        let parameters = ["_token" : _GLobalService.apiToken, "sport" : _GLobalService.nowSport]
        
        Alamofire.request(_GLobalService.apiAddress + "getLeagues", method: .post, parameters: parameters).validate().responseJSON{ (response) in
            switch response.result {
            case .success(_):
                _GLobalService.loadingView.hide()
                let json = try? JSON(data: response.data!)
                for item in json!["leaguesData"].array! {
                    let leaId: String = item["leaId"].rawValue as? String ?? String(item["leaId"].int!) ?? item["leaId"].string ?? ""
                    _GLobalService.leaguesData.append(leagueModel(leaguesId: leaId, leagueName: item["name"].string!, isChecked: false))
                }
            case .failure(_):
                _GLobalService.loadingView.hide()
                _GLobalService.nowViewController?.showAlertDialog("錯誤", "請檢查網路連線")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        if touch.view == maskView {
            HomeViewController.removeCustomView()
        }
    }
    
    @objc func refreshStack_onClick(){
        HomeViewController.removeCustomView()
    }
    
    @objc func betRecordStackView_onClick(){
        HomeViewController.removeCustomView()
    }
    
    @objc func sportStackView_onClick(){
        
        let SportView = sportView.create()
        SportView.frame = CGRect(x: 0, y: 0, width: customView.frame.width, height: customView.frame.height)
        
        customView.DirectView(selfView: customView, directView: SportView, time: 0, transitionMode: .init())
        
        nowCusView = "sport"
        customView.isHidden = false
        maskView.isHidden = false
    }
    
    public static func removeCustomView(){
        let vc_home = _GLobalService.nowViewController as! HomeViewController
        
        if vc_home.nowCusView == "sport" {
            vc_home.GetLeagues()
            
            let Item = _GLobalService.sportItems.filter{$0.key.contains(_GLobalService.nowSport)}
            let sport = Item.first?.key.components(separatedBy: "_")[1] ?? "足球"
            
            vc_home.sportImgView.image = UIImage(named: Item.first?.value ?? "ic_sc")
            vc_home.sportNameLabel.text = sport
            
            vc_home.vc_mainGame.gameData = vc_home.totalGameData?[_GLobalService.nowSport]?[vc_home.gameType]! ?? Array()
            vc_home.vc_mainGame.mainGameTableView.reloadData()
        }
        
        vc_home.customView.isHidden = true
        vc_home.maskView.isHidden = true
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
        
        let leagueView = customView.subviews.first as! LeagueView
        _GLobalService.leaguesData = leagueView.leaguesData
//        _GLobalService.LeagueSelectList = _GLobalService.tempLeagueSelectList
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
        
        switch sender.title(for: .normal) {
        case "單式":
            gameType = "line"
            break
        case "滾球":
            gameType = "live"
            break
        case "過關":
            gameType = "cross"
            break
        default:
            break
        }
        
        let sport = _GLobalService.nowSport.isEmpty ? "足球" : _GLobalService.nowSport
        
        vc_mainGame.gameData = totalGameData![sport]![gameType]!
        vc_mainGame.mainGameTableView.reloadData()
    }
    
    public func showBetDeatilView(sender: oddsTap){
        let vc_dialog = storyboard?.instantiateViewController(withIdentifier: "vc_Dialog") as! CustomDialogViewController
        self.present(vc_dialog, animated: true, completion: nil)
        nowShowController = vc_dialog
        
        vc_dialog.CusTomViewTop.constant = 10
        vc_dialog.CusTomViewBottom.constant = 10
        
        let confirmBetView = ConfirmBetView.create()
        confirmBetView.frame = CGRect(x: 0, y: 0, width: vc_dialog.CusView.frame.width, height: vc_dialog.CusView.frame.height)
        vc_dialog.CusView.addSubview(confirmBetView)
        
        confirmBetView.con.text = sender.con!
        confirmBetView.odds.text = sender.odds!
        confirmBetView.homeTeam.text = sender.h_team!
        confirmBetView.awayTeam.text = sender.a_team!
    }
    
    public func closeConfirmBetView(){
        (nowShowController as! CustomDialogViewController).dismiss(animated: true, completion: nil)
        nowShowController = self
    }
    
}
