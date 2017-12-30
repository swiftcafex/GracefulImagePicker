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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "测试"
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let picker = PickerContanerViewController()
        let nav = UINavigationController(rootViewController: picker)
        
        self.present(nav, animated: true, completion: nil)
        
    }
    
}

