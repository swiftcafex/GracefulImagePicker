//
//  ImageCollectionViewCell.swift
//  Pods
//
//  Created by marspro on 2017/12/28.
//

import UIKit
import CircleProgressBar

class ImageCollectionViewCell: UICollectionViewCell {
 
    var imageView: UIImageView?
    var cloudView: UIImageView?
 
    var progressContainer: UIView?
    var progressBar: CircleProgressBar?
    
    var downloadCanceled = false    //是否已经取消， 用作 iCloud 下载
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        let imageView = UIImageView(frame: CGRect.zero)
        self.imageView = imageView
        self.imageView?.contentMode = .scaleAspectFill
        self.imageView?.clipsToBounds = true
        self.addSubview(imageView)
        
        let cloudView = UIImageView(frame: CGRect.zero)
        self.cloudView = cloudView
        self.addSubview(cloudView)
        
        let progressContainer = UIView(frame: CGRect.zero)
        self.progressContainer = progressContainer
        progressContainer.isHidden = true
        self.progressContainer?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.addSubview(progressContainer)
        
        
        let progressBar = CircleProgressBar(frame: CGRect.zero)
        progressBar.setProgress(0.4, animated: false)
        progressBar.progressBarWidth = 2
        progressBar.startAngle = 270
        progressBar.progressBarTrackColor = UIColor.gray
        progressBar.progressBarProgressColor = UIColor.white
        progressBar.backgroundColor = UIColor.clear
        progressBar.hintTextColor = UIColor.white
        progressBar.hintTextFont = UIFont.systemFont(ofSize: 6)
        progressBar.hintViewBackgroundColor = UIColor.clear
        progressBar.setHintTextGenerationBlock { (progress) -> String? in

            return "\(Int(progress * 100))"

        }
        self.progressBar = progressBar
        progressContainer.addSubview(progressBar)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.cloudView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        self.progressContainer?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.progressBar?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.progressBar?.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
    }
    
    func setInCloud() {
        
        let frameworkBundle = Bundle(for: ImagePickerTitleView.self)
        self.cloudView?.image = UIImage(named: "in_cloud", in: frameworkBundle, compatibleWith: nil)
        
    }
    
    func finishDownload() {
        
        self.cloudView?.image = nil
    }
    
    //开始加载模式， 显示下载进度条
    func startLoadingMode() {
        
        self.progressContainer?.isHidden = false
        self.cloudView?.isHidden = true
        
    }
    
    //取消加载模式
    func cancelLoadingMode() {
        
        self.progressContainer?.isHidden = true
        self.cloudView?.isHidden = false
    }
    
    
    
}
