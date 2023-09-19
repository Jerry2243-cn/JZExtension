//
//  UITableView+JZ.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/18.
//

import UIKit

private var delegateWrapperKey = "delegateWrapperKey"

extension UITableView {
   fileprivate var delegateWrapper: JerryTableViewDelegateWrapper {
        if let existingWrapper = objc_getAssociatedObject(self, delegateWrapperKey) as? JerryTableViewDelegateWrapper {
            return existingWrapper
        } else {
            let newWrapper = JerryTableViewDelegateWrapper()
            objc_setAssociatedObject(self, delegateWrapperKey, newWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return newWrapper
        }
    }
}

extension JerryExtension where Base: UITableView{
    
    private func setDelegate(){
        self.target.delegate = self.target.delegateWrapper
        self.target.dataSource = self.target.delegateWrapper
    }
    
    @discardableResult
    public func setSelf(block:((UITableView) -> Void)) -> Self {
        block(target)
        return self
    }
    
    @discardableResult
    public func register<T: UITableViewCell>(_ cellType: T.Type, forCellReuseIdentifier:String) -> Self {
        setDelegate()
        self.target.register(cellType, forCellReuseIdentifier: forCellReuseIdentifier)

        return self
    }
    
    @discardableResult
    public func didSelectRow(handler: @escaping (UITableView, IndexPath) -> Void) -> Self {
        setDelegate()
        self.target.delegateWrapper.didSelectRowHandler = handler
       
        return self
    }
    
    @discardableResult
    public func numberOfRowsInSection(handler:@escaping (UITableView, Int) -> Int) -> Self {
        setDelegate()
        self.target.delegateWrapper.numberOfRowsInSectionHandler = handler

        return self
    }
    
    @discardableResult
    public func cellForRow(handler:@escaping (UITableView, IndexPath) -> UITableViewCell) -> Self {
        setDelegate()
        self.target.delegateWrapper.cellForRowHandler = handler

        return self
    }
    
    @discardableResult
    public func numberOfSections(handler:@escaping (UITableView) -> Int) -> Self {
        setDelegate()
        self.target.delegateWrapper.numberOfSectionsHandler = handler

        return self
    }
    
}

class JerryTableViewDelegateWrapper: NSObject, UITableViewDelegate,UITableViewDataSource {
    var numberOfRowsInSectionHandler: ((UITableView, Int) -> Int)?
    var cellForRowHandler:((UITableView,IndexPath) -> UITableViewCell)?
    var didSelectRowHandler: ((UITableView, IndexPath) -> Void)?
    var numberOfSectionsHandler: ((UITableView) -> Int)?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        numberOfSectionsHandler?(tableView) ?? 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowHandler?(tableView, indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRowsInSectionHandler?(tableView,section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellForRowHandler?(tableView,indexPath) ?? UITableViewCell()
    }
}
