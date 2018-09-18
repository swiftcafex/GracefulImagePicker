//
//  CustomableNavigationController.swift
//  GracefulImagePicker_Example
//
//  Created by Spring on 2018/9/4.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class CustomableNavigationController: UINavigationController {

    var statusBarStyle = UIStatusBarStyle.default
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return statusBarStyle
        
    }
    
}
