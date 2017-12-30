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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let pickerView = GracefulImagePickerView()
        pickerView.backClicked = {
            
            self.dismiss(animated: true, completion: nil)
            
        }
        self.view.addSubview(pickerView)
        self.imagePickerView = pickerView
        
        self.navigationController?.navigationBar.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        self.imagePickerView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        self.imagePickerView?.reload()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.lightContent
        
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
