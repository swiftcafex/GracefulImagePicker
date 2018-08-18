//
//  AlbumItemTableViewCell.swift
//  Pods
//
//  Created by marspro on 2018/1/1.
//

import UIKit

class AlbumItemTableViewCell: UITableViewCell {

    var albumThumbView: UIImageView?        // album thumb image view
    var titleLabel: UILabel?                // album title label
    var numberLabel: UILabel?               // album photo count label
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // init thumbnail view
        let albumView = UIImageView(frame: CGRect.zero)
        albumView.contentMode = .scaleAspectFill
        albumView.clipsToBounds = true
        self.addSubview(albumView)
        self.albumThumbView = albumView
        
        // init title label
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        // init photo count label
        let numberLabel = UILabel(frame: CGRect.zero)
        numberLabel.textAlignment = .right
        numberLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(numberLabel)
        self.numberLabel = numberLabel
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let padding = CGFloat(15)
        let imageHeight = self.frame.size.height - padding * 2
        
        self.albumThumbView?.frame = CGRect(x: padding, y: padding, width: imageHeight, height: imageHeight)
        
        if let albumThumbView = self.albumThumbView {
        
            self.titleLabel?.frame = CGRect(x: albumThumbView.frame.origin.x + albumThumbView.frame.size.width + 10,
                                            y: 0, width: self.frame.size.width - 100, height: self.frame.size.height)
            
        }
        
        self.numberLabel?.frame = CGRect(x: self.frame.size.width - 100, y: 0, width: 80, height: self.frame.size.height)
        
    }
    
    func bindAlbum(album: AlbumCollection) {
        
        album.getThumbImage { (image) in
            
            self.albumThumbView?.image = image
            
        }
        
        self.titleLabel?.text = album.collection?.localizedTitle
        self.numberLabel?.text = "\(album.getPhotoCount())"
        
    }
    
    // MARK: handle cell select state
    
    // selected
    func setIsSelected() {
        
        self.titleLabel?.textColor = UIColor(red: 148.0 / 255.0, green: 208.0 / 255.0, blue: 251.0 / 255.0, alpha: 1.0)
        self.numberLabel?.textColor = UIColor(red: 148.0 / 255.0, green: 208.0 / 255.0, blue: 251.0 / 255.0, alpha: 1.0)
        
    }
    
    
    // deselect
    func clearSelected() {
        
        self.titleLabel?.textColor = UIColor.darkGray
        self.numberLabel?.textColor = UIColor.darkGray
        
    }

}
