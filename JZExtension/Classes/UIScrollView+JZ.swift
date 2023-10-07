//
//  UIScrollView+JZ.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/22.
//

import UIKit

private var jz_scrollViewDelegateWrapperKey = "jz_scrollViewDelegateWrapperKey"

extension UIScrollView{
    
    var scrollViewDelegateWrapper: JZScrollViewDelegateWrapper {
        
        if let existingWrapper = objc_getAssociatedObject(self, &jz_scrollViewDelegateWrapperKey) as? JZScrollViewDelegateWrapper {
            return existingWrapper
        } else {
            let newWrapper = JZScrollViewDelegateWrapper()
            objc_setAssociatedObject(self, &jz_scrollViewDelegateWrapperKey, newWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return newWrapper
        }
    }
    
}

extension JZExtension where Base: UIScrollView{
    
    private func setDelegate(){
        if self.target.delegate == nil {
            self.target.delegate = self.target.scrollViewDelegateWrapper
        }
    }
    
    // MARK: - UIScrollViewDelegate
      
      @discardableResult
      public func scrollViewDidScroll(handler: @escaping JZBlock) -> Self {
          setDelegate()
          if let wapper = target.delegate as? JZScrollViewDelegateWrapper{
              wapper.didScrollHandlers.append(handler)
          }
          return self
      }
      
      @discardableResult
      public func scrollViewDidZoom(handler: @escaping JZBlock) -> Self {
          setDelegate()
          if let wapper = target.delegate as? JZScrollViewDelegateWrapper{
              wapper.didZoomHandlers.append(handler)
          }
          return self
      }
      
      @discardableResult
      public func scrollViewWillBeginDragging(handler: @escaping JZBlock) -> Self {
          setDelegate()
          if let wapper = target.delegate as? JZScrollViewDelegateWrapper{
              wapper.willBeginDraggingHandlers.append(handler)
          }
          return self
      }
      
      @discardableResult
      public func scrollViewWillEndDragging(handler: @escaping (CGPoint, UnsafeMutablePointer<CGPoint>) -> Void) -> Self {
          setDelegate()
          if let wapper = target.delegate as? JZScrollViewDelegateWrapper{
              wapper.willEndDraggingHandlers.append(handler)
          }
          return self
      }
}

class JZScrollViewDelegateWrapper:NSObject,UIScrollViewDelegate{
    
    // MARK: - UIScrollViewDelegate Handlers
       
       var didScrollHandlers: [JZBlock?] = []
       var didZoomHandlers: [JZBlock?] = []
       var willBeginDraggingHandlers: [JZBlock?] = []
       var willEndDraggingHandlers: [((CGPoint, UnsafeMutablePointer<CGPoint>) -> Void)?] = []
       
       // MARK: - UIScrollViewDelegate
       
       func scrollViewDidScroll(_ scrollView: UIScrollView) {
           for handler in didScrollHandlers{
               handler?()
           }
       }
       
       func scrollViewDidZoom(_ scrollView: UIScrollView) {
           for handler in didZoomHandlers{
               handler?()
           }
       }
       
       func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
           for handler in willBeginDraggingHandlers{
               handler?()
           }
       }
       
       func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
           for handler in willEndDraggingHandlers{
               handler?(velocity, targetContentOffset)
           }
       }
}
