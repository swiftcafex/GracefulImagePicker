//
//  RequestPermissionView.swift
//  GracefulImagePicker
//
//  Created by marspro on 2018/11/23.
//

import UIKit

class RequestPermissionView: UIView {

    var imageTitle: UIImageView?
    
    var labelTitle: UILabel?
    var labelMessage: UILabel?
    
    var btnConfirm : UIButton?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        let imageTitle = UIImageView(frame: CGRect.zero)
        self.imageTitle = imageTitle
        
        imageTitle.image = ImageLoader.image(named: "perm_title")
        self.addSubview(imageTitle)
        
        
        let labelTitle = UILabel(frame: CGRect.zero)
        labelTitle.text = "需要照片访问权限"
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont.boldSystemFont(ofSize: 20)
        labelTitle.textColor = UIColor.gray
        self.labelTitle = labelTitle
        self.addSubview(labelTitle)
        
        
        let labelMessage = UILabel(frame: CGRect.zero)
        labelMessage.text = "打开系统相册访问权限，用于图片编辑。"
        labelMessage.textColor = UIColor.gray
        labelMessage.numberOfLines = 2
        labelMessage.textAlignment = .center
        self.labelMessage = labelMessage
        self.addSubview(labelMessage)
        
        
        let btnConfirm = UIButton(frame: CGRect.zero)
        btnConfirm.setTitle("获取权限", for: .normal)
        btnConfirm.setTitleColor(UIColor.white, for: .normal)
        btnConfirm.layer.cornerRadius = 6
        btnConfirm.addTarget(self, action: #selector(self.confirmClicked), for: .touchUpInside)
        btnConfirm.backgroundColor = UIColor(red: 43.0 / 255.0, green: 194.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
        self.addSubview(btnConfirm)
        self.btnConfirm = btnConfirm
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.imageTitle?.frame = CGRect(x: 0, y: 0, width: 120, height: 100)
        self.imageTitle?.center = CGPoint(x: self.frame.size.width / 2, y: 160)
        
        self.labelTitle?.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        self.labelTitle?.center = CGPoint(x: self.frame.size.width / 2, y: 300)
        
        self.labelMessage?.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        self.labelMessage?.center = CGPoint(x: self.frame.size.width / 2, y: 350)
        
        self.btnConfirm?.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        self.btnConfirm?.center = CGPoint(x: self.frame.size.width / 2, y: 420)
        
    }
    
    @objc func confirmClicked() {        
        
        if let url = URL(string: UIApplicationOpenSettingsURLString) {

            UIApplication.shared.openURL(url)
            
        }
        
    }

}
