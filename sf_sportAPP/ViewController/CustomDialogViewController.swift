//
//  CustomDialogViewController.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/21.
//  Copyright © 2019 Ray  . All rights reserved.
//

import Foundation
import UIKit

class CustomDialogViewController: UIViewController {
    
    @IBOutlet weak var CusView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let page = UIView(frame: self.view.bounds.offsetBy(dx: 2, dy: 2))
//        page.backgroundColor = .blue
        
        CusView.corner(byRoundingCorners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radii: 10)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        if touch.view == view {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}
