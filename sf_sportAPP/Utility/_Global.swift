import UIKit
import Foundation
import SideMenu

class _GLobalService {
    public static let thisPhoneModel = UIDevice.modelName
    
    public static let sideMenuItems = ["0_遊戲主頁":"ic_home",
                                       "1_投注記錄":"ic_record",
                                       "2_過關計算器":"ic_calculating",
                                       "3_盤口說明":"ic_help",
                                       "4_現場轉播":"ic_live",
                                       "5_即時比分":"ic_score",
                                       "6_比賽結果":"ic_court",
                                       "7_公告":"ic_notice",
                                       "8_線路切換":"ic_line",
                                       "9_登出":"ic_exit"]
    
    public static let sportItems = ["0_棒球":"ic_bb",
                                    "1_足球":"ic_sc",
                                    "2_籃球":"ic_bk",
                                    "3_冰球":"ic_ih",
                                    "4_美足":"ic_af"]
    
    public static var LeagueList: Array<String> = []
    public static var tempLeagueSelectList: Array<String> = []
    public static var LeagueSelectList: Array<String> = []
    
    public static var myMainVC: UIViewController?
    public static var sideMenuLeftViewController: UISideMenuNavigationController?
    public static var nowViewController: UIViewController?
    
    public static var menuClickIdx = -1
    public static var nowSport = "足球"
    
    public static var userName = ""
    public static var userMoney = "100000"
}

class _menuItems {
    let itemName: String
    let Image: String
    
    init(itemName: String,Image: String){
        self.itemName = itemName
        self.Image = Image
    }
}
