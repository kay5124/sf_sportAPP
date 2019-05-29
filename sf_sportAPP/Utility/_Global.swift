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
    
    public static let noticeTypeItems = [
        "所有",
        "公告",
        "其他",
        "棒球",
        "足球",
        "籃球",
        "冰球",
        "美足"
    ]
    
    public static var LeagueList: Array<String> = []
    public static var tempLeagueSelectList: Array<String> = []
    public static var LeagueSelectList: Array<String> = []
    
    public static var myMainVC: UIViewController?
    public static var sideMenuLeftViewController: UISideMenuNavigationController?
    public static var sideMenuVC: UIViewController?
    public static var nowViewController: UIViewController?
    
    public static var menuClickIdx = -1
    public static var nowSport = "足球"
    
    public static var userName = ""
    public static var userMoney = "100000"
}

class HandicapInstructionService {
    
    public static let handicapData = [
        "PK_0_表示互不相讓，贏1分全贏。",
        "0-50_0/0.5_表示讓分隊伍跟受讓隊伍平手時，\n押讓分隊伍輸50%。",
        "0輸_0.5_表示讓分隊伍贏受讓隊伍1分時，\n押讓分隊伍全輸。",
        "1+50_0.5/1_表示讓分隊伍贏受讓隊伍1分時，\n押讓分隊伍贏50%，2分全贏。",
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
    
    public static let handicapSampleData = [
        "A 3：2 B_1 + 35_下注A_下注B_贏35%\n可贏金額=1,000*35%*0.90=$315_輸35%\n輸付金額=-1,000*35%=$-350",
        "A 3：2 B_1 - 65_下注A_下注B_輸65%\n輸付金額=-1,000*65%=$-650_贏65%\n可贏金額=1,000*65%*0.90=$585",
        "3：5_8 + 25_下注大分_下注小分_贏25%\n可贏金額=1,000*25%*0.90=$225_輸25%\n輸付金額=-1,000*25%=$-250",
        "7：3_10 - 75_下注大分_下注小分_輸75%\n輸付金額=-1,000*75%=$-750_贏75%\n可贏金額=1,000*75%*0.90=$675"
    ]
    
}

extension NSMutableAttributedString {
    
    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}
