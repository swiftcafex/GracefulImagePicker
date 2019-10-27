//
//  GracefulImagePickerViewController.swift
//  GracefulImagePicker
//
//  Created by marspro on 2017/12/30.
//

import UIKit
import Photos

open class GracefulImagePickerViewController: UIViewController {

    public var imagePickerView: GracefulImagePickerView?
    
    var config: ImagePickerConfiguration?
    
    public var imageSelected: ((UIImage,PHAsset) -> Void)?
    public var multipleImageSelected: (([UIImage]) -> Void)?
    
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
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isHidden = true
        
        if let config = self.config {
        
            self.imagePickerView = GracefulImagePickerView(frame: CGRect.zero, config: config)
            
        } else {
            
            self.imagePickerView = GracefulImagePickerView(frame: CGRect.zero)
            
        }
        
        self.view.addSubview(self.imagePickerView!)
        
        self.imagePickerView?.backClicked = {
            
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
            
        }
        
        self.imagePickerView?.imageSelected = { image, asset in
            
            self.imageSelected?(image, asset)
            
        }
        
        self.imagePickerView?.multipleImageSelected = { image in
            
            self.multipleImageSelected?(image)
            
        }
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.setNeedsStatusBarAppearanceUpdate()
        self.imagePickerView?.reload()
        
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    open override func viewWillLayoutSubviews() {
        
        
        super.viewWillLayoutSubviews()
        print("layout view controller")
//        var top = CGFloat(20)
//        
//        if #available(iOS 11.0, *) {
//            
//            top = self.view.safeAreaInsets.top
//            
//        }
//        
        self.imagePickerView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
    }

    open override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()
        
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        
        if let statusStyle = self.config?.statusStyle {
            
            return statusStyle
            
        } else if let style = self.config?.style {
            
            if style == .Black {
                
                return .lightContent
                
            } else if style == .White {
                
                return .default
                
            }
            
        }
        
        return .default
        
    }
    

}
