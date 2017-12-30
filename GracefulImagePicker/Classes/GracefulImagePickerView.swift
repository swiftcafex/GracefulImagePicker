//
//  GracefulImagePickerView.swift
//  Pods
//
//  Created by marspro on 2017/12/28.
//

import UIKit
import Photos

public class GracefulImagePickerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView : UICollectionView?
    var collectionLayout : UICollectionViewFlowLayout?
    var sizeWidth: CGFloat = 0.0
    
    var albumList = [AlbumCollection]()
    var assetResult: PHFetchResult<PHAsset>?
    
    var titleView: ImagePickerTitleView?
    
    public var backClicked: (() -> Void)?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        // Title View
        let titleView = ImagePickerTitleView(frame: CGRect.zero)
        titleView.backClicked = {
            
            self.backClicked?()
            
        }
        self.addSubview(titleView)
        self.titleView = titleView
        
        
        
        // Collection View
        let collectionLayout = UICollectionViewFlowLayout()
        
        collectionLayout.minimumLineSpacing = 2
        collectionLayout.minimumInteritemSpacing = 2
        collectionLayout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        self.collectionLayout = collectionLayout
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        self.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
//        collectionView.backgroundColor = UIColor("#f9f9f9")
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        self.collectionView = collectionView
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override public func layoutSubviews() {
        
        super.layoutSubviews()
        
        var top = CGFloat(20.0)
        
        if #available(iOS 11.0, *) {
            
            let safeInset = self.safeAreaInsets
            top = safeInset.top
            
        } else {
            
            
            
        }
        
        self.titleView?.frame = CGRect(x: 0, y: top, width: self.frame.size.width, height: 40)
        self.collectionView?.frame = CGRect(x: 0, y: top + 40,
                                            width: self.frame.size.width,
                                            height: self.frame.size.height)
        
        sizeWidth = self.frame.size.width / 4 - 4
        self.collectionLayout?.itemSize = CGSize(width: sizeWidth, height: sizeWidth)
        
    }
    
    // MARK: Photos
    
    // Load photos from album
    public func reload() {
        
        self.loadAlbums()
        
        if let coll = self.albumList.first?.collection {
            
            self.titleView?.titleLabel?.text = coll.localizedTitle
            self.assetResult = PHAsset.fetchAssets(in: coll, options: nil)
            
        }
        
        self.collectionView?.reloadData()
        
    }
    
    // 加载所有相册列表
    func loadAlbums() {
        
        let options = PHFetchOptions()
        
        // smart album, dynamic calc count
        var result = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.any, options: options)
        
        result.enumerateObjects ({ (collection, index, stop) in
            
            let coll = AlbumCollection()
            coll.collection = collection
            
            if coll.getPhotoCount() > 0 {
                
                if collection.assetCollectionSubtype == PHAssetCollectionSubtype.smartAlbumUserLibrary {
                    
                    // main album will be at first position.
                    self.albumList.insert(coll, at: 0)
                    
                } else {
                    
                    self.albumList.append(coll)
                    
                }
                
            }
            
        })
        
        // normal album, use estimatedAssetCount
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "estimatedAssetCount > 0")
        result = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: fetchOptions)
        result.enumerateObjects ({ (collection, index, stop) in
            
            let coll = AlbumCollection()
            coll.collection = collection
            self.albumList.append(coll)
            
        })
        
    }
    
    // MARK: UICollectionView Delegate
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.assetResult?.count ?? 0
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        
        guard let asset = self.assetResult?[indexPath.row] else { return cell }
        
        //检测 是否图片在 iCloud 中， 并且还没有下载到本地。 如果是，显示云彩标签
        let detectOption = PHImageRequestOptions()
        detectOption.isNetworkAccessAllowed = false
        detectOption.isSynchronous = true
        
        PHImageManager.default().requestImageData(for: asset, options: detectOption) { (data, uti, orientation, info) in
            
            if info?[PHImageResultIsInCloudKey] as? Bool == true {
                if data == nil {
                    
                    cell.setInCloud()
                    
                }
            }
            
        }
        
        
        //请求缩略图
        let options = PHImageRequestOptions()
        options.resizeMode = .fast
        options.isSynchronous = true
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: self.sizeWidth, height: self.sizeWidth), contentMode: PHImageContentMode.aspectFill, options: options) { (image, info) in
            
            cell.imageView?.image = image
            
        }
        
        return cell
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
}
