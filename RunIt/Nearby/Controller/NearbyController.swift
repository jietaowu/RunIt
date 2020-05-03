//
//  DiscoverController.swift
//  RunIt
//
//  Created by jwu on 2/16/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class NearbyController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var users:[User] = []
    
    var tableView = UITableView()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
        
        tabBarController?.tabBar.isHidden = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tableView.register(NearbyCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchUsers()
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? NearbyCell
        
        cell?.nameLabel.text = users[indexPath.row].username
        
        cell?.profileImageView.sd_setImage(with: URL(string: users[indexPath.row].profileImage), completed: nil)
        
        
        return cell!
    }
    
    
    func fetchUsers()  {
        
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        Database.database().reference().child("users").observeSingleEvent(of:.value, with: { (snapchat) in
            
            guard let dict = snapchat.value as? [String:Any] else{
                return
            }
            
            dict.forEach { (key, value) in
                if key == Auth.auth().currentUser?.uid{
                    return
                }
                
                
                guard let userDictionary = value as? [String:Any] else{
                    return
                }
                
                let user = User(uid: key, dictionary: userDictionary)
                
                self.users.append(user)
                
                
            }
            
            self.tableView.reloadData()
            
        })
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let cell = tableView.cellForRow(at: indexPath) as? NearbyCell{
            
            let chatMessageVC = ChatController()
            
            let profileUrlString = users[indexPath.row].profileImage
            
            let url = URL(string: profileUrlString)
            let data = try! Data(contentsOf: url!)
            
            chatMessageVC.imagePartner  = UIImage(data: data)
            chatMessageVC.partnerUsername = users[indexPath.row].username
            chatMessageVC.partnerId = users[indexPath.row].uid
            
            navigationController?.pushViewController(chatMessageVC, animated: true)
            
            
        }
        
        
    }
    
    
    func setupNavigationItems()  {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "附近的人"
    }
    
    
    
    
}


