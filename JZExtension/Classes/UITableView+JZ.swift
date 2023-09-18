//
//  UITableView+JZ.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/18.
//

import UIKit

private var delegateWrapperKey = "delegateWrapperKey"

extension JerryExtension where Base: UITableView{
    
    private var delegateWrapper: JerryTableViewDelegateWrapper {
        if let existingWrapper = objc_getAssociatedObject(self.target, delegateWrapperKey) as? JerryTableViewDelegateWrapper {
            return existingWrapper
        } else {
            let newWrapper = JerryTableViewDelegateWrapper()
            objc_setAssociatedObject(self.target, delegateWrapperKey, newWrapper, .OBJC_ASSOCIATION_RETAIN)
            return newWrapper
        }
    }
    
    @discardableResult
    public func setSelf(block:((UITableView) -> Void)? = nil) -> Self {
        block?(target)
        return self
    }
    
    @discardableResult
    public func register<T: UITableViewCell>(_ cellType: T.Type, forCellReuseIdentifier:String) -> Self {
        self.target.register(cellType, forCellReuseIdentifier: forCellReuseIdentifier)
        self.target.delegate = delegateWrapper
        return self
    }
    
    @discardableResult
    public func didSelectRow(handler: ((UITableView, IndexPath) -> Void)?) -> Self {
        delegateWrapper.didSelectRowHandler = handler
        self.target.delegate = delegateWrapper
        return self
    }
    
    @discardableResult
    public func numberOfRowsInSection(handler: ((UITableView, Int) -> Int)?) -> Self {
        delegateWrapper.numberOfRowsInSectionHandler = handler
        self.target.dataSource = delegateWrapper
        return self
    }
    
    @discardableResult
    public func cellForRow(handler: ((UITableView, IndexPath) -> UITableViewCell)?) -> Self {
        delegateWrapper.cellForRowHandler = handler
        self.target.dataSource = delegateWrapper
        return self
    }
    
    @discardableResult
    public func numberOfSections(handler: ((UITableView) -> Int)?) -> Self {
        delegateWrapper.numberOfSectionsHandler = handler
        self.target.dataSource = delegateWrapper
        return self
    }
    
}

fileprivate class JerryTableViewDelegateWrapper: NSObject, UITableViewDelegate,UITableViewDataSource {
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
