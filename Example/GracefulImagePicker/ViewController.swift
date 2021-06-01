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
    
    var titleLabel: UILabel?
    
    func setupCells() {
        
        /// Section Present ///
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
        
        
        /// Section Push ///
        let sectionPush = CellSection()
        sectionPush.title = "Push"
        
        // White Style
        let itemPushWhite = CellItem()
        itemPushWhite.title = "White Style"
        itemPushWhite.callback = self.pushWhiteStyle
        sectionPush.items.append(itemPushWhite)
        
        // Black Style
        let itemPushBlack = CellItem()
        itemPushBlack.title = "Black Style"
        itemPushBlack.callback = self.pushBlackStyle
        sectionPush.items.append(itemPushBlack)
        
        // Custom Style
        let itemPushCustom = CellItem()
        itemPushCustom.title = "Custom Style"
        itemPushCustom.callback = self.pushCustomStyle
        sectionPush.items.append(itemPushCustom)
        
        
        /// Section Multiple Selection ///
        let sectionMultiSelection = CellSection()
        sectionMultiSelection.title = "Multiple Selection"
        
        // Multiple Selection
        let itemMultiSelection = CellItem()
        itemMultiSelection.title = "Multiple Selection"
        itemMultiSelection.callback = self.pushMutipleSelection
        sectionMultiSelection.items.append(itemMultiSelection)
        
        cellData.append(sectionPresent)
        cellData.append(sectionPush)
        cellData.append(sectionMultiSelection)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupCells()
        
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.text = "Picker Views"
        titleLabel.backgroundColor = UIColor.white
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
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
        
        var top = CGFloat(20)
        
        if #available(iOS 11.0, *) {
            
            top = self.view.safeAreaInsets.top
            
        }
        self.titleLabel?.frame = CGRect(x: 0, y: top, width: self.view.frame.size.width, height: 44)
        self.tableView?.frame = CGRect(x: 0, y: top + 44, width: self.view.frame.size.width, height: self.view.frame.size.height - top - 44)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.setNeedsStatusBarAppearanceUpdate()
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .default
        
    }
    
    // MARK: UITableView Delegate
    
    // Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.cellData.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let section = self.cellData[section]
        return section.title
        
    }
    
    // Cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section = self.cellData[section]
        return section.items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let section = self.cellData[indexPath.section]
        let item = section.items[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = self.cellData[indexPath.section]
        let item = section.items[indexPath.row]
        item.callback?()
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
}

