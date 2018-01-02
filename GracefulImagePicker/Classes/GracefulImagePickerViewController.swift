//
//  GracefulImagePickerViewController.swift
//  GracefulImagePicker
//
//  Created by marspro on 2017/12/30.
//

import UIKit

public class GracefulImagePickerViewController: UIViewController {

    var imagePickerView: GracefulImagePickerView?
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()

        let imagePickerView = GracefulImagePickerView(frame: CGRect.zero)
        self.view.addSubview(imagePickerView)
        
        self.imagePickerView = imagePickerView
        
    }
    
    public override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        self.imagePickerView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
