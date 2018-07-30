//
//  GracefulImagePickerViewController.swift
//  GracefulImagePicker
//
//  Created by marspro on 2017/12/30.
//

import UIKit
import Photos

public class GracefulImagePickerViewController: UIViewController {

    public var imagePickerView: GracefulImagePickerView?
    var config: ImagePickerConfiguration?
    public var imageSelected: ((UIImage,PHAsset) -> Void)?
    
    public init(config: ImagePickerConfiguration) {
        
        super.init(nibName: nil, bundle: nil)
        self.config = config
       
    }
    
    public init() {
    
        super.init(nibName: nil, bundle: nil)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        
        
        if let config = self.config {
        
            self.imagePickerView = GracefulImagePickerView(frame: CGRect.zero, config: config)
            
        } else {
            
            self.imagePickerView = GracefulImagePickerView(frame: CGRect.zero)
            
        }
        
        self.view.addSubview(self.imagePickerView!)
        
        self.imagePickerView?.backClicked = {
            
            self.navigationController?.popViewController(animated: true)
            
        }
        
        self.imagePickerView?.imageSelected = { image, asset in
            
            self.imageSelected?(image, asset)
            
        }
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    public override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        self.imagePickerView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override var prefersStatusBarHidden: Bool {
        
        return true
        
    }

}
