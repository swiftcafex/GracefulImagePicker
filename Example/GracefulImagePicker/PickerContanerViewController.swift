//
//  PickerContanerViewController.swift
//  GracefulImagePicker_Example
//
//  Created by marspro on 2017/12/28.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import GracefulImagePicker

class PickerContanerViewController: UIViewController {

    var imagePickerView : GracefulImagePickerView?
    var pickerConfig: ImagePickerConfiguration?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        var pickerView: GracefulImagePickerView?
        
        if let config = self.pickerConfig {
        
            pickerView = GracefulImagePickerView(frame: CGRect.zero, config: config)
            
        } else {
            
            pickerView = GracefulImagePickerView(frame: CGRect.zero)
            
        }
        
        
        pickerView?.backClicked = {
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        pickerView?.imageSelected = { image, asset in
            
            let resultView = ImageSelectedViewController()
            resultView.image = image
            self.navigationController?.pushViewController(resultView, animated: true)
            
        }
        self.view.addSubview(pickerView!)
        self.imagePickerView = pickerView
        
        self.navigationController?.navigationBar.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        var top = UIApplication.shared.statusBarFrame.size.height
        var bottom = CGFloat(0)
        
        if #available(iOS 11.0, *) {
            
            top = self.view.safeAreaInsets.top
            bottom = self.view.safeAreaInsets.bottom
            
        } else {
            // Fallback on earlier versions
        }
        
        self.imagePickerView?.frame = CGRect(x: 0, y: top, width: self.view.frame.size.width, height: self.view.frame.size.height - top - bottom)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
        
    }

    override var prefersStatusBarHidden: Bool {
        
        return true
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
