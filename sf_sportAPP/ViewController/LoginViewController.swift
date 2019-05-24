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

class LoginViewController: UIViewController {
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userNameTxa: UITextField!
    @IBOutlet weak var userPwdTxa: UITextField!
    private var nowViewController: UIViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        enableSideMenu(false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        enableSideMenu(true)
    }
    
    @IBAction func loginBtn_onClick(_ sender: Any) {
        
        let userName: String = userNameTxa.text ?? ""
        _GLobalService.userName = userName
        (parent as! MainViewController).goHome()
        
    }
    
}
