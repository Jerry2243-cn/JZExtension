//
//  ViewController1.swift
//  JZExtension
//
//  Created by Jerry Zhu on 2023/9/27.
//

import UIKit

class ViewController1: UIViewController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        label.jz.onTapGesture { _ in
            self.dismiss(animated: true)
        }
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
}
