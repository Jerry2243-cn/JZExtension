//
//  MyView.swift
//  JZExtension
//
//  Created by qingshan on 2023/9/21.
//

import UIKit

class MyView: UITextField {

    init() {
        super.init(frame:.zero)
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("view released")
    }
    
}
