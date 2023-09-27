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


extension UIViewController:UIViewControllerTransitioningDelegate{
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animate = AnimationController()
            return animate
        }
        
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            let animate = AnimationController()
            animate.option = .dismiss
            return animate
            
        }
}
