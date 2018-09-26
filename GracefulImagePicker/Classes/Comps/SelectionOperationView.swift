//
//  SelectionOperationView.swift
//  CircleProgressBar
//
//  Created by Spring on 2018/9/23.
//

import UIKit

class SelectionOperationView: UIView {

    var titleLabel: UILabel?
    var btnConfirm: UIButton?
    var btnCancel: UIButton?
    
    var confirmClicked: (() -> Void)?
    var cancelClicked: (() -> Void)?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 83.0 / 255.0, green: 148.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
        
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.text = "已选中"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        let btnCancel = UIButton(frame: CGRect.zero)
        btnCancel.setTitle("取消", for: .normal)
        btnCancel.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btnCancel.addTarget(self, action: #selector(self.btnCancelClicked), for: .touchUpInside)
        self.addSubview(btnCancel)
        
        self.btnCancel = btnCancel
        
        let btnConfirm = UIButton(frame: CGRect.zero)
        btnConfirm.setTitle("确定", for: .normal)
        btnConfirm.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btnConfirm.addTarget(self, action: #selector(self.btnConfirmClicked), for: .touchUpInside)
        self.addSubview(btnConfirm)
        self.btnConfirm = btnConfirm
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.titleLabel?.frame = CGRect(x: 12, y: 0, width: 200, height: self.frame.size.height)
        self.btnCancel?.frame = CGRect(x: self.frame.size.width - 115, y: 0, width: 50, height: self.frame.size.height)
        self.btnConfirm?.frame = CGRect(x: self.frame.size.width - 60, y: 0, width: 50, height: self.frame.size.height)
        
    }
    
    @objc func btnConfirmClicked() {
        
        self.confirmClicked?()
        
    }
    
    @objc func btnCancelClicked() {
        
        self.cancelClicked?()
        
    }
    
}
