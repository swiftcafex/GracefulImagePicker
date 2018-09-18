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
    
    // 1. Present white style view
    func presentWhiteStyle() {
        
        let picker = PickerContanerViewController()
        let nav = UINavigationController(rootViewController: picker)
        nav.navigationBar.isHidden = true
        self.present(nav, animated: true, completion: nil)
        
    }
    
    // 2. Present Black stlye View
    func presentBlackStyle() {
        
        let picker = PickerContanerViewController()
        let config = ImagePickerConfiguration()
        config.style = .Black
        picker.pickerConfig = config
        picker.view.backgroundColor = UIColor.black
        let nav = CustomableNavigationController(rootViewController: picker)
        nav.statusBarStyle = .lightContent
        nav.navigationBar.isHidden = true
        self.present(nav, animated: true, completion: nil)

    }
    
    // 3. Push White Style View
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
