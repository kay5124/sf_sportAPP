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

class HandicapInstructionService {
    
    public static let handicapData = [
        "PK_0_表示互不相讓，贏1分全贏。",
        "0-50_0/0.5_表示互不相讓，贏1分全贏。",
        "0輸_0.5_表示讓分隊伍跟受讓隊伍平手時，\n押讓分隊伍輸50%。",
        "1+50_0.5/1_表示讓分隊伍贏受讓隊伍1分時，\n押讓分隊伍全輸。",
        "1平_1_表示讓分隊伍贏受讓隊伍1分時，\n兩隊平手，2分全贏。",
        "1-50_1/1.5_表示讓分隊伍贏受讓隊伍1分時，\n押讓分隊伍輸50%，2分全贏。",
        "1輸_1.5_表示讓分隊伍贏受讓隊伍1分時，\n押讓分隊伍全輸，2分全贏。",
        "2+50_1.5/2_表示讓分隊伍贏受讓隊伍2分時，\n押讓分隊伍贏50%，3分全贏",
        "2平_2_表示讓分隊伍贏受讓隊伍2分時，\n兩隊平手，3分全贏。",
        "2-50_2/2.5_表示讓分隊伍贏受讓隊伍2分時，\n押讓分隊伍輸50%，3分全贏。",
        "2輸_2.5_表示讓分隊伍贏受讓隊伍2分時，\n押讓分隊伍全輸，3分全贏。",
        "3+50_2.5/3_表示讓分隊伍贏受讓隊伍3分時，\n押讓分隊伍贏50%，4分全贏",
        "3平_3_表示讓分隊伍贏受讓隊伍3分時，\n兩隊平手，4分全贏。",
    ]
    
}

extension NSMutableAttributedString {
    
    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}
