//
//  EmptyAlbumView.swift
//  GracefulImagePicker
//
//  Created by marspro on 2018/11/28.
//

import UIKit

class EmptyAlbumView: UIView {

    var imageTitle: UIImageView?
    
    var labelTitle: UILabel?
    var labelMessage: UILabel?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        let imageTitle = UIImageView(frame: CGRect.zero)
        self.imageTitle = imageTitle
        
        imageTitle.image = ImageLoader.image(named: "perm_title")
        self.addSubview(imageTitle)
        
        let labelTitle = UILabel(frame: CGRect.zero)
        labelTitle.text = "相册中没有照片"
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont.boldSystemFont(ofSize: 20)
        labelTitle.textColor = UIColor.gray
        self.labelTitle = labelTitle
        self.addSubview(labelTitle)
        
        let labelMessage = UILabel(frame: CGRect.zero)
        labelMessage.text = "请添加照片后再使用"
        labelMessage.textColor = UIColor.gray
        labelMessage.numberOfLines = 2
        labelMessage.textAlignment = .center
        self.labelMessage = labelMessage
        self.addSubview(labelMessage)
        
        
        
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
        
        
    }
    
    @objc func confirmClicked() {
        
        if let url = URL(string: UIApplicationOpenSettingsURLString) {
            
            UIApplication.shared.openURL(url)
            
        }
        
    }

}
