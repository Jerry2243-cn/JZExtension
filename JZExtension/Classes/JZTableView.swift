//
//  JZTableView.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/10/8.
//

import UIKit

protocol JZTableViewCellConfigure{
    associatedtype CellModelType
    func configureDataWithModel(_ model:CellModelType, at indexPath:IndexPath)
}

class JZTableView<Element, Cell: UITableViewCell & JZTableViewCellConfigure>: UITableView where Cell.CellModelType == Element {
    
    private var data: [Element] = []
    private var cellIdentifier: String {
        return "\(Element.self).\(Cell.self)"
    }
    
   fileprivate init() {
        super.init(frame: .zero, style: .plain)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.jz.register(Cell.self, forCellReuseIdentifier: cellIdentifier)
            .numberOfRowsInSection { [unowned self] _ in
                data.count
            }
            .cellForRowAt { [unowned self] indexPath in
                let cell = self.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell
                cell.configureDataWithModel(data[indexPath.row], at: indexPath)
                return cell
            }
    }
    
    public func updateDataSource(with dataSource: [Element]) {
        self.data = dataSource
        self.reloadData()
    }
    
    public func onCellSelected(block:@escaping(Cell, IndexPath) -> Void){
        self.jz.didSelectRowAt { indexPath in
            let cell = self.cellForRow(at: indexPath) as! Cell
            block(cell,indexPath)
        }
    }
    
    public func onScrill(block:@escaping()->Void){
        self.jz.scrollViewDidScroll {
            block()
        }
    }
    
}

class JZTableViewFactory{
    
    static func create<ModelType, CellType>(cell: CellType.Type, cellModel:ModelType.Type) -> JZTableView<ModelType, CellType> {
           return JZTableView<ModelType, CellType>()
       }
    
}
