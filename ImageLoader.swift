//
//  ImageLoader.swift
//  Pods
//
//  Created by marspro on 2018/1/1.
//

import Foundation
import UIKit

class ImageLoader {
    
    // load image from framework bundle
    static func image(named: String) -> UIImage? {
        
        let frameworkBundle = Bundle(for: ImageLoader.self)
        return UIImage(named: named, in: frameworkBundle, compatibleWith: nil)
        
    }
    
}
