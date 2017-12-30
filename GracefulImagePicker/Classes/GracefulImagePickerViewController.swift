//
//  GracefulImagePickerViewController.swift
//  GracefulImagePicker
//
//  Created by marspro on 2017/12/30.
//

import UIKit

class GracefulImagePickerViewController: UIViewController {

    var imagePickerView: GracefulImagePickerView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let imagePickerView = GracefulImagePickerView(frame: CGRect.zero)
        self.view.addSubview(imagePickerView)
        
        self.imagePickerView = imagePickerView
        
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        self.imagePickerView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
