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
    
    var activityIndicator : UIActivityIndicatorView?
    var labelProcess: UILabel?
    
    var confirmClicked: (() -> Void)?
    var cancelClicked: (() -> Void)?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 83.0 / 255.0, green: 148.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
        
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.text = "已选中"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .left
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
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        indicator.isHidden = true
        
        self.addSubview(indicator)
        
        self.activityIndicator = indicator
        
        let labelProcess = UILabel(frame: CGRect.zero)
        labelProcess.isHidden = true
        labelProcess.font = UIFont.systemFont(ofSize: 15)
        labelProcess.textColor = UIColor.white
        labelProcess.text = "正在处理..."
        self.addSubview(labelProcess)
        
        self.labelProcess = labelProcess
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.titleLabel?.frame = CGRect(x: 12, y: 0, width: 200, height: self.frame.size.height)
        self.btnCancel?.frame = CGRect(x: self.frame.size.width - 115, y: 0, width: 50, height: self.frame.size.height)
        self.btnConfirm?.frame = CGRect(x: self.frame.size.width - 60, y: 0, width: 50, height: self.frame.size.height)
        
        self.activityIndicator?.frame = CGRect(x: self.frame.size.width - 140, y: self.frame.size.height / 2 - 15, width: 30, height: 30)
        self.labelProcess?.frame = CGRect(x: self.frame.size.width - 105, y: 0, width: 90, height: self.frame.size.height)
        
    }
    
    @objc func btnConfirmClicked() {
        
        self.stateLoadling()
        self.confirmClicked?()
        
    }
    
    @objc func btnCancelClicked() {
        
        self.cancelClicked?()
        
    }
    
    // Loading UI
    func stateLoadling() {
        
        self.btnConfirm?.isHidden = true
        self.btnCancel?.isHidden = true
        
        
        self.activityIndicator?.startAnimating()
        self.activityIndicator?.isHidden = false
        self.labelProcess?.isHidden = false
        
    }
    
    // Normal UI
    func stateNormal() {
        
        self.btnConfirm?.isHidden = false
        self.btnCancel?.isHidden = false
        self.activityIndicator?.stopAnimating()
        self.activityIndicator?.isHidden = true
        self.labelProcess?.isHidden = true
        
    }
    
    func flashTitleLabel() {
        
        UIView.animate(withDuration: 0.1, animations: {
            
            self.titleLabel?.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 15)
            
        }) { (success) in
            
            UIView.animate(withDuration: 0.1, animations: {
            
                self.titleLabel?.transform = CGAffineTransform.identity
                
            })
            
        }
        
    }
    
}
