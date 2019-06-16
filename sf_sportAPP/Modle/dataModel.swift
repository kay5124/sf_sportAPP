//
//  dataModel.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/6/13.
//  Copyright © 2019 Ray  . All rights reserved.
//

import Foundation

struct leagueModel: Codable {
    public let leaguesId: String
    public let leagueName: String
    public var isChecked: Bool
}
