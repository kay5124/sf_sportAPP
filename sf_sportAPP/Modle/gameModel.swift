//
//  gameModel.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/6/4.
//  Copyright © 2019 Ray  . All rights reserved.
//

import Foundation
import UIKit

struct gameModel: Codable {
    let gameid: String
    let leagueName: String
    let leaId: String
    var isExpan: Bool
    let gameData: Array<gameDataModel>
}

struct gameDataModel: Codable {
    let gameDate: String
    let homeTeamId: String
    let homeTeam: String
    let awayTeam: String
    let awayTeamId: String
    let isHeader: Bool = true
    let gameDetail: Array<gameDataDetailModel>
}

struct gameDataDetailModel: Codable {
    let homeBet: Array<String>
    let awayBet: Array<String>
    let homeCon: Array<String>
    let awayCon: Array<String>
}

public class oddsTap: UITapGestureRecognizer{
    var gameid: String?
    var playCode: String?
    var type: String?
    var leaId: String?
    var teamId: String?
    var con: String?
    var odds: String?
    var sport: String?
    var h_team: String?
    var a_team: String?
}
