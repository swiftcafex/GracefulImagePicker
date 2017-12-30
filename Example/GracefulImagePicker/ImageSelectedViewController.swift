//
//  ImageSelectedViewController.swift
//  GracefulImagePicker_Example
//
//  Created by marspro on 2017/12/30.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class ImageSelectedViewController: UIViewController {

    var imageView: UIImageView?
    var image: UIImage?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.image = self.image
        self.view.addSubview(imageView)
        
        self.imageView = imageView
        
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        self.imageView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
