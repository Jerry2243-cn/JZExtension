//
//  ViewController.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController, WaterfallViewFlowLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var data = ["sdvsv","ewrfweefer","sacascds","adcdacsdcasdc","dcds",",gdvdfgdfgdgdfhfhfthertghdfghgfgfgrgergerthbfgnfgnfgjhjntyhndfgndfghnghnfghnfghnf"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = MyCell(frame: .zero)
        cell.label.text = data[indexPath.item] // 将数据设置到 UILabel 中
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        let fittingSize = CGSize(width: collectionView.frame.width, height: UIView.layoutFittingCompressedSize.height)
        let size = cell.contentView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        
        return size
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myCellID, for: indexPath) as! MyCell
        cell.label.text = data[indexPath.item]
        cell.tag = indexPath.item + 1
        cell.contentView.backgroundColor = .gray
        return cell
    }
    
    func waterFlowLayout(waterFlowLayout: WaterfallViewFlowLayout, indexPath: IndexPath, width: CGFloat) -> CGFloat {
        CGFloat(UInt.random(in: 80..<300))
//        let cell = MyCell(frame: .zero)
//        cell.label.text = data[indexPath.item] // 将数据设置到 UILabel 中
//        cell.setNeedsLayout()
//        cell.layoutIfNeeded()
//
//        let fittingSize = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
//        let size = cell.contentView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
//
//        return size.height
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MyCell
        let vc = ViewController1()
        vc.view.tag = indexPath.item + 1
        vc.label.text = cell.label.text
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    

    let tableView = UITableView()
    let tableView1 = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
//
//        var data = ["cell1","cell2","cell3","cell4"]
//
//        tableView.jz.setSelf{ tableview in
//            tableview.contentInsetAdjustmentBehavior = .never
//        }
//        .addElements(data, cell: MyCell.self,row: { str, cell, index in
//            cell.label.text = str
//        }, didSelectRow: { cell, index in
//            cell.label.text = "selected"
//        })
//        .scrollViewDidScroll { [unowned self] in
//            print(tableView.bounds.minY)
//        }
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.left.top.right.equalTo(view)
//            make.bottom.equalTo(view.snp.centerY)
//        }
//
//        tableView1.jz.setSelf{ tableView in
//            tableView.backgroundColor = .lightGray
//        }
//        .register(MyCell.self,forCellReuseIdentifier: myCellID)
//        .didSelectRowAt { [unowned self] indexPath in
//            let cell = tableView1.cellForRow(at: indexPath) as! MyCell
//            print(cell.label.text!)
//            cell.label.text = "selected1 " + "\(cell.i)"
//        }
//        .numberOfSections{
//            3
//        }
//        .numberOfRowsInSection { _ in
//            2
//        }
//        .cellForRowAt { [unowned self] indexPath in
//            let cell = tableView1.dequeueReusableCell(withIdentifier: myCellID) as! MyCell
//            cell.label.text = "section\(indexPath.section)  cell \(indexPath.row)"
//            cell.i = indexPath.row
//            data.append("added")
//            tableView.reloadData()
//
//            return cell
//        }
//        view.addSubview(tableView1)
//        tableView1.snp.makeConstraints { make in
//            make.left.bottom.right.equalTo(view)
//            make.top.equalTo(view.snp.centerY)
//        }
//        
//        let button = UIButton()
//        button.jz.setSelf { button in
//            button.setTitle("Button", for: .normal)
//            button.titleLabel?.textColor = .blue
//            button.backgroundColor = .green
//            button.setTitle("selected", for: .selected)
//            
//            view.addSubview(button)
//            button.snp.makeConstraints { make in
//                make.centerY.equalTo(view).offset(-100)
//                make.centerX.equalTo(view)
//            }
//        }
//        .onTouchUpInside {
//            button.backgroundColor = button.isSelected ? .red : .blue
//            button.isSelected.toggle()
//        }
//        
//        let textField = MyView()
//        textField.jz.setSelf { tf in
//            tf.placeholder = "input"
//            view.addSubview(tf)
//            tf.snp.makeConstraints { make in
//                make.centerX.equalTo(view)
//                make.centerY.equalTo(view).offset(100)
//            }
//        }
//        .setlimit(count: 12, acceptCharSet:[.letters, .digits])
//        .didChange { tf in
//            print(tf.text ?? "")
//        }
//        .didEndEditing { tf in
//            print("endEditing")
//        }
//        .shouldReturn { [unowned self] tf in
//            view.endEditing(true)
//        }
//        
//        let imageView = UIImageView(image: UIImage(named: "img_mine_bill"))
//        imageView.jz.setSelf { iv in
//            view.addSubview(iv)
//            iv.snp.makeConstraints { make in
//                make.center.equalTo(view)
//            }
//        }
//        .onTapGesture { _ in
//            button.isSelected.toggle()
//            textField.removeFromSuperview()
//        }
//        
        
    }
    
    // MARK: 创建CollectionView
    func setup() {

        let flowLayout = WaterfallViewFlowLayout()

        flowLayout.WatefallColumns = 2

        flowLayout.delegate = self

        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        flowLayout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView .register(MyCell.self, forCellWithReuseIdentifier: myCellID)
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

class WaterfallViewFlowLayout: UICollectionViewFlowLayout {

    // 创建一个代理
    var delegate:WaterfallViewFlowLayoutDelegate?
    // 瀑布流的列数
    var WatefallColumns = 2
    // 列间距
    var ColumnsSpacing:CGFloat = 8
    // 行间距
    var LineSpacing:CGFloat = 8
    // 创建存放当前加载的Cell 的布局属性
    var cellLayoutAttributes : [UICollectionViewLayoutAttributes] = []
    // 创建存放Cell 所在列的高度
    var cellColumnsHeights : [CGFloat] = []
    // cell 内容的高度
    var contentHeight:CGFloat = 0
    
    // MARK: 重写初始化方法
    override func prepare() {
        // 调用父类方法
        super.prepare()
        // 初始化每列高度的初始值
        for _ in 0 ..< WatefallColumns {
            cellColumnsHeights.append(self.sectionInset.top)
        }
        // 获取当前加载的Cell个数
        let loadCellCount = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        // 遍历获取的Cell得到每个Cell的LayoutAttributes,并存放到 cellLayoutAttributes 里面
        for i in 0 ..< loadCellCount {
            // 获取Cell的位置
            let indexPath = IndexPath(row: i, section: 0)
            // 获取Cell的LayoutAttributes
            if let cellAttribute = self.layoutAttributesForItem(at: indexPath){
                // 将获取的 cellAttribute 添加到 cellLayoutAttributes
                cellLayoutAttributes.append(cellAttribute)
            }
        }
        
    }
    
    // MARK: 设置Cell的位置
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        // 获取Cell的宽度
        let cellWidth = ((self.collectionView?.bounds.width)! - LineSpacing * CGFloat(WatefallColumns - 1)-self.sectionInset.left - self.sectionInset.right) / CGFloat(WatefallColumns)
        // 获取Cell的高度
        let cellHight = delegate?.waterFlowLayout(waterFlowLayout: self, indexPath: indexPath ,width: cellWidth);
        // 默认cellColumnsHeights的第一个对象是高度最低的Cell
        var minColumnsCellHeight = cellColumnsHeights.first ?? 0
        // 标记第几列是Cell 最低列
        var minColumnCellMark = 0
        // 遍历每一列的Cell高度，获取得到最小的一个
        for i in 0 ..< WatefallColumns {
            let tempCellHeight = cellColumnsHeights[i]
            if minColumnsCellHeight > tempCellHeight {
                minColumnsCellHeight = tempCellHeight
                minColumnCellMark = i
            }
        }
        // 最低Cell的X轴的位置
        let minCellHeightX =  CGFloat(minColumnCellMark) * (cellWidth + ColumnsSpacing) + self.sectionInset.left
        // 最低Cell的Y轴的位置
        var cellHeightY = minColumnsCellHeight
        if cellHeightY != self.sectionInset.top {
             cellHeightY += LineSpacing
        }
        // 设置大小
        let LayoutAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        LayoutAttribute.frame = CGRect(x: minCellHeightX, y: cellHeightY, width: cellWidth, height: cellHight!)
        // 设置Cell 高度中，最低的Y轴位置
        cellColumnsHeights[minColumnCellMark] = LayoutAttribute.frame.maxY
        // 获取Cell高度数组最小的一个
        let minCellHeightY = cellColumnsHeights[minColumnCellMark]
        if contentHeight < minCellHeightY {
            contentHeight = minCellHeightY
        }
        return LayoutAttribute
    }
    
    // MARK: 返回样式
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        cellLayoutAttributes
    }
    
    // MARK: 设置Cell可滑动的范围。注意:swift3.0废弃了上面这个方法，所以我们改成重写collectionViewContentSize属性
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: (self.collectionView?.frame.width)!, height: self.maxH(cellHeight: cellColumnsHeights))
        }
    }
    
    // MARK: 获取Cell的高度
    func maxH(cellHeight:[CGFloat]) -> CGFloat {
        var max = cellHeight.first ?? 0
        for i in 0 ..< cellHeight.count {
            if max < cellHeight[i] {
                max = cellHeight[i]
            }
        }
        return max + self.sectionInset.bottom
    }

}

// 创建代理
protocol WaterfallViewFlowLayoutDelegate: NSObjectProtocol {
    // 获取内容的高度
    func waterFlowLayout(waterFlowLayout:WaterfallViewFlowLayout,indexPath: IndexPath,width:CGFloat) -> CGFloat ;
}


let myCellID = "myCellID"
class MyCell:UICollectionViewCell{

    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.numberOfLines = 0
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(8)
            make.right.bottom.equalToSuperview().offset(-8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
