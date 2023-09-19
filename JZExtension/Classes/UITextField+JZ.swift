//
//  UITextField+JZ.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/19.
//

import UIKit

private var jz_textFieldDelegateWrapperKey = "jz_textFieldDelegateWrapperKey"

fileprivate extension UITextField{
    var delegateWrapper: JZTextFieldDelegateWrapper {
        if let existingWrapper = objc_getAssociatedObject(self, &jz_textFieldDelegateWrapperKey) as? JZTextFieldDelegateWrapper {
            return existingWrapper
        } else {
            let newWrapper = JZTextFieldDelegateWrapper()
            objc_setAssociatedObject(self, &jz_textFieldDelegateWrapperKey, newWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return newWrapper
        }
    }
}

extension JZExtension where Base: UITextField{
    
    private func setDelegate(){
        self.target.delegate = self.target.delegateWrapper
    }
    
    /// 设置 `UITextField` 的 `shouldClear` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `shouldClear` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func shouldClear(handler: @escaping (UITextField) -> Bool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldClearHandler = handler
        return self
    }
    
    /// 设置 `UITextField` 的 `shouldReturn` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `shouldReturn` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func shouldReturn(handler: @escaping (UITextField) -> Bool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldReturnHandler = handler
        return self
    }
    
    /// 设置 `UITextField` 的 `didEndEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `didEndEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func didEndEditing(handler: @escaping (UITextField) -> Void) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldDidEndEditingHandler = handler
        return self
    }
    
    /// 设置 `UITextField` 的 `didBeginEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `didBeginEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func didBeginEditing(handler: @escaping (UITextField) -> Void) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldDidBeginEditingHandler = handler
        return self
    }
    
    /// 设置 `UITextField` 的 `shouldEndEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `shouldEndEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func shouldEndEditing(handler: @escaping (UITextField) -> Bool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldEndEditingHandler = handler
        return self
    }
    
    /// 设置 `UITextField` 的 `textFieldDidChangeSelection` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `textFieldDidChangeSelection` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func didChange(handler: @escaping (UITextField) -> Void) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldDidChangeSelectionHandler = handler
        return self
    }
    
    /// 设置 `UITextField` 的 `shouldBeginEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `shouldBeginEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func shouldBeginEditing(handler: @escaping (UITextField) -> Bool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldBeginEditingHandler = handler
        return self
    }
    
    /// 设置 `UITextField` 的 `didEndEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `didEndEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func didEndEditing(handler: @escaping (UITextField, UITextField.DidEndEditingReason) -> Void) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldDidEndEditingWithReasonHandler = handler
        return self
    }
    
    /// 设置 `UITextField` 的 `shouldChangeCharactersIn` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `shouldChangeCharactersIn` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func shouldChangeCharacters(handler: @escaping (UITextField, NSRange, String) -> Bool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldChangeCharactersHandler = handler
        return self
    }
    
}

class JZTextFieldDelegateWrapper:NSObject,UITextFieldDelegate{
    
    var textFieldShouldClearHandler: ((UITextField) -> Bool)?
    var textFieldShouldReturnHandler: ((UITextField) -> Bool)?
    var textFieldDidEndEditingHandler: ((UITextField) -> Void)?
    var textFieldDidBeginEditingHandler: ((UITextField) -> Void)?
    var textFieldShouldEndEditingHandler: ((UITextField) -> Bool)?
    var textFieldDidChangeSelectionHandler: ((UITextField) -> Void)?
    var textFieldShouldBeginEditingHandler: ((UITextField) -> Bool)?
    var textFieldDidEndEditingWithReasonHandler: ((UITextField, UITextField.DidEndEditingReason) -> Void)?
    var textFieldShouldChangeCharactersHandler: ((UITextField, NSRange, String) -> Bool)?
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return textFieldShouldClearHandler?(textField) ?? true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textFieldShouldReturnHandler?(textField) ?? true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldDidEndEditingHandler?(textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldDidBeginEditingHandler?(textField)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return textFieldShouldEndEditingHandler?(textField) ?? true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldDidChangeSelectionHandler?(textField)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return textFieldShouldBeginEditingHandler?(textField) ?? true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textFieldDidEndEditingWithReasonHandler?(textField, reason)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textFieldShouldChangeCharactersHandler?(textField, range, string) ?? true
    }
    
    
}
