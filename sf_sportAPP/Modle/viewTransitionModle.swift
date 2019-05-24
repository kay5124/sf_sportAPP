import UIKit

extension UIView {
    
    /// view 跳轉
    ///
    /// - Parameters:
    ///   - selfView: 目前所在的view
    ///   - directView: 指向的view
    ///   - transitionMode: 跳轉的動畫
    func DirectView(selfView: UIView, directView: UIView, time: Double , transitionMode: UIView.AnimationOptions){
        UIView.transition(with: selfView, duration: time, options: transitionMode,
                          animations: {selfView.addSubview(directView)}, completion: nil)
    }
}
