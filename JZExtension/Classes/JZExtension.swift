//
//  JZExtension.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/18.

//这是Jerry在实践中拓展常用控件的集合

import Foundation

public class JerryExtension<Base>{
    let target:Base
    init(_ target:Base){
        self.target = target
    }
}

public protocol JerryCompatible{
    associatedtype JerryCompatibleType
    var jz:JerryCompatibleType{get}
}

public extension JerryCompatible{
    var jz:JerryExtension<Self>{
        JerryExtension(self)
    }
}

extension NSObject:JerryCompatible {
 
    var getClassName: String {
        String(describing: type(of: self))
    }
}

