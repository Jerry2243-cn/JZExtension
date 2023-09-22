//
//  UITableView+JZ.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/18.
//

import UIKit

private var jz_tableViewDelegateWrapperKey = "jz_tableViewDelegateWrapperKey"

fileprivate extension UITableView {
    var tableViewDelegateWrapper: JZTableViewDelegateWrapper {
        if let existingWrapper = objc_getAssociatedObject(self, &jz_tableViewDelegateWrapperKey) as? JZTableViewDelegateWrapper {
            return existingWrapper
        } else {
            let newWrapper = JZTableViewDelegateWrapper()
            objc_setAssociatedObject(self, &jz_tableViewDelegateWrapperKey, newWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return newWrapper
        }
    }
}

extension JZExtension where Base: UITableView{
    
    private func setDelegate(){
        if self.target.delegate == nil{
            self.target.delegate = self.target.tableViewDelegateWrapper
        }
        if self.target.dataSource == nil{
            self.target.dataSource = self.target.tableViewDelegateWrapper
        }
    }
    
    /// 注册 UITableViewCell 类型的 Cell。
    ///
    /// - Parameters:
    ///   - cellType: UITableViewCell 类型。
    ///   - forCellReuseIdentifier: Cell 的重用标识符。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func register<T: UITableViewCell>(_ cellType: T.Type, forCellReuseIdentifier:String) -> Self {
        self.target.register(cellType, forCellReuseIdentifier: forCellReuseIdentifier)
        return self
    }
    
    // MARK: - UITableViewDelegate
    
    /// 设置点击Cell回调。
    ///
    /// - Parameter handler: 点击Cell回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func didSelectRow(handler: @escaping (UITableView, IndexPath) -> Void) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.didSelectRowHandlers.append(handler)
        return self
    }
    
    /// 设置行高的闭包回调。
    ///
    /// - Parameter handler: 行高的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func heightForRowAt(handler: @escaping (UITableView, IndexPath) -> CGFloat) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.heightForRowAtHandler = handler
        return self
    }
    
    /// 设置 section 头部视图的闭包回调。
    ///
    /// - Parameter handler: section 头部视图的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func viewForHeaderInSection(handler: @escaping (UITableView, Int) -> UIView?) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.viewForHeaderInSectionHandler = handler
        return self
    }
    
    /// 设置 section 尾部视图的闭包回调。
    ///
    /// - Parameter handler: section 尾部视图的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func viewForFooterInSection(handler: @escaping (UITableView, Int) -> UIView?) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.viewForFooterInSectionHandler = handler
        return self
    }
    
    /// 设置 section 头部高度的闭包回调。
    ///
    /// - Parameter handler: section 头部高度的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func heightForHeaderInSection(handler: @escaping (UITableView, Int) -> CGFloat) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.heightForHeaderInSectionHandler = handler
        return self
    }
    
    /// 设置 section 尾部高度的闭包回调。
    ///
    /// - Parameter handler: section 尾部高度的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func heightForFooterInSection(handler: @escaping (UITableView, Int) -> CGFloat) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.heightForFooterInSectionHandler = handler
        return self
    }
    
    // MARK: - UITableViewDataSource
    
    /// 设置每个 section 中的行数的闭包回调。
    ///
    /// - Parameter handler: 每个 section 中的行数的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func numberOfRowsInSection(handler: @escaping (UITableView, Int) -> Int) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.numberOfRowsInSectionHandler = handler
        return self
    }
    
    /// 设置每个 indexPath 处的 Cell 的闭包回调。
    ///
    /// - Parameter handler: 每个 indexPath 处的 Cell 的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func cellForRow(handler: @escaping (UITableView, IndexPath) -> UITableViewCell) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.cellForRowHandler = handler
        return self
    }
    
    /// 设置 section 的数量的闭包回调。
    ///
    /// - Parameter handler: section 的数量的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func numberOfSections(handler: @escaping (UITableView) -> Int) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.numberOfSectionsHandler = handler
        return self
    }
    
    /// 设置 section 头部标题的闭包回调。
    ///
    /// - Parameter handler: section 头部标题的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func titleForHeaderInSection(handler: @escaping (UITableView, Int) -> String?) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.titleForHeaderInSectionHandler = handler
        return self
    }
    
    /// 设置 section 尾部标题的闭包回调。
    ///
    /// - Parameter handler: section 尾部标题的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func titleForFooterInSection(handler: @escaping (UITableView, Int) -> String?) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.titleForFooterInSectionHandler = handler
        return self
    }
    
}


class JZTableViewDelegateWrapper: JZScrollViewDelegateWrapper, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDelegate
    
    var heightForRowAtHandler: ((UITableView, IndexPath) -> CGFloat)?
    var viewForHeaderInSectionHandler: ((UITableView, Int) -> UIView?)?
    var viewForFooterInSectionHandler: ((UITableView, Int) -> UIView?)?
    var heightForHeaderInSectionHandler: ((UITableView, Int) -> CGFloat)?
    var heightForFooterInSectionHandler: ((UITableView, Int) -> CGFloat)?
    var didSelectRowHandlers: [((UITableView, IndexPath) -> Void)?] = []
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAtHandler?(tableView, indexPath) ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewForHeaderInSectionHandler?(tableView, section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return viewForFooterInSectionHandler?(tableView, section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderInSectionHandler?(tableView, section) ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return heightForFooterInSectionHandler?(tableView, section) ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for handler in didSelectRowHandlers{
            handler?(tableView,indexPath)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    var numberOfRowsInSectionHandler: ((UITableView, Int) -> Int)?
    var cellForRowHandler: ((UITableView, IndexPath) -> UITableViewCell)?
    var numberOfSectionsHandler: ((UITableView) -> Int)?
    var titleForHeaderInSectionHandler: ((UITableView, Int) -> String?)?
    var titleForFooterInSectionHandler: ((UITableView, Int) -> String?)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSectionHandler?(tableView, section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRowHandler?(tableView, indexPath) ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSectionsHandler?(tableView) ?? 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleForHeaderInSectionHandler?(tableView, section)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return titleForFooterInSectionHandler?(tableView, section)
    }
}

