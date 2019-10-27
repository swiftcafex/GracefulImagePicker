//
//  NavigationViewController.swift
//  GracefulImagePicker_Example
//
//  Created by marspro on 2018/8/4.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override public var childForStatusBarStyle: UIViewController? {
        
        return visibleViewController
        
    }
    

}
