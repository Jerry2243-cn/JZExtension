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
    
    @discardableResult
    func addElements<Element,Cell:UITableViewCell>(_ elements:[Element], cell:Cell.Type, cellNibName:String? = nil, row:@escaping (Element,Cell,Int) -> Void, didSelectRow:@escaping(Cell,Int) -> Void) -> Self{
        
        let cellIdentifier = "\(Element.self).\(Cell.self)"
        register(Cell.self, forCellReuseIdentifier: cellIdentifier)
            .numberOfSections {
                1
            }
            .numberOfRowsInSection { _ in
                elements.count
            }
            .cellForRowAt { indexPath in
               let cell = target.dequeueReusableCell(withIdentifier: cellIdentifier) as! Cell
                row(elements[indexPath.row], cell, indexPath.row)
                return cell
            }
            .didSelectRowAt { indexPath in
                target.deselectRow(at: indexPath, animated: true)
                let cell = target.cellForRow(at: indexPath) as! Cell
                didSelectRow(cell, indexPath.row)
            }
        
        return self
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
    public func didSelectRowAt(handler: @escaping (IndexPath) -> Void) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.didSelectRowHandlers.append(handler)
        return self
    }
    
    /// 设置行高的闭包回调。
    ///
    /// - Parameter handler: 行高的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func heightForRowAt(handler: @escaping (IndexPath) -> CGFloat) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.heightForRowAtHandler = handler
        return self
    }
    
    /// 设置 section 头部视图的闭包回调。
    ///
    /// - Parameter handler: section 头部视图的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func viewForHeaderInSection(handler: @escaping (Int) -> UIView?) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.viewForHeaderInSectionHandler = handler
        return self
    }
    
    /// 设置 section 尾部视图的闭包回调。
    ///
    /// - Parameter handler: section 尾部视图的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func viewForFooterInSection(handler: @escaping (Int) -> UIView?) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.viewForFooterInSectionHandler = handler
        return self
    }
    
    /// 设置 section 头部高度的闭包回调。
    ///
    /// - Parameter handler: section 头部高度的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func heightForHeaderInSection(handler: @escaping (Int) -> CGFloat) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.heightForHeaderInSectionHandler = handler
        return self
    }
    
    /// 设置 section 尾部高度的闭包回调。
    ///
    /// - Parameter handler: section 尾部高度的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func heightForFooterInSection(handler: @escaping (Int) -> CGFloat) -> Self {
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
    public func numberOfRowsInSection(handler: @escaping (Int) -> Int) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.numberOfRowsInSectionHandler = handler
        return self
    }
    
    /// 设置每个 indexPath 处的 Cell 的闭包回调。
    ///
    /// - Parameter handler: 每个 indexPath 处的 Cell 的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func cellForRowAt(handler: @escaping (IndexPath) -> UITableViewCell) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.cellForRowHandler = handler
        return self
    }
    
    /// 设置 section 的数量的闭包回调。
    ///
    /// - Parameter handler: section 的数量的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func numberOfSections(handler: @escaping JZBlockVoidToInt) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.numberOfSectionsHandler = handler
        return self
    }
    
    /// 设置 section 头部标题的闭包回调。
    ///
    /// - Parameter handler: section 头部标题的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func titleForHeaderInSection(handler: @escaping (Int) -> String?) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.titleForHeaderInSectionHandler = handler
        return self
    }
    
    /// 设置 section 尾部标题的闭包回调。
    ///
    /// - Parameter handler: section 尾部标题的闭包回调。
    /// - Returns: 当前扩展对象。
    @discardableResult
    public func titleForFooterInSection(handler: @escaping (Int) -> String?) -> Self {
        setDelegate()
        self.target.tableViewDelegateWrapper.titleForFooterInSectionHandler = handler
        return self
    }
    
}


class JZTableViewDelegateWrapper: JZScrollViewDelegateWrapper, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDelegate
    
    var heightForRowAtHandler: ((IndexPath) -> CGFloat)?
    var viewForHeaderInSectionHandler: ((Int) -> UIView?)?
    var viewForFooterInSectionHandler: ((Int) -> UIView?)?
    var heightForHeaderInSectionHandler: ((Int) -> CGFloat)?
    var heightForFooterInSectionHandler: ((Int) -> CGFloat)?
    var didSelectRowHandlers: [((IndexPath) -> Void)?] = []
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAtHandler?(indexPath) ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewForHeaderInSectionHandler?(section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return viewForFooterInSectionHandler?(section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderInSectionHandler?(section) ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return heightForFooterInSectionHandler?(section) ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for handler in didSelectRowHandlers{
            handler?(indexPath)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    var numberOfRowsInSectionHandler: ((Int) -> Int)?
    var cellForRowHandler: ((IndexPath) -> UITableViewCell)?
    var numberOfSectionsHandler: (JZBlockVoidToInt)?
    var titleForHeaderInSectionHandler: ((Int) -> String?)?
    var titleForFooterInSectionHandler: ((Int) -> String?)?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSectionHandler?(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRowHandler?(indexPath) ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSectionsHandler?() ?? 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleForHeaderInSectionHandler?(section)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return titleForFooterInSectionHandler?(section)
    }
}

