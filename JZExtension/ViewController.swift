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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.jz.setSelf ()
        .register(MyCell.self,forCellReuseIdentifier: myCellID)
        .didSelectRow { tableView, indexPath in
            let cell = tableView.cellForRow(at: indexPath) as! MyCell
            print(cell.label.text!)
            cell.label.text = "selected" + "\(cell.i)"
        }
        .numberOfSections{ _ in
            2
        }
        .numberOfRowsInSection { _, _ in
            5
        }
        .cellForRow { tableView, indexPath in
           let cell = tableView.dequeueReusableCell(withIdentifier: myCellID) as! MyCell
            cell.label.text = "cell \(indexPath.row)"
            cell.i = indexPath.row
            return cell
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.snp.edges)
        }
        
        // Do any additional setup after loading the view.
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