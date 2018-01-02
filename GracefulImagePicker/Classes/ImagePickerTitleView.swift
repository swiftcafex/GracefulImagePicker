//
//  ImagePickerTitleView.swift
//  Pods
//
//  Created by marspro on 2017/12/29.
//

import UIKit
import CoreGraphics

// picker color style
public enum ImagePickerStyle: Int {
    
    case White = 1
    case Black = 2
    
}

class ImagePickerTitleView: UIView {

    public var titleLabel: UILabel?     // album title label
    public var btnBack: UIButton?       // go back button
    
    var btnAlbum: UIButton?             // album open button
    
    var imageOpenAlbum : String?        // open button image name
    var imageCloseAlbum : String?       // close button image name
    
    var albumOpened = false             // button state
    
    var backClicked: (() -> Void)?              // callback for go back button
    var callbackOpenAlbum : (() -> Void)?       // callback for open album
    var callbackCloseAlbum : (() -> Void)?      // callback for close album
    
    init(frame: CGRect, style: ImagePickerStyle) {
        
        super.init(frame: frame)
        
        // shadow effect
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        // init title view
        let titleTap = UITapGestureRecognizer(target: self, action: #selector(self.albumOpenClicked))
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(titleTap)
        
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        // init gobcck button
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
        
        // init album button
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
        
        if let titleLabel = self.titleLabel {
        
            if let labelText = self.titleLabel?.text {
                
                let size = (labelText as NSString).size(withAttributes: [NSAttributedStringKey.font: titleLabel.font])
                titleLabel.frame = CGRect(x: 0, y: 0, width: size.width, height: 30)
                titleLabel.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
                
            }
        
            if titleLabel.text != nil {
             
                self.btnAlbum?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                self.btnAlbum?.center = CGPoint(x: titleLabel.frame.origin.x + titleLabel.frame.size.width + 20, y: self.frame.size.height / 2)
                
            }
            
        }
        
        if let btnBack = self.btnBack {
        
            btnBack.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            btnBack.center = CGPoint(x: btnBack.frame.size.width / 2 + 8, y: self.frame.size.height / 2)
            
        }
        
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
    
    // MARK: change album button state
    
    // to open
    func changeToOpen() {
     
        self.albumOpened = false
        self.btnAlbum?.setImage(ImageLoader.image(named: self.imageOpenAlbum!), for: .normal)
        
    }
    
    // to close
    func changeToHide() {
        
        self.albumOpened = true
        btnAlbum?.setImage(ImageLoader.image(named: self.imageCloseAlbum!), for: .normal)
        
    }
    
}
