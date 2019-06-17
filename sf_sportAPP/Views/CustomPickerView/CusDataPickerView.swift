//
//  CusDataPickerView.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/29.
//  Copyright © 2019 Ray  . All rights reserved.
//

import UIKit

class CusDataPickerView: UIView {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var dataPicker: UIPickerView!
    override func awakeFromNib() {
        
    }
    
    public static func create() -> CusDataPickerView {
        let selfView = Bundle.main.loadNibNamed("CusDataPickerView", owner: self, options: nil)?.first as! CusDataPickerView
        return selfView
    }
}
