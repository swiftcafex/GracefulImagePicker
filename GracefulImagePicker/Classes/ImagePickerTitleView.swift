//
//  ImagePickerTitleView.swift
//  Pods
//
//  Created by marspro on 2017/12/29.
//

import UIKit

class ImagePickerTitleView: UIView {

    var titleLabel: UILabel?
    var btnBack: UIButton?
    
    var backClicked: (() -> Void)?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black
        
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.textColor = UIColor.white
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        let btnBack = UIButton(frame: CGRect.zero)
        let frameworkBundle = Bundle(for: ImagePickerTitleView.self)
        btnBack.setImage(UIImage(named: "picker_back", in: frameworkBundle, compatibleWith: nil), for: UIControlState.normal)
        btnBack.addTarget(self, action: #selector(self.btnBackClicked), for: UIControlEvents.touchUpInside)
        
        self.addSubview(btnBack)
        
        self.btnBack = btnBack
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.titleLabel?.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        self.titleLabel?.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
        self.btnBack?.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        self.btnBack?.center = CGPoint(x: self.btnBack!.frame.size.width / 2 + 8, y: self.frame.size.height / 2)
        
    }
    
    @objc func btnBackClicked() {
        
        self.backClicked?()
        
    }
    
}
