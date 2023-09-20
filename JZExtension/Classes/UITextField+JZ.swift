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
    
    @discardableResult
    func setlimit(count:Int,acceptCharSet:CharacterSetOptions? = nil) -> Self{
        var charSet = CharacterSet()
        if let characterSetOptions = acceptCharSet{
            
            if characterSetOptions.contains(.digits) {
                charSet.formUnion(CharacterSet.decimalDigits)
            }
            
            if characterSetOptions.contains(.letters) {
                charSet.formUnion(CharacterSet.letters)
            }
            
            if let customCharacterSet = CharacterSetOptions.customCharacterSet{
                // 添加你的自定义字符集
                let customSet = CharacterSet(charactersIn: customCharacterSet)
                charSet.formUnion(customSet)
                CharacterSetOptions.customCharacterSet = nil
            }
        }
        return shouldChangeCharacters { textField, range, text in
            if text.count == 0 {
                return true // 允许删除
            }
            
            if acceptCharSet == nil {
                return range.location < count
            }
            
            let textCharacterSet = CharacterSet(charactersIn: text)
            return charSet.isSuperset(of: textCharacterSet) && range.location < count
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
        self.target.delegateWrapper.textFieldShouldClearHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `shouldReturn` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `shouldReturn` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func shouldReturn(handler: @escaping (UITextField) -> Bool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldReturnHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `didEndEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `didEndEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func didEndEditing(handler: @escaping (UITextField) -> Void) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldDidEndEditingHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `didBeginEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `didBeginEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func didBeginEditing(handler: @escaping (UITextField) -> Void) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldDidBeginEditingHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `shouldEndEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `shouldEndEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func shouldEndEditing(handler: @escaping (UITextField) -> Bool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldEndEditingHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `textFieldDidChangeSelection` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `textFieldDidChangeSelection` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func didChange(handler: @escaping (UITextField) -> Void) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldDidChangeSelectionHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `shouldBeginEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `shouldBeginEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func shouldBeginEditing(handler: @escaping (UITextField) -> Bool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldBeginEditingHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `didEndEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `didEndEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func didEndEditing(handler: @escaping (UITextField, UITextField.DidEndEditingReason) -> Void) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldDidEndEditingWithReasonHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `shouldChangeCharactersIn` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `shouldChangeCharactersIn` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func shouldChangeCharacters(handler: @escaping (UITextField, NSRange, String) -> Bool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldChangeCharactersHandlers.append(handler)
        return self
    }
    
}

class JZTextFieldDelegateWrapper:NSObject,UITextFieldDelegate{
    
    var textFieldShouldClearHandlers: [((UITextField) -> Bool)?] = []
    var textFieldShouldReturnHandlers: [((UITextField) -> Bool)?] = []
    var textFieldDidEndEditingHandlers: [((UITextField) -> Void)?] = []
    var textFieldDidBeginEditingHandlers: [((UITextField) -> Void)?] = []
    var textFieldShouldEndEditingHandlers: [((UITextField) -> Bool)?] = []
    var textFieldDidChangeSelectionHandlers: [((UITextField) -> Void)?] = []
    var textFieldShouldBeginEditingHandlers: [((UITextField) -> Bool)?] = []
    var textFieldDidEndEditingWithReasonHandlers: [((UITextField, UITextField.DidEndEditingReason) -> Void)?] = []
    var textFieldShouldChangeCharactersHandlers: [((UITextField, NSRange, String) -> Bool)?] = []
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        var flag = true
        for handler in textFieldShouldClearHandlers{
            flag = handler?(textField) ?? true && flag
        }
        return flag
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var flag = true
        for handler in textFieldShouldReturnHandlers{
            flag = handler?(textField) ?? true && flag
        }
        return flag
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        for handler in textFieldDidEndEditingHandlers{
            handler?(textField)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for handler in textFieldDidBeginEditingHandlers{
            handler?(textField)
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        var flag = true
        for handler in textFieldShouldEndEditingHandlers{
            flag = handler?(textField) ?? true && flag
        }
        return flag
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        for handler in textFieldDidChangeSelectionHandlers{
            handler?(textField)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var flag = true
        for handler in textFieldShouldBeginEditingHandlers{
            flag = handler?(textField) ?? true && flag
        }
        return flag
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        for handler in textFieldDidEndEditingWithReasonHandlers{
            handler?(textField,reason)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var flag = true
        for handler in textFieldShouldChangeCharactersHandlers{
            flag = handler?(textField, range, string) ?? true && flag
        }
        return flag
    }
    
    
}
