//
//  UIResponder+JZ.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/18.
//

import UIKit
/// 拓展 UIResponder
extension JZExtension where Base: UIResponder {
    
    /// 通过传递链获取对象
    ///
    /// - Parameters:
    ///   - targetType: 目标对象的类型。
    ///   - options: 用于处理目标对象的闭包。
    public func router<T>(_ targetType: T.Type, options: ((T) -> Void)?) {
        // 检查当前节点的 target 是否是 targetType 类型的实例
        if let targetSelf = self.target as? T {
            // 如果是，将实例传递给 options
            options?(targetSelf)
        } else {
            // 如果不是，继续向下传递
            self.target.next?.jz.router(targetType, options: options)
        }
    }
}
