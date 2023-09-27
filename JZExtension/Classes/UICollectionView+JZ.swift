////
////  UICollectionView+JZ.swift
////  JZExtension
////
////  Created by Jerry Zhu on 2023/9/27.
////
//
//import UIKit
//
//private var jz_tableViewDelegateWrapperKey = "jz_tableViewDelegateWrapperKey"
//fileprivate extension UICollectionView{
//    var collectionViewDelegateWrapper: JZCollectionViewDelegateWrapper {
//        if let existingWrapper = objc_getAssociatedObject(self, &jz_tableViewDelegateWrapperKey) as? JZCollectionViewDelegateWrapper {
//            return existingWrapper
//        } else {
//            let newWrapper = JZCollectionViewDelegateWrapper()
//            objc_setAssociatedObject(self, &jz_tableViewDelegateWrapperKey, newWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return newWrapper
//        }
//    }
//}
//
//extension JZExtension where Base: UICollectionView{
//
//    private func setDelegate(){
//        if self.target.delegate == nil{
//            self.target.delegate = self.target.collectionViewDelegateWrapper
//        }
//        if self.target.dataSource == nil{
//            self.target.dataSource = self.target.collectionViewDelegateWrapper
//        }
//    }
//
//    /// 注册 UICollectionView 类型的 Cell。
//    ///
//    /// - Parameters:
//    ///   - cellType: UICollectionViewCell 类型。
//    ///   - forCellReuseIdentifier: Cell 的重用标识符。
//    /// - Returns: 当前扩展对象。
//    @discardableResult
//    public func register<T: UICollectionViewCell>(_ cellType: T.Type, forCellReuseIdentifier:String) -> Self {
//        self.target.register(cellType, forCellWithReuseIdentifier: forCellReuseIdentifier)
//        return self
//    }
//
//
//
//}
//
//class JZCollectionViewDelegateWrapper:JZScrollViewDelegateWrapper,UICollectionViewDelegate,UICollectionViewDataSource{
//
//    
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}
