//
//  ImagePickerTitleView.swift
//  Pods
//
//  Created by marspro on 2017/12/29.
//

import UIKit
import CoreGraphics

public enum ImagePickerStyle: Int {
    
    case White = 1
    case Black = 2
    
}

public class ImagePickerTitleView: UIView {

    public var titleLabel: UILabel?
    public var btnBack: UIButton?
    
    var btnAlbum: UIButton?
    var imageOpenAlbum : String?
    var imageCloseAlbum : String?
    
    var backClicked: (() -> Void)?
    
    var albumOpened = false
    
    var callbackOpenAlbum : (() -> Void)?
    var callbackCloseAlbum : (() -> Void)?
    
    init(frame: CGRect, style: ImagePickerStyle) {
        
        super.init(frame: frame)
        
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        let titleTap = UITapGestureRecognizer(target: self, action: #selector(self.albumOpenClicked))
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(titleTap)
        
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        let btnBack = UIButton(frame: CGRect.zero)
        
        if(style == ImagePickerStyle.Black) {
            
            self.backgroundColor = UIColor.black
            
            btnBack.setImage(ImageLoader.image(named: "picker_back"), for: UIControlState.normal)
            titleLabel.textColor = UIColor.white
            
        } else {
        
            
            self.backgroundColor = UIColor.white
            btnBack.setImage(ImageLoader.image(named: "picker_back_blk"), for: UIControlState.normal)
            titleLabel.textColor = UIColor.black
            
        }
        
        
        btnBack.addTarget(self, action: #selector(self.btnBackClicked), for: UIControlEvents.touchUpInside)
        
        self.addSubview(btnBack)
        
        self.btnBack = btnBack
        
        if(style == ImagePickerStyle.Black) {
            
            self.imageOpenAlbum = "btn_open_album"
            self.imageCloseAlbum = "btn_close_album"
            
        } else {
            
            self.imageOpenAlbum = "btn_open_album_blk"
            self.imageCloseAlbum = "btn_close_album_blk"
            
        }
        
        let btnAlbum = UIButton(frame: CGRect.zero)
        btnAlbum.setImage(ImageLoader.image(named: self.imageOpenAlbum!), for: .normal)
        btnAlbum.addTarget(self, action: #selector(self.albumOpenClicked), for: UIControlEvents.touchUpInside)
        self.addSubview(btnAlbum)
        
        self.btnAlbum = btnAlbum
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        self.titleLabel?.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        self.titleLabel?.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
        self.btnAlbum?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.btnAlbum?.center = CGPoint(x: self.titleLabel!.frame.origin.x + self.titleLabel!.frame.size.width, y: self.frame.size.height / 2)
        
        self.btnBack?.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        self.btnBack?.center = CGPoint(x: self.btnBack!.frame.size.width / 2 + 8, y: self.frame.size.height / 2)
        
        
    }
    
    @objc func btnBackClicked() {
        
        self.backClicked?()
        
    }
    
    @objc func albumOpenClicked() {
        
        if self.albumOpened {
            
            //teue
            changeToOpen()
            self.callbackCloseAlbum?()
            
        } else {
            
            // false
            changeToHide()
            self.callbackOpenAlbum?()
            
        }
        
    }
    
    func changeToOpen() {
     
        self.albumOpened = false
        self.btnAlbum?.setImage(ImageLoader.image(named: self.imageOpenAlbum!), for: .normal)
        
    }
    
    func changeToHide() {
        
        self.albumOpened = true
        btnAlbum?.setImage(ImageLoader.image(named: self.imageCloseAlbum!), for: .normal)
        
    }
    
}
