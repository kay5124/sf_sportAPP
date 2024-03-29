//
//  ViewController.swift
//  sf_sportAPP
//
//  Created by Ray   on 2019/5/20.
//  Copyright © 2019 Ray  . All rights reserved.
//
import UIKit
import Foundation
import SideMenu
import Alamofire

class MainViewController: UIViewController {
    
    @IBOutlet weak var myView: UIView!
    private var nowViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _GLobalService.myMainVC = self
        
        //初始化side menu
        initSideMenu()
        
        let vc_login = storyboard?.instantiateViewController(withIdentifier: "vc_login") as! LoginViewController
        switchViewController(myView, _GLobalService.nowViewController, vc_login)
        
    }
    
    //隱藏上方tool bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //回主頁
    public func goHome(){
        let vc_home = storyboard?.instantiateViewController(withIdentifier: "vc_home") as! HomeViewController
        switchViewController(myView, _GLobalService.nowViewController, vc_home)
    }
    
    ///初始化side menu
    public func initSideMenu(){
        let vc_menu = storyboard?.instantiateViewController(withIdentifier: "vc_Menu") as! SideMenuViewController
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: vc_menu)
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuWidth = view.frame.width / 2 + 50
        
        _GLobalService.sideMenuLeftViewController = SideMenuManager.default.menuLeftNavigationController
    }
    
    public func SideMenuCloseEvent(){
        
        
        
        switch _GLobalService.menuClickIdx {
        case 0:
            if _GLobalService.nowViewController is HomeViewController {
                return
            }
            
            let vc_home = storyboard?.instantiateViewController(withIdentifier: "vc_home") as! HomeViewController
            switchViewController(myView, _GLobalService.nowViewController, vc_home)
            break
        case 1:
            showAlertDialog("提示", "此功能尚未開放")
            break
        case 2:
            let vc_global = storyboard?.instantiateViewController(withIdentifier: "vc_global") as! GlobalViewController
            self.navigationController?.pushViewController(vc_global, animated: true)
            break
        case 3:
            let vc_global = storyboard?.instantiateViewController(withIdentifier: "vc_global") as! GlobalViewController
            self.navigationController?.pushViewController(vc_global, animated: true)
            break
        case 4:
            showAlertDialog("提示", "此功能尚未開放")
            break
        case 5:
            showAlertDialog("提示", "此功能尚未開放")
            break
        case 6:
            showAlertDialog("提示", "此功能尚未開放")
            break
        case 7:
            let vc_global = storyboard?.instantiateViewController(withIdentifier: "vc_global") as! GlobalViewController
            self.navigationController?.pushViewController(vc_global, animated: true)
            break
        case 8:
            showAlertDialog("提示", "此功能尚未開放")
            break
        case 9:
            let vc_login = storyboard?.instantiateViewController(withIdentifier: "vc_login") as! LoginViewController
            switchViewController(myView, _GLobalService.nowViewController, vc_login)
            break
        default:
            showAlertDialog("提示", "此功能尚未開放")
            break
        }
    }
    
}


extension UIViewController {
    
    public func switchViewController(_ containerView: UIView, _ fromVC: UIViewController?, _ toVC: UIViewController?) {
        if (fromVC != nil)
        {
            fromVC!.willMove(toParent: nil) // 通知from即将从父ViewController移除
            fromVC!.view.removeFromSuperview() // 移除from的view
            fromVC!.removeFromParent() // 移除from的ViewController
        }
        
        if (toVC != nil)
        {
            addChild(toVC!) // 添加to的ViewController到父ViewController
            let cgRect = CGRect(x: 0.0, y: 0.0, width: containerView.frame.width, height: containerView.frame.height)
            toVC!.view.frame = cgRect
            containerView.addSubview(toVC!.view)
            toVC?.didMove(toParent: toVC) // 通知to已经添加到父ViewController
            
            _GLobalService.nowViewController = toVC
        }
    }
    
    public func showAlertDialog(_ title: String, _ message: String) {
        let okAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /// Enables or disables the swipe gestures used to show a SideMenu on the given side (default: left).
    public func enableSideMenu(_ enable: Bool) {
        if enable == false {
            SideMenuManager.default.menuWidth = 0
        } else {
            SideMenuManager.default.menuWidth = view.frame.width / 2 + 50
        }
    }
}

extension NSMutableAttributedString{
    // If no text is send, then the style will be applied to full text
    func setColorForText(_ textToFind: String?, with color: UIColor) {
        
        let range:NSRange?
        if let text = textToFind{
            range = self.mutableString.range(of: text, options: .caseInsensitive)
        }else{
            range = NSMakeRange(0, self.length)
        }
        if range!.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range!)
        }
    }
}
