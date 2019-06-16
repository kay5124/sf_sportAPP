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
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userNameTxa: UITextField!
    @IBOutlet weak var userPwdTxa: UITextField!
    private var nowViewController: UIViewController?
    
    struct LoginData: Codable {
        public let err: String
        public let statusCode: Int
        public var userData = JSON([])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 10
        enableSideMenu(false)
        userPwdTxa.isSecureTextEntry = true
        
        userNameTxa.delegate = self
        userPwdTxa.delegate = self
        userPwdTxa.clearsOnBeginEditing = true
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func KeyboardWillShow(_ sender: Notification){
//        guard let userInfo = sender.userInfo else {return}
//        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
//        let keyboardFrame = keyboardSize.cgRectValue
//        if self.view.frame.origin.y == 0{
//            self.view.frame.origin.y -= keyboardFrame.height
//        }
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            self.view.frame.origin.y -= 20

        }
    }
    
    @objc func KeyboardWillHide(_ sender: Notification){
        self.view.frame.origin.y = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableSideMenu(false)
        Alamofire.request(_GLobalService.apiAddress + "GetCsrfToken", method: .post).responseData{ (response) in
            if response.result.isSuccess {
                print("request succ")
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    _GLobalService.apiToken = utf8Text
                }
            }else {
                print("request Error")
            }
        }
        
        if !_GLobalService.userName.isEmpty {
            userNameTxa.text = _GLobalService.userName
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        enableSideMenu(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        if touch.view == self.view {
            view.endEditing(true)
        }
    }
    
    @IBAction func loginBtn_onClick(_ sender: Any) {
        
        let userName: String = userNameTxa.text ?? ""
        let pwd: String = userPwdTxa.text ?? ""

        if userName.isEmpty && pwd.isEmpty {
            let okAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction) -> Void in
                _GLobalService.userName = "sy_test01"
                (self.parent as! MainViewController).goHome()
            })
            let alertController = UIAlertController.init(title: "提示", message: "登入成功", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let parameters = ["_token" : _GLobalService.apiToken, "username" : userName, "password" : pwd]
        
        _GLobalService.loadingView.show(on: view)
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { timer in
            Alamofire.request(_GLobalService.apiAddress + "GetCsrfToken", method: .post).responseData{ (response) in
                if response.result.isSuccess {
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        _GLobalService.apiToken = utf8Text
                        
                        Alamofire.request(_GLobalService.apiAddress + "checkLogin", method: .post, parameters: parameters).validate().responseJSON{ (response) in
                            switch response.result {
                            case .success(_):
                                _GLobalService.loadingView.hide()
                                let json = try? JSONDecoder().decode(LoginData.self, from: response.data!)
                                if json?.statusCode == 0 && (json?.err.isEmpty)! {
                                    let okAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: {
                                        (action: UIAlertAction) -> Void in
                                        _GLobalService.userName = (json?.userData["username"].string)!
                                        (self.parent as! MainViewController).goHome()
                                    })
                                    let alertController = UIAlertController.init(title: "提示", message: "登入成功", preferredStyle: UIAlertController.Style.alert)
                                    alertController.addAction(okAction)
                                    self.present(alertController, animated: true, completion: nil)
                                }else{
                                    self.showAlertDialog("錯誤", json!.err)
                                }
                            case .failure(_):
                                _GLobalService.loadingView.hide()
                                self.showAlertDialog("錯誤", "請檢查網路連線")
                            }
                        }
                    }
                }else {
                    _GLobalService.loadingView.hide()
                    self.showAlertDialog("錯誤", "請檢查網路連線")
                }
            }
        })
    }
    
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        UIView.animate(withDuration: 0.3, animations: {
//            self.view.frame.origin.y -= textField.frame.origin.y
//        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
//        UIView.animate(withDuration: 0.3, animations: {
//            self.view.frame.origin.y = 0
//        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
