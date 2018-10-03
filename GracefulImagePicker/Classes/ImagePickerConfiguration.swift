//
//  ImagePickerConfiguration.swift
//  Pods
//
//  Created by marspro on 2018/1/2.
//

import UIKit

public class ImagePickerConfiguration: NSObject {

    public var reverseImageList = false             // load image in reverse order

    public var style = ImagePickerStyle.White       // UI color style

    // Optional
    public var statusStyle: UIStatusBarStyle?   // specify status bar style
    public var titleBackground: UIColor?        // title view backgroud color

    public var mutipleSelection = false         // Multiple selection model
    public var mutipleSelectionMaxLimit = 10    // select max limit
    
    //    public var scrollToBottom = false               // auto scroll to list bottom when loaded
}
