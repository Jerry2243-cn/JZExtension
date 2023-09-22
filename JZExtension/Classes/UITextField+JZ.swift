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
    
    ///设置水平内边距，对于已设置leftView或rightView的部分不生效
    ///
    /// - Parameter value: 边距的值
    ///- Returns: 该拓展对象自身。
    @discardableResult
    public func setInsertsHorizontally(_ value:CGFloat) -> Self{
        if let _ = self.target.leftView{
          
        }else{
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.target.frame.height))
            self.target.leftView = leftView
            self.target.leftViewMode = .always
        }
        
        if let _ = self.target.rightView{
          
        }else{
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.target.frame.height))
            self.target.rightView = rightView
            self.target.rightViewMode = .always
        }
        
        return self
    }
    
}

extension JZExtension where Base: UITextField{
    
    /// 设置 `UITextField` 的输入字符数限制以及字符集(可选,nil为接受任意字符)限制
    ///
    /// - Parameters:
    ///   - count: 输入字符数限制。
    ///   - acceptCharSet: 输入字符集限制。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func setLimit(count:Int,acceptCharSet:CharacterSetOptions? = nil) -> Self{
        var charSet = CharacterSet()
        if let characterSetOptions = acceptCharSet{
            
            if characterSetOptions.contains(.digits) {
                charSet.formUnion(CharacterSet.decimalDigits)
            }
            
            if characterSetOptions.contains(.letters) {
                charSet.formUnion(CharacterSet.letters)
            }
            
            if let customCharacterSet = CharacterSetOptions.customCharacterSet{
                // 添加自定义字符集
                let customSet = CharacterSet(charactersIn: customCharacterSet)
                charSet.formUnion(customSet)
                CharacterSetOptions.customCharacterSet = nil
            }
        }
        return shouldChangeCharacters { range, text in
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
    public func shouldClear(handler: @escaping ZJBlockVoidToBool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldClearHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `shouldReturn` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `shouldReturn` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func shouldReturn(handler: @escaping ZJBlockVoidToBool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldReturnHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `didEndEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `didEndEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func didEndEditing(handler: @escaping ZJBlock) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldDidEndEditingHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `didBeginEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `didBeginEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func didBeginEditing(handler: @escaping ZJBlock) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldDidBeginEditingHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `shouldEndEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `shouldEndEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func shouldEndEditing(handler: @escaping ZJBlockVoidToBool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldEndEditingHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `textFieldDidChangeSelection` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `textFieldDidChangeSelection` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func didChange(handler: @escaping ZJBlock) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldDidChangeSelectionHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `shouldBeginEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `shouldBeginEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func shouldBeginEditing(handler: @escaping ZJBlockVoidToBool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldBeginEditingHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `didEndEditing` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `didEndEditing` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func didEndEditing(handler: @escaping (UITextField.DidEndEditingReason) -> Void) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldDidEndEditingWithReasonHandlers.append(handler)
        return self
    }
    
    /// 设置 `UITextField` 的 `shouldChangeCharactersIn` 代理方法的回调闭包。
    ///
    /// - Parameter handler: 当 `shouldChangeCharactersIn` 代理方法被调用时执行的闭包。
    /// - Returns: 该拓展对象自身。
    @discardableResult
    public func shouldChangeCharacters(handler: @escaping (NSRange, String) -> Bool) -> Self {
        setDelegate()
        self.target.delegateWrapper.textFieldShouldChangeCharactersHandlers.append(handler)
        return self
    }
    
}

class JZTextFieldDelegateWrapper:NSObject,UITextFieldDelegate{
    
    var textFieldShouldClearHandlers: [ZJBlockVoidToBool?] = []
    var textFieldShouldReturnHandlers: [ZJBlockVoidToBool?] = []
    var textFieldDidEndEditingHandlers: [ZJBlock?] = []
    var textFieldDidBeginEditingHandlers: [ZJBlock?] = []
    var textFieldShouldEndEditingHandlers: [ZJBlockVoidToBool?] = []
    var textFieldDidChangeSelectionHandlers: [ZJBlock?] = []
    var textFieldShouldBeginEditingHandlers: [ZJBlockVoidToBool?] = []
    var textFieldDidEndEditingWithReasonHandlers: [((UITextField.DidEndEditingReason) -> Void)?] = []
    var textFieldShouldChangeCharactersHandlers: [((NSRange, String) -> Bool)?] = []
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        var flag = true
        for handler in textFieldShouldClearHandlers{
            flag = handler?() ?? true && flag
        }
        return flag
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var flag = true
        for handler in textFieldShouldReturnHandlers{
            flag = handler?() ?? true && flag
        }
        return flag
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        for handler in textFieldDidEndEditingHandlers{
            handler?()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for handler in textFieldDidBeginEditingHandlers{
            handler?()
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        var flag = true
        for handler in textFieldShouldEndEditingHandlers{
            flag = handler?() ?? true && flag
        }
        return flag
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        for handler in textFieldDidChangeSelectionHandlers{
            handler?()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var flag = true
        for handler in textFieldShouldBeginEditingHandlers{
            flag = handler?() ?? true && flag
        }
        return flag
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        for handler in textFieldDidEndEditingWithReasonHandlers{
            handler?(reason)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var flag = true
        for handler in textFieldShouldChangeCharactersHandlers{
            flag = handler?(range, string) ?? true && flag
        }
        return flag
    }
    
    
}
