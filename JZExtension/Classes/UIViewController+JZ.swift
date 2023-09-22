//
//  UIViewController+JZ.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/22.
//

import UIKit

extension UIViewController{
    
    static var topViewController: UIViewController? {
          var topVC = UIApplication.shared.keyWindow?.rootViewController
          
          while let presentedVC = topVC?.presentedViewController {
              topVC = presentedVC
          }
          
          return topVC
      }
}

extension JZExtension where Base: UIViewController{
    
   
    
}
