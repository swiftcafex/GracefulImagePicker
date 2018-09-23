//
//  GracefulImagePickerView.swift
//  Pods
//
//  Created by swiftcafe on 2017/12/28.
//

import UIKit
import Photos

public class GracefulImagePickerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView : UICollectionView?
    var collectionLayout : UICollectionViewFlowLayout?
    var sizeWidth: CGFloat = 0.0
    
    var currentAlbum : AlbumCollection?
    
    var albumList = [AlbumCollection]()
    var assetResult = [PhotoAsset]()
    
    public var titleView: ImagePickerTitleView?
    
    var albumListView: AlbumListView?
    
    public var backClicked: (() -> Void)?
    public var imageSelected: ((UIImage,PHAsset) -> Void)?
    
    var pickerConfig: ImagePickerConfiguration?
    
    public init(frame: CGRect, config: ImagePickerConfiguration = ImagePickerConfiguration()) {
        
        super.init(frame: frame)
        
        self.pickerConfig = config
        
        self.backgroundColor = UIColor.white
        
        // Collection View
        let collectionLayout = UICollectionViewFlowLayout()
        	
        collectionLayout.minimumLineSpacing = 2
        collectionLayout.minimumInteritemSpacing = 2
        collectionLayout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        self.collectionLayout = collectionLayout
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        self.addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsets.zero
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 249.0 / 255.0, green: 249.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        self.collectionView = collectionView
        
        let albumListView = AlbumListView(frame: CGRect.zero)
        albumListView.callbackAlbumChanged = { album in
            
            // change 
            self.loadPhotos(album: album)
            self.hideAlbumList()
            self.titleView?.changeToOpen()
            
        }
    
        self.addSubview(albumListView)
        
        self.albumListView = albumListView
        
        
        // Title View
        let titleView = ImagePickerTitleView(frame: CGRect.zero, config: config)
        
        self.titleView = titleView
        
        self.titleView?.callbackCloseAlbum = {
            
            self.hideAlbumList()
            
        }
        
        self.titleView?.callbackOpenAlbum = {
            
            self.showAlbumList()
            
        }
        
        self.titleView?.backClicked = {
            
            self.backClicked?()
            
        }
        
        self.addSubview(titleView)
        
        
        self.reload()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override public func layoutSubviews() {
        
        super.layoutSubviews()
        
        var top = CGFloat(20)
        
        if #available(iOS 11.0, *) {
            
            top = self.safeAreaInsets.top
            
        }
        
        let titleHeight = CGFloat(44)
        self.titleView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: titleHeight + top)
        
        self.collectionView?.frame = CGRect(x: 0, y: titleHeight + top,
                                            width: self.frame.size.width,
                                            height: self.frame.size.height - titleHeight - top)
        
        sizeWidth = self.frame.size.width / 4 - 4
        self.collectionLayout?.itemSize = CGSize(width: sizeWidth, height: sizeWidth)
        
    }
    
    func showAlbumList() {
    
        self.albumListView?.selectedAlbum = self.currentAlbum
        self.albumListView?.frame = CGRect(x: 0, y: self.collectionView!.frame.origin.y, width: self.collectionView!.frame.width, height: 0)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.albumListView?.frame = CGRect(x: 0, y: self.collectionView!.frame.origin.y, width: self.collectionView!.frame.width, height: self.collectionView!.frame.height)
            
        })
        
        self.albumListView?.tableView?.reloadData()
        
    }
    
    func hideAlbumList() {
     
        UIView.animate(withDuration: 0.3, animations: {
            
            self.albumListView?.frame = CGRect(x: 0, y: self.collectionView!.frame.origin.y, width: self.collectionView!.frame.width, height: 0)
            
        })
        
    }
    
    // MARK: Photos
    
    // Load photos from album
    public func reload() {
        
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            
            //if not authorized
            PHPhotoLibrary.requestAuthorization({ (status) in
                
                DispatchQueue.main.async {
                 
                    self.reload()
                    
                }
                
            })
            
        } else {
        
            self.loadAlbums()
            
            self.albumListView?.bindAlbums(albumList: self.albumList)
            loadPhotos(album: self.albumList.first)
            
        }
        
        
    }
    
    func loadPhotos(album: AlbumCollection?) {
        
        if let coll = album?.collection {
        
            self.currentAlbum = album
            
            self.titleView?.titleLabel?.text = coll.localizedTitle
            self.titleView?.setNeedsLayout()
            
            let fetchOptions = PHFetchOptions()
            
            if self.pickerConfig!.reverseImageList {
                
                fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
                
            }
            
            let fetchResult = PHAsset.fetchAssets(in: coll, options: fetchOptions)
            
            self.assetResult.removeAll()
            
            fetchResult.enumerateObjects({ (asset, index, stop) in
                
                let photoAsset = PhotoAsset()
                photoAsset.asset = asset
                self.assetResult.append(photoAsset)
                
            })
            
            self.collectionView?.reloadData()
            self.collectionView?.scrollToItem(at: IndexPath(row: self.assetResult.count - 1, section: 0), at: UICollectionViewScrollPosition.bottom, animated: false)
            
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
        
        return self.assetResult.count
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        
        let photoAsset = self.assetResult[indexPath.row]
        
        cell.cleariCloudTag()
        
        photoAsset.isInCloud { (incloud) in
            
            if incloud {
                
                cell.showiCloudTag()
                
            }
            
        }
        
        photoAsset.getThumbnail(sizeWidth: self.sizeWidth) { (image) in
            
            cell.imageView?.image = image
            
        }
        
        
        // check select state
        if self.selectedIndex.contains(indexPath) {
            
            if let index = selectedIndex.index(of: indexPath) {
                
                cell.showSelection(tag: "\(index + 1)")
                
            }
            
        } else {
            
            cell.hideSelection()
            
        }
        
        return cell
        
    }
    
    var currentLoadingID: PHImageRequestID?
    var currentLoadingIndexPath: IndexPath?
    var startCancel: Bool = false
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let asset = self.assetResult[indexPath.row].asset else { return }
        
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        
        if self.pickerConfig?.mutipleSelection ?? false {
            
            // handle mutiple selection
            self.handleMutipleSelection(cell: cell, collectionView: collectionView, indexPath: indexPath)
            
        } else {
            
            // default handle Single Selection
            self.handleSingleSelect(asset: asset, collectionView: collectionView, indexPath: indexPath)
        }
        
    }
    
    var selectedIndex = [IndexPath]()
    
    func handleMutipleSelection(cell: ImageCollectionViewCell, collectionView: UICollectionView, indexPath: IndexPath) {
        
        if self.selectedIndex.contains(indexPath) {
            
            // if this cell has selected -> deselect it
            if let index = selectedIndex.index(of: indexPath) {
                
                selectedIndex.remove(at: index)
                cell.hideSelection()
                
            }
            
        } else {
            
            // if not select -> select it
            selectedIndex.append(indexPath)
            cell.showSelection(tag: "\(selectedIndex.count)")
            
        }
        
//        self.collectionView?.reloadData()
        
    }
    
    func handleSingleSelect(asset: PHAsset, collectionView: UICollectionView, indexPath: IndexPath) {
        
        if let loadingID = self.currentLoadingID {
            
            // Cancel current loading tasks.
            self.currentLoadingID = nil
            PHImageManager.default().cancelImageRequest(loadingID)
            
            if let loadingIndexPath = self.currentLoadingIndexPath {
                
                self.currentLoadingIndexPath = nil
                
                if let cell = collectionView.cellForItem(at: loadingIndexPath) as? ImageCollectionViewCell {
                    //恢复视图状态
                    cell.downloadCanceled = true
                    cell.hideDownloadProgressView()
                    
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
                        
                        cell.showDownloadProgressView()
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
                    cell.cleariCloudTag()
                    cell.hideDownloadProgressView()
                    
                }
                
            }
            
        })
        
    }
    
}
