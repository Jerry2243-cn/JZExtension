//
//  UIView+JZ.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/19.
//

import UIKit

private var jz_tapActionKey = "jz_tapActionKey"

fileprivate extension UIView{
    
    var tapAction: ((UITapGestureRecognizer) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &jz_tapActionKey) as? (UITapGestureRecognizer) -> Void
        }
        set {
            objc_setAssociatedObject(self, &jz_tapActionKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    // UITapGestureRecognizer的事件处理函数
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if let action = self.tapAction {
            action(gesture)
        }
    }
    
}

extension JZExtension where Base:UIView{
    
    /// 添加点击手势到视图(对UIControl不生效)
    ///
    /// - Parameter action: 点击手势触发时执行的闭包。
    public func onTapGesture(action: @escaping (UITapGestureRecognizer) -> Void) {
        
        if self.target is UIControl{
            return
        }
        
        self.target.isUserInteractionEnabled = true
        var tapGesture: UITapGestureRecognizer? = nil
        
        // 查找已存在的 UITapGestureRecognizer
        if let gestures = self.target.gestureRecognizers {
            for gesture in gestures {
                if let tap = gesture as? UITapGestureRecognizer {
                    tapGesture = tap
                    break
                }
            }
        }
        
        // 如果不存在 UITapGestureRecognizer，创建一个并添加到视图
        if tapGesture == nil {
            tapGesture = UITapGestureRecognizer(target: self.target, action: #selector(self.target.handleTap(_:)))
            self.target.addGestureRecognizer(tapGesture!)
        }
        
        // 设置回调函数
        tapGesture?.addTarget(self.target, action: #selector(self.target.handleTap(_:)))
        self.target.tapAction = action
    }
    
}
