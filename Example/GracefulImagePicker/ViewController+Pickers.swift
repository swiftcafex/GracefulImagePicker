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
    
    func presentWhiteStyle() {
        
        let pickerVC = GracefulImagePickerViewController()
        self.present(pickerVC, animated: true, completion: nil)
        
    }
    
    func presentBlackStyle() {
        
        let config = ImagePickerConfiguration()
        config.style = .Black
        let pickerVC = GracefulImagePickerViewController(config: config)
        self.present(pickerVC, animated: true, completion: nil)
        
    }
    
    func pushWhiteStyle() {
        
        let pickerVC = GracefulImagePickerViewController()
        self.navigationController?.pushViewController(pickerVC, animated: true)
        pickerVC.imageSelected = self.imageSelected

        
    }
    
    func pushBlackStyle() {
        
        let config = ImagePickerConfiguration()
        config.style = .Black
        
        let pickerVC = GracefulImagePickerViewController(config: config)
        pickerVC.imageSelected = self.imageSelected
        self.navigationController?.pushViewController(pickerVC, animated: true)
        

    }
    
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
    
}
