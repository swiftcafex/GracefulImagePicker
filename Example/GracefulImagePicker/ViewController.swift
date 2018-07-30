//
//  ViewController.swift
//  GracefulImagePicker
//
//  Created by SwiftCafe on 12/28/2017.
//  Copyright (c) 2017 SwiftCafe. All rights reserved.
//

import UIKit
import GracefulImagePicker

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?
    
    var cellTitleList = ["Present - White Style", "Present - Black Style", "Push White Style", "Push Black Black", "Push Black Black And Reverse", "Push custom background color"]
    
    var cellData = [CellSection]()
    
    
    func setupCells() {
        
        // Section Present
        let sectionPresent = CellSection()
        sectionPresent.title = "Present"
        
        // White Style
        let itemWhite = CellItem()
        itemWhite.title = "White Style"
        itemWhite.callback = self.presentWhiteStyle
        sectionPresent.items.append(itemWhite)
        
        // Black Style
        let itemBlack = CellItem()
        itemBlack.title = "Black Style"
        itemBlack.callback = self.presentBlackStyle
        sectionPresent.items.append(itemBlack)
        
        
        // Section Push
        let sectionPush = CellSection()
        sectionPush.title = "Push"
        
        let itemPushWhite = CellItem()
        itemPushWhite.title = "White Style"
        itemPushWhite.callback = {
            
        }
        
        sectionPush.items.append(itemWhite)
        
        let itemPushBlack = CellItem()
        itemPushBlack.title = "Black Style"
        itemPushBlack.callback = {
            
        }
        
        sectionPush.items.append(itemPushBlack)
    
        
        
        cellData.append(sectionPresent)
        cellData.append(sectionPush)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupCells()
        
        self.title = "GracefulImagePicker"
        
        let tableView = UITableView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        self.navigationController?.navigationBar.isHidden = true
        self.tableView = tableView
        
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        self.tableView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: UITableView Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.cellTitleList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.cellTitleList[indexPath.row]
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
        
            // default white style
            let picker = PickerContanerViewController()
            let nav = UINavigationController(rootViewController: picker)
            self.present(nav, animated: true, completion: nil)
            
        } else if indexPath.row == 1 {
            
            // black style
            
            let picker = PickerContanerViewController()
            let config = ImagePickerConfiguration()
            config.style = .Black
            picker.pickerConfig = config
            let nav = UINavigationController(rootViewController: picker)
            self.present(nav, animated: true, completion: nil)
            
        } else if indexPath.row == 2 {
            
            let pickerController = GracefulImagePickerViewController()
            pickerController.imageSelected = { image, asset in
                
                let resultView = ImageSelectedViewController()
                resultView.image = image
                self.navigationController?.pushViewController(resultView, animated: true)
                
            }
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(pickerController, animated: true)
            
        } else if indexPath.row == 3 {
            
            let config = ImagePickerConfiguration()
            config.style = .Black
            
            let pickerController = GracefulImagePickerViewController(config: config)
            pickerController.imageSelected = { image, asset in
                
                let resultView = ImageSelectedViewController()
                resultView.image = image
                self.navigationController?.pushViewController(resultView, animated: true)
                
            }
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(pickerController, animated: true)
            
        } else if indexPath.row == 4 {
            
            let config = ImagePickerConfiguration()
            config.style = .Black
            config.reverseImageList = true
            
            let pickerController = GracefulImagePickerViewController(config: config)
            
            pickerController.imageSelected = { image, asset in
                
                let resultView = ImageSelectedViewController()
                resultView.image = image
                self.navigationController?.pushViewController(resultView, animated: true)
                
            }
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(pickerController, animated: true)
            
        } else if indexPath.row == 5 {
            
            let config = ImagePickerConfiguration()
            config.style = .Black
            config.reverseImageList = true
            
            let pickerController = GracefulImagePickerViewController(config: config)
            pickerController.imageSelected = { image, asset in
                
                let resultView = ImageSelectedViewController()
                resultView.image = image
                self.navigationController?.pushViewController(resultView, animated: true)
                
            }
            
            pickerController.imagePickerView?.backgroundColor = UIColor.red
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(pickerController, animated: true)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
}

