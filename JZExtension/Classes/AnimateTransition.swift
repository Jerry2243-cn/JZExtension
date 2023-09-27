//
//  AnimateTransition.swift
//  JZExtension
//
//  Created by qingshan on 2023/9/27.
//

import UIKit

enum OptionType{
    case present,dismiss
}

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var option:OptionType = .present
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let overlay = UIView(frame: UIScreen.main.bounds)
        overlay.backgroundColor = .black
        if option == .present {
            guard let toView = transitionContext.view(forKey: .to),
                  let fromView = findView(in: transitionContext.viewController(forKey: .from), satisfying: { view in
                      return view.tag != 0 && view.tag == toView.tag
                  })
            else {return}
            let fromViewShotcut = fromView.snapshotView(afterScreenUpdates: true)!
            fromViewShotcut.frame = fromView.convert(fromView.bounds, to: nil)
            containerView.addSubview(fromViewShotcut)
            containerView.addSubview(overlay)
            let toViewShotcut = toView.snapshotView(afterScreenUpdates: true)!
            toViewShotcut.frame = fromView.frame
            containerView.addSubview(toViewShotcut)
            toViewShotcut.alpha = 0
            overlay.alpha = 0
            fromView.alpha = 0
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromViewShotcut.frame = UIScreen.main.bounds
                toViewShotcut.frame = UIScreen.main.bounds
                fromViewShotcut.alpha = 0
                toViewShotcut.alpha = 1
                overlay.alpha = 0.3
            }) { (completed) in
                fromView.alpha = 1
                toViewShotcut.removeFromSuperview()
                fromViewShotcut.removeFromSuperview()
                transitionContext.viewController(forKey: .from)?.view.removeFromSuperview()
                containerView.addSubview(toView)
                overlay.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        } else {
            
            guard let fromView = transitionContext.view(forKey: .from),
                  let toView = findView(in: transitionContext.viewController(forKey: .to), satisfying: { view in
                      view.tag != 0 && view.tag == fromView.tag
                  })
            else {return}
            
            containerView.addSubview(transitionContext.viewController(forKey: .to)!.view)
            let toViewShotcut = toView.snapshotView(afterScreenUpdates: true)!
            toViewShotcut.frame = UIScreen.main.bounds
            containerView.addSubview(toViewShotcut)
            containerView.addSubview(overlay)
            let fromViewShotcut = fromView.snapshotView(afterScreenUpdates: true)!
            fromViewShotcut.frame = UIScreen.main.bounds
            containerView.addSubview(fromViewShotcut)
            
            
            toViewShotcut.alpha = 0
            overlay.alpha = 0
            toView.alpha = 0
            overlay.alpha = 0.3
            fromView.alpha = 0
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromViewShotcut.frame = toView.frame
                toViewShotcut.frame = toView.convert(toView.bounds, to: nil)
                fromViewShotcut.alpha = 0
                toViewShotcut.alpha = 1
                
                overlay.alpha = 0
            }) { (completed) in
                toView.alpha = 1
                toViewShotcut.removeFromSuperview()
                fromViewShotcut.removeFromSuperview()
                overlay.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
    
    func findView(in controller: UIViewController?, satisfying condition: (UIView) -> Bool) -> UIView? {
        guard let controller = controller else {return nil}
        // 遍历控制器的视图
        
        for subview in controller.view.subviews {
            
            if let collectionView = subview as? UICollectionView {
                for cell in collectionView.visibleCells {
                    if condition(cell) {
                        return cell
                    }
                }
            }else if let tableView = subview as? UITableView {
                for cell in tableView.visibleCells {
                    if condition(cell) {
                        return cell
                    }
                }
            }else if condition(subview){
                return subview
            }
        }
        
        for childVC in controller.children{
            if let matchingSubview = findView(in: childVC, satisfying: condition) {
                return matchingSubview
            }
        }
        // 如果没有找到满足条件的视图，返回nil
        return nil
    }
    
    
}

