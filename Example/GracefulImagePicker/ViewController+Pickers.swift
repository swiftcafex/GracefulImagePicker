//
//  ViewController+Pickers.swift
//  GracefulImagePicker_Example
//
//  Created by marspro on 2018/7/30.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import GracefulImagePicker
import Photos

extension ViewController {
    
    
    func imageSelected(image: UIImage, asset: PHAsset) {
     
        let resultView = ImageSelectedViewController()
        resultView.image = image
        self.navigationController?.pushViewController(resultView, animated: true)
        
    }
    
    // 1-1 Present White Style View
    func presentWhiteStyle() {
        
        let pickerVC = GracefulImagePickerViewController()
        pickerVC.modalPresentationStyle = .fullScreen
        self.present(pickerVC, animated: true, completion: nil)
        
    }
    
    // 1-2 Present Black stlye View
    func presentBlackStyle() {
        
        let config = ImagePickerConfiguration()
        config.style = .Black
        let pickerVC = GracefulImagePickerViewController(config: config)
        pickerVC.modalPresentationStyle = .fullScreen
        self.present(pickerVC, animated: true, completion: nil)
        
    }
    
    // 2-1 Push White Style View
    func pushWhiteStyle() {
        
        let pickerVC = GracefulImagePickerViewController()
        self.navigationController?.pushViewController(pickerVC, animated: true)
        pickerVC.imageSelected = self.imageSelected

        
    }
    
    // 2-2 Push Black Style View
    func pushBlackStyle() {
        
        let config = ImagePickerConfiguration()
        config.style = .Black
        
        let pickerVC = GracefulImagePickerViewController(config: config)
        pickerVC.imageSelected = self.imageSelected
        self.navigationController?.pushViewController(pickerVC, animated: true)
        

    }
    
    // 2-3 Push Custom Style
    func pushCustomStyle() {
        
        let config = ImagePickerConfiguration()
        config.statusStyle = UIStatusBarStyle.lightContent
        config.titleBackground = UIColor.darkGray
        config.style = .Black
        config.reverseImageList = true
        
        let pickerVC = GracefulImagePickerViewController(config: config)
        pickerVC.imageSelected = self.imageSelected
        self.navigationController?.pushViewController(pickerVC, animated: true)
        
    }
    
    
    // 3-1 Push Mutiple Selection
    func pushMutipleSelection() {
        
        let config = ImagePickerConfiguration()
        config.mutipleSelection = true
        
        let pickerVC = GracefulImagePickerViewController(config: config)
        pickerVC.multipleImageSelected = { images in
            
            print("image selected: \(images.count)")
            
        }
        pickerVC.imagePickerView?.titleView?.btnBack?.isHidden = true
        
        
        self.navigationController?.pushViewController(pickerVC, animated: true)
        
    }
    
}
