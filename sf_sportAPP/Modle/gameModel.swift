//
//  gameModel.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/6/4.
//  Copyright © 2019 Ray  . All rights reserved.
//

import Foundation

struct gameModel: Codable {
    let leagueName: String
    var isExpan: Bool
    let gameData: Array<gameDataModel>
}

struct gameDataModel: Codable {
    let gameDate: String
    let homeTeam: String
    let awayTeam: String
    let isHeader: Bool = true
    let gameDetail: Array<gameDataDetailModel>
}

struct gameDataDetailModel: Codable {
    let isHeader: Bool = false
    let homeBet: Array<String>
    let awayBet: Array<String>
    let homeCon: Array<String>
    let awayCon: Array<String>
}
