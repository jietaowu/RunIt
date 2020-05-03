//
//  ProfileImagePickerController.swift
//  RunIt
//
//  Created by jwu on 3/24/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit

class ActionPickerController: UITableViewController {
    
    var actionTitles = ["发起群聊","添加朋友","扫一扫"]
    
    var actionIcons = ["icons8-add-user-male-25","icons8-add-user-male-25","icons8-barcode-scanner-25"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "个人头像"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.imageView?.image = UIImage(named: actionIcons[indexPath.row])
        cell.textLabel?.text = actionTitles[indexPath.row]
        return cell
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
        if indexPath.row == 1 {
            let searchFriendsController = UINavigationController(rootViewController: SearchFriendsTableViewController())
            searchFriendsController.modalPresentationStyle = .fullScreen
            self.present(searchFriendsController, animated: true, completion: nil)
          
            
        
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
}
