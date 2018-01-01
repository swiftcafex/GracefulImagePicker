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
    
    public var titleView: ImagePickerTitleView?
    
    var albumListView: AlbumListView?
    
    public var backClicked: (() -> Void)?
    public var imageSelected: ((UIImage,PHAsset) -> Void)?
    
    override convenience init(frame: CGRect) {
        
        self.init(frame: frame, style: .Black)
        
    }
    
    public init(frame: CGRect, style: ImagePickerStyle) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        
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
        
        let albumListView = AlbumListView(frame: CGRect.zero)
        albumListView.callbackAlbumChanged = { album in
            
            self.loadPhotos(album: album)
            self.hideAlbumList()
            self.titleView?.changeToOpen()
            
        }
    
        self.addSubview(albumListView)
        
        self.albumListView = albumListView
        
        
        // Title View
        let titleView = ImagePickerTitleView(frame: CGRect.zero, style: style)
        
        titleView.callbackCloseAlbum = {
            
            self.hideAlbumList()
            
        }
        
        titleView.callbackOpenAlbum = {
            
            self.showAlbumList()
            
        }
        
        titleView.backClicked = {
            
            self.backClicked?()
            
        }
        self.addSubview(titleView)
        self.titleView = titleView
        
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
        
        self.titleView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 40)
        
        let collStartY = top + self.titleView!.frame.size.height
        
        self.collectionView?.frame = CGRect(x: 0, y: collStartY,
                                            width: self.frame.size.width,
                                            height: self.frame.size.height - collStartY)
        
        sizeWidth = self.frame.size.width / 4 - 4
        self.collectionLayout?.itemSize = CGSize(width: sizeWidth, height: sizeWidth)
        
    }
    
    func showAlbumList() {
    
        self.albumListView?.frame = CGRect(x: 0, y: self.collectionView!.frame.origin.y, width: self.collectionView!.frame.width, height: 0)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.albumListView?.frame = CGRect(x: 0, y: self.collectionView!.frame.origin.y, width: self.collectionView!.frame.width, height: self.collectionView!.frame.height)
            
        })
        
        
    }
    
    func hideAlbumList() {
     
        UIView.animate(withDuration: 0.3, animations: {
            
            self.albumListView?.frame = CGRect(x: 0, y: self.collectionView!.frame.origin.y, width: self.collectionView!.frame.width, height: 0)
            
        })
        
    }
    
    // MARK: Photos
    
    // Load photos from album
    public func reload() {
        
        self.loadAlbums()
        
        self.albumListView?.bindAlbums(albumList: self.albumList)
        loadPhotos(album: self.albumList.first)
        
    }
    
    func loadPhotos(album: AlbumCollection?) {
        
        if let coll = album?.collection {
            
            self.titleView?.titleLabel?.text = coll.localizedTitle
            self.assetResult = PHAsset.fetchAssets(in: coll, options: nil)
            
            self.collectionView?.reloadData()
            self.collectionView?.scrollToItem(at: IndexPath(row: self.assetResult!.count - 1, section: 0), at: UICollectionViewScrollPosition.bottom, animated: false)
            
        }
        
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
    
    var currentLoadingID: PHImageRequestID?
    var currentLoadingIndexPath: IndexPath?
    var startCancel: Bool = false
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let asset = self.assetResult?[indexPath.row] else { return }
        
        if let loadingID = self.currentLoadingID {
            
            // Cancel current loading tasks.
            self.currentLoadingID = nil
            PHImageManager.default().cancelImageRequest(loadingID)
            
            if let loadingIndexPath = self.currentLoadingIndexPath {
                
                self.currentLoadingIndexPath = nil
                if let cell = collectionView.cellForItem(at: loadingIndexPath) as? ImageCollectionViewCell {
                    //恢复视图状态
                    cell.downloadCanceled = true
                    cell.cancelLoadingMode()
                    
                }
                
            }
            
        }
        
        var analyticsSent = false
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = .exact
        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.isNetworkAccessAllowed = true
        requestOptions.progressHandler = { progress, error, stop, info in
            
            DispatchQueue.main.async {
                
                if analyticsSent == false {
                    
                    analyticsSent = true
                    
                }
                
                if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell {
                    
                    if cell.downloadCanceled == false {
                        
                        cell.startLoadingMode()
                        cell.progressBar?.setProgress(CGFloat(progress), animated: false)
                        
                    }
                    
                }
            }
            
        }
        
        self.currentLoadingIndexPath = indexPath
        self.startCancel = false
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell {
            
            cell.downloadCanceled = false
            
        }
        
        self.currentLoadingID = PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: requestOptions,resultHandler: { (image, info) in
            
            if let img = image {
                
                //图片加载完成， 才会进入
                if let imageSelected = self.imageSelected {
                    
                    imageSelected(img, asset)
                    
                }
                
                if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell {
                    
                    //恢复视图状态
                    cell.finishDownload()
                    cell.cancelLoadingMode()
                    
                }
                
            }
            
        })
        
        
    }
    
}
