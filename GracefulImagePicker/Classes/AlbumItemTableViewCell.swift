//
//  AlbumItemTableViewCell.swift
//  Pods
//
//  Created by marspro on 2018/1/1.
//

import UIKit

class AlbumItemTableViewCell: UITableViewCell {

    var albumThumbView: UIImageView?
    var titleLabel: UILabel?
    var numberLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let albumView = UIImageView(frame: CGRect.zero)
        albumView.contentMode = .scaleAspectFill
        albumView.clipsToBounds = true
        self.addSubview(albumView)
        
        self.albumThumbView = albumView
        
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(titleLabel)
        
        self.titleLabel = titleLabel
        
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
        self.titleLabel?.frame = CGRect(x: self.albumThumbView!.frame.origin.x + self.albumThumbView!.frame.size.width + 10, y: 0, width: self.frame.size.width - 100, height: self.frame.size.height)
        self.numberLabel?.frame = CGRect(x: self.frame.size.width - 100, y: 0, width: 80, height: self.frame.size.height)
        
    }
    
    func bindAlbum(album: AlbumCollection) {
        
        album.getThumbImage { (image) in
            
            self.albumThumbView?.image = image
            
        }
        
        self.titleLabel?.text = album.collection?.localizedTitle
        self.numberLabel?.text = "\(album.getPhotoCount())"
        
    }

}
