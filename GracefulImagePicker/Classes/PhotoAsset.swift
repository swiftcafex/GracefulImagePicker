//
//  PhotoAsset.swift
//  Pods
//
//  Created by marspro on 2018/1/2.
//

import UIKit
import Photos

class PhotoAsset: NSObject {

    var asset: PHAsset?
    
    func isInCloud(callback: @escaping (Bool) -> Void) {
        
        guard let asset = self.asset else { return }
        
        let detectOption = PHImageRequestOptions()
        detectOption.isNetworkAccessAllowed = false
        detectOption.isSynchronous = true
        
        PHImageManager.default().requestImageData(for: asset, options: detectOption) { (data, uti, orientation, info) in
            
            if info?[PHImageResultIsInCloudKey] as? Bool == true {

                if data == nil {
                    
                    callback(true)

                } else {
                    
                    callback(false)
                    
                }

            } else {

                callback(false)

            }

        }
        
        
    }
    
    func getThumbnail(sizeWidth: CGFloat, callback: @escaping (UIImage?) -> Void) {
        
        guard let asset = self.asset else { return }
        
        let options = PHImageRequestOptions()
        options.resizeMode = .fast
        options.isSynchronous = true
        
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: sizeWidth, height: sizeWidth), contentMode: PHImageContentMode.aspectFill, options: options) { (image, info) in
            
            callback(image)
            
        }
        
    }
    
}
