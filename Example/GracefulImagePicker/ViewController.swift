//
//  ViewController.swift
//  GracefulImagePicker
//
//  Created by SwiftCafe on 12/28/2017.
//  Copyright (c) 2017 SwiftCafe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView?
    
    var cellTitleList = ["Present White Style", "Present Black Style"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "GracefulImagePicker"
        
        let tableView = UITableView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        
        self.tableView = tableView
        
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        self.tableView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
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
        
            let picker = PickerContanerViewController()
            let nav = UINavigationController(rootViewController: picker)
            self.present(nav, animated: true, completion: nil)
            
        } else if indexPath.row == 1 {
            
            let picker = PickerContanerViewController()
            picker.pickerStyle = .Black
            let nav = UINavigationController(rootViewController: picker)
            self.present(nav, animated: true, completion: nil)
            
        }
        
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
}

