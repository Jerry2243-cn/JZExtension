//
//  JZExtension.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/18.

//这是Jerry在实践中拓展常用控件的集合

import Foundation

public struct JZExtension<Base>{
    let target:Base
    init(_ target:Base){
        self.target = target
    }
}

public protocol JZCompatible{
    associatedtype JZCompatibleType
    var jz:JZCompatibleType{get}
}

public extension JZCompatible{
    var jz:JZExtension<Self>{
        JZExtension(self)
    }
}

extension NSObject:JZCompatible {
 
    public var className: String {
        String(describing: type(of: self))
    }
    
    public var classInfoString: String {
        String(describing: self)
    }
}

extension JZExtension{
    
    @discardableResult
   public func setSelf(block:(Base) -> Void) -> Self{
        block(target)
        return self
    }
}

public typealias ZJBlock = () -> Void
public typealias ZJBlockVoidToBool = () -> Bool
public typealias ZJBlockVoidToInt = () -> Int
public typealias ZJBlockVoidToString = () -> String
