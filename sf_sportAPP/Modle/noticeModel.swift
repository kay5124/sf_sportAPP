//
//  noticeModel.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/6/3.
//  Copyright © 2019 Ray  . All rights reserved.
//

import Foundation

struct noticeModel: Codable {
    let noticeType: String
    let noticeDate: String
    let noticeContent: String
    var isExpan: Bool
}
