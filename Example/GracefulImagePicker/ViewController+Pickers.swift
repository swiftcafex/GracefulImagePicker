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

extension ViewController {
    
    func presentWhiteStyle() {
        
        let picker = PickerContanerViewController()
        let nav = UINavigationController(rootViewController: picker)
        self.present(nav, animated: true, completion: nil)
        
    }
    
    func presentBlackStyle() {
        
        let picker = PickerContanerViewController()
        let config = ImagePickerConfiguration()
        config.style = .Black
        picker.pickerConfig = config
        let nav = UINavigationController(rootViewController: picker)
        self.present(nav, animated: true, completion: nil)

        
    }
    
    func pushWhiteStyle() {
        
        let pickerController = GracefulImagePickerViewController()
        pickerController.imageSelected = { image, asset in
            
            let resultView = ImageSelectedViewController()
            resultView.image = image
            self.navigationController?.pushViewController(resultView, animated: true)
            
        }
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(pickerController, animated: true)

        
    }
    
    func pushBlackStyle() {
        
        let config = ImagePickerConfiguration()
        config.style = .Black
        
        let pickerController = GracefulImagePickerViewController(config: config)
        pickerController.imageSelected = { image, asset in
            
            let resultView = ImageSelectedViewController()
            resultView.image = image
            self.navigationController?.pushViewController(resultView, animated: true)
            
        }
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(pickerController, animated: true)

    }
    
}
