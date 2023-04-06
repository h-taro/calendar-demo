//
//  UpdateCSVViewController.swift
//  CalendarDemo
//
//  Created by taro.hiraishi on 2023/04/06.
//

import UIKit
import SnapKit

class UpdateCSVViewController: UIViewController {
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray.cgColor
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white

        view.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(320)
        }
    }
}
