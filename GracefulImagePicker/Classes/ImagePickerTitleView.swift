//
//  ImagePickerTitleView.swift
//  Pods
//
//  Created by marspro on 2017/12/29.
//

import UIKit

public enum ImagePickerStyle: Int {
    
    case White = 1
    case Black = 2
    
}

public class ImagePickerTitleView: UIView {

    public var titleLabel: UILabel?
    public var btnBack: UIButton?
    
    var backClicked: (() -> Void)?
    
    init(frame: CGRect, style: ImagePickerStyle) {
        
        super.init(frame: frame)
        
        
        
        let titleLabel = UILabel(frame: CGRect.zero)
        
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        let btnBack = UIButton(frame: CGRect.zero)
        let frameworkBundle = Bundle(for: ImagePickerTitleView.self)
        
        if(style == ImagePickerStyle.Black) {
            
            self.backgroundColor = UIColor.black
            btnBack.setImage(UIImage(named: "picker_back", in: frameworkBundle, compatibleWith: nil), for: UIControlState.normal)
            titleLabel.textColor = UIColor.white
            
        } else {
        
            self.backgroundColor = UIColor.white
            btnBack.setImage(UIImage(named: "picker_back_blk", in: frameworkBundle, compatibleWith: nil), for: UIControlState.normal)
            titleLabel.textColor = UIColor.black
            
        }
        
        
        btnBack.addTarget(self, action: #selector(self.btnBackClicked), for: UIControlEvents.touchUpInside)
        
        self.addSubview(btnBack)
        
        self.btnBack = btnBack
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    public override func layoutSubviews() {
        
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
