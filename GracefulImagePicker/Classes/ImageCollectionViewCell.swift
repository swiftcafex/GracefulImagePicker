//
//  ImageCollectionViewCell.swift
//  Pods
//
//  Created by marspro on 2017/12/28.
//

import UIKit
import CircleProgressBar

class SelectionView : UIView {
    
    var titleLabel : UILabel?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 83.0 / 255.0, green: 148.0 / 255.0, blue: 232.0 / 255.0, alpha: 0.8)
        
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textColor = UIColor.white
        
        self.addSubview(titleLabel)
        
        self.titleLabel = titleLabel
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.titleLabel?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 30)
        
    }
    
}

class ImageCollectionViewCell: UICollectionViewCell {
 
    var imageView: UIImageView?             // image view
    var cloudView: UIImageView?             // icloud tag
 
    var progressContainer: UIView?          // container for progress view
    var progressBar: CircleProgressBar?     // progress view used to display download.
    
    var downloadCanceled = false            // indicate whether the downloading task with this cell canceled.

    var selectionView : SelectionView?      // selectionView
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // init image view
        let imageView = UIImageView(frame: CGRect.zero)
        self.imageView = imageView
        self.imageView?.contentMode = .scaleAspectFill
        self.imageView?.clipsToBounds = true
        self.addSubview(imageView)
        
        // init iCloud tag
        let cloudView = UIImageView(frame: CGRect.zero)
        self.cloudView = cloudView
        self.addSubview(cloudView)
        
        // init progress view container
        let progressContainer = UIView(frame: CGRect.zero)
        self.progressContainer = progressContainer
        progressContainer.isHidden = true
        self.progressContainer?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.addSubview(progressContainer)
        
        // init progress view
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
        
        
        let selectionView = SelectionView(frame: CGRect.zero)
        self.selectionView = selectionView
        self.selectionView?.isHidden = true
        self.addSubview(selectionView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.imageView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.cloudView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        self.selectionView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        self.progressContainer?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.progressBar?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.progressBar?.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
        
        
    }
    
    // MARK: handle iCloud tag display.
    
    // show icloud tag
    func showiCloudTag() {
        
        self.cloudView?.image = ImageLoader.image(named: "in_cloud")
        
    }
    
    // clear icloud tag
    func cleariCloudTag() {
        
        self.cloudView?.image = nil
        
    }    
    
    // show selection
    func showSelection(tag: String) {
        
        self.selectionView?.isHidden = false
        self.selectionView?.titleLabel?.text = " \(tag)"
        
    }
    
    func hideSelection() {
        
        self.selectionView?.isHidden = true
        self.selectionView?.titleLabel?.text = ""
        
    }
    
    // MARK: handle iCloud download progress.
    
    // show download progress view.
    func showDownloadProgressView() {
        
        self.progressContainer?.isHidden = false
        self.cloudView?.isHidden = true
        
    }
    
    // hide download progress view.
    func hideDownloadProgressView() {
        
        self.progressContainer?.isHidden = true
        self.cloudView?.isHidden = false
    }
    
    
    
}
