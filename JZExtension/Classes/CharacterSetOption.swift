//
//  CharacterSetOption.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/20.
//

import Foundation

public enum CharacterSetOption {
    case digits
    case letters
    case custom(String)
    
    func characterSet() -> CharacterSet {
        switch self {
        case .digits:
            return CharacterSet.decimalDigits
        case .letters:
            return CharacterSet.letters
        case .custom(let customSet):
            return CharacterSet(charactersIn: customSet)
        }
    }
}

public struct CharacterSetOptions: OptionSet {
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public init(rawValue: Int, customCharacterSet:String) {
        self.rawValue = rawValue
        CharacterSetOptions.customCharacterSet = customCharacterSet
    }
    
    public var rawValue: Int
    // 自定义字符集字符串
    public static var customCharacterSet: String?
    
    static let digits = CharacterSetOptions(rawValue: 1 << 0)
    static let letters = CharacterSetOptions(rawValue: 1 << 1)
    
    static func custom(_ customCharacterSet: String) -> CharacterSetOptions {
        return .init(rawValue: 1 << 2, customCharacterSet: customCharacterSet)
    }
}

