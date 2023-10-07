//
//  ViewController.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController, WaterfallViewFlowLayoutDelegate {
    
    var data = ["sdvsv","ewrfweefer","sacascds","adcdacsdcasdc","dcds",",gdvdfgdfgdgdfhfhfthertghdfghgfgfgrgergerthbfgnfgnfgjhjntyhndfgndfghnghnfghnfghnf","svdfvdsf","fdvgdfgd","sdfgfddf","drgbdbfdgb","dtbgfgbtdft","dtbgfdbtfg","tgdtgd","541d5t4b15d4t1bg5df","dsrgver","ytukmuiyim","4bf5t4bg1f5tbg4","5r4fbgt5fbf4db","bfg4b4fb4ftb","dfgbfdgbrf"]
    
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        
    }
    
    func setup(){
//        let tableView = JZTableViewFactory.create(cell: MyCell.self, cellModel: String.self)
//        tableView.updateDataSource(with: data)
//        tableView.onCellSelected { _, indexPath in
//            print(indexPath)
//            self.data.remove(at: indexPath.row)
//            tableView.updateDataSource(with: self.data)
//        }
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.edges.equalTo(view)
//        }
        
        let textField1 = UITextField()
        textField1.jz.setLimit(count: 10, acceptCharSet: .custom("./?")).setSelf { tf in
            tf.placeholder = "acss"
        }
        let textField2 = UITextField()
        textField2.jz.setLimit(count: 6, acceptCharSet: [.digits, .custom("abc<>?")]).setSelf { tf in
            tf.placeholder = "acss"
        }
        view.addSubview(textField1)
        view.addSubview(textField2)
        textField1.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp.centerY).offset(-10)
        }
        textField2.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp.centerY).offset(10)
        }
    }
    
//    func setup() {
//        let flowLayout = WaterfallViewFlowLayout()
//        flowLayout.jz.setSelf { layout in
//            layout.WatefallColumns = 2
//            layout.delegate = self
//            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//            layout.scrollDirection = .vertical
//        }
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        collectionView.jz.setSelf { collectionView in
//            collectionView.backgroundColor = .white
//            collectionView.contentInsetAdjustmentBehavior = .never
//            collectionView .register(MyCell.self, forCellWithReuseIdentifier: myCellID)
//        }
//        .register(MyCell.self, forCellReuseIdentifier: myCellID)
//        .cellForItemAt { [unowned self] indexPath in
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myCellID, for: indexPath) as! MyCell
//            cell.label.text = data[indexPath.item]
//            cell.tag = indexPath.item + 1
//            cell.contentView.backgroundColor = .gray
//            return cell
//        }
//        .numberOfItemsInSection { [unowned self] _ in
//            data.count
//        }
//        .didSelectItemAt { [unowned self] indexPath in
//            let cell = collectionView.cellForItem(at: indexPath) as! MyCell
//            let vc = ViewController1()
//            vc.view.tag = indexPath.item + 1
//            vc.view.backgroundColor = cell.contentView.backgroundColor
//            vc.label.text = cell.label.text
//            vc.transitioningDelegate = self
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true)
//        }
//        
//        self.view.addSubview(collectionView)
//        collectionView.snp.makeConstraints { make in
//            make.edges.equalTo(view)
//        }
//    }
}

class MyCell:UITableViewCell,JZTableViewCellConfigure{
   
    typealias CellModelType = String
    func configureDataWithModel(_ model: String, at indexPath: IndexPath) {
        label.text = model
    }
    
    
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label.numberOfLines = 0
//        label.textAlignment = .center
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
