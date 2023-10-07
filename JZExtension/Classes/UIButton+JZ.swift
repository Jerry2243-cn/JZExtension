//
//  UIButton+JZ.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/21.
//

import UIKit

private var jz_actionsKey = "jz_actionsKey"

fileprivate extension UIButton{
    
    var jz_action: JZBlock? {
        get {
            return objc_getAssociatedObject(self, &jz_actionsKey) as? JZBlock
        }
        set {
            objc_setAssociatedObject(self, &jz_actionsKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    @objc func handleAction(_ button:UIButton) {
        jz_action?()
    }
}

extension JZExtension where Base: UIButton{
    
    ///为按钮添加点击事件
    ///
    /// - Parameter action: 触发点击事件的回调
    /// - Returns :对象自身
    @discardableResult
    public func onTouchUpInside(action:@escaping JZBlock) -> Self{
        
        target.jz_action = action
        
        self.target.addTarget(target, action: #selector(target.handleAction(_:)), for: .touchUpInside)
        return self
    }
    
}
