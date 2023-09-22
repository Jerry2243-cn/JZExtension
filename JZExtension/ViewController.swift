//
//  ViewController.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let tableView = UITableView()
    let tableView1 = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.jz
        .register(MyCell.self,forCellReuseIdentifier: myCellID)
        .didSelectRowAt { [unowned self] indexPath in
            let cell = tableView.cellForRow(at: indexPath) as! MyCell
            print(cell.label.text!)
            cell.label.text = "selected " + "\(cell.i)"
        }
        .numberOfRowsInSection { _ in
            5
        }
        .cellForRowAt { [unowned self] indexPath in
           let cell = tableView.dequeueReusableCell(withIdentifier: myCellID) as! MyCell
            cell.label.text = "cell \(indexPath.row)"
            cell.i = indexPath.row
            return cell
        }
        .scrollViewDidScroll { [unowned self] in
            print(tableView.bounds.maxY)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.top.right.equalTo(view)
            make.bottom.equalTo(view.snp.centerY)
        }

        tableView1.jz.setSelf{ tableView in
            tableView.backgroundColor = .lightGray
        }
        .register(MyCell.self,forCellReuseIdentifier: myCellID)
        .didSelectRowAt { [unowned self] indexPath in
            let cell = tableView.cellForRow(at: indexPath) as! MyCell
            print(cell.label.text!)
            cell.label.text = "selected1 " + "\(cell.i)"
        }
        .numberOfSections{
            1
        }
        .numberOfRowsInSection { _ in
            2
        }
        .cellForRowAt { [unowned self] indexPath in
           let cell = tableView.dequeueReusableCell(withIdentifier: myCellID) as! MyCell
            cell.label.text = "cell1 \(indexPath.row)"
            cell.i = indexPath.row
            return cell
        }
        view.addSubview(tableView1)
        tableView1.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(view)
            make.top.equalTo(view.snp.centerY)
        }
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


}


let myCellID = "myCellID"
class MyCell:UITableViewCell{
    var i = 0
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        label.text = "I am a cell"
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
