//
//  AlbumListView.swift
//  Pods
//
//  Created by marspro on 2018/1/1.
//

import UIKit

class AlbumListView: UIView, UITableViewDelegate, UITableViewDataSource {

    var albumList = [AlbumCollection]()
    var tableView: UITableView?
    
    var callbackAlbumChanged : ((AlbumCollection) -> Void)?
    var selectedAlbum: AlbumCollection?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.clipsToBounds = true 
        
        let tableView = UITableView(frame: CGRect.zero)
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.separatorColor = UIColor(red: 50, green: 50, blue: 50, alpha: 0.8)
        tableView.register(AlbumItemTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.addSubview(tableView)
        
        self.tableView = tableView
        
        self.autoresizingMask = .flexibleHeight        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.tableView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
    }
    
    func bindAlbums(albumList: [AlbumCollection]) {

        self.albumList = albumList
        self.tableView?.reloadData()
        
    }
    
    //  MARK: UITableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.albumList.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let album = self.albumList[indexPath.row]
        
        (cell as? AlbumItemTableViewCell)?.bindAlbum(album: album)
        
        (cell as? AlbumItemTableViewCell)?.clearSelected()
        
        if let selectedAlbum = self.selectedAlbum {
            
            if selectedAlbum.collection == album.collection {
             
                (cell as? AlbumItemTableViewCell)?.setIsSelected()
                
            }
            
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let album = self.albumList[indexPath.row]
        self.callbackAlbumChanged?(album)
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
}
