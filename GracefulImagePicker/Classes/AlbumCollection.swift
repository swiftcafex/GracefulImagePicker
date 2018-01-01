//
//  AlbumCollection.swift
//  ninegrid
//
//  Created by marspro on 2017/10/28.
//  Copyright © 2017年 mars. All rights reserved.
//

import UIKit
import Photos

public class AlbumCollection {
    
    var collection: PHAssetCollection?
    
    var cachedImage: UIImage?
    var cachedCount: Int?
    
    func getPhotoCount() -> Int {
        
        // if photo count already fetched.
        if let cached = cachedCount {
            return cached
        }
        
        if let coll = self.collection {
            
            // fetch photo count
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
            let result = PHAsset.fetchAssets(in: coll, options: fetchOptions)
            self.cachedCount = result.count
            return result.count
            
        }
        
        return 0
        
    }
    
    func getThumbImage(callback: @escaping (UIImage?) -> Void) {
        
        if let cached = self.cachedImage {
            
            callback(cached)
            
        }
        
        if let coll = self.collection {
            
            let result = PHAsset.fetchAssets(in: coll, options: nil)
            
            if(result.count > 0) {
                
                if let asset = result.firstObject {
                    
                    PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: PHImageContentMode.aspectFill, options: nil) { (image, info) in
                        
                        self.cachedImage = image
                        callback(image)
                        
                    }
                    
                }
            }
            
        } else {
            
            callback(nil)
            
        }
        
        
    }
    
}

