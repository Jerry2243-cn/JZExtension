//
//  WaterfallViewFlowLayout.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/28.
//

import UIKit

// 创建代理
protocol WaterfallViewFlowLayoutDelegate: NSObjectProtocol {
    // 获取内容的高度
    func waterFlowLayout(waterFlowLayout:WaterfallViewFlowLayout,indexPath: IndexPath,width:CGFloat) -> CGFloat ;
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
    private var cellLayoutAttributes : [UICollectionViewLayoutAttributes] = []
    // 创建存放Cell 所在列的高度
    private var cellColumnsHeights : [CGFloat] = []
    // cell 内容的高度
    private var contentHeight:CGFloat = 0
    
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
