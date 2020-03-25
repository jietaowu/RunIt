//
//  MessageController.swift
//  RunIt
//
//  Created by jwu on 2/16/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit
import Firebase

class MessageController: UITableViewController, UISearchBarDelegate{
    

    var searchActive:Bool = false
    
    var users = [User]()
    
    var filtered:[String] = []
    
     let searchController = UISearchController(searchResultsController: nil)
    
    
    let cellId = "messageCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupBarButtonItems()
        
        title = "消息"
        
        
        var user = Auth.auth().currentUser
        
        if user == nil{
            self.dismiss(animated: true) {
                let loginController = LoginController()
                loginController.modalPresentationStyle = .fullScreen
                self.present(loginController, animated: true, completion: nil)
            }
            
        }
        
        
       
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(showMenuItems))
//        navigationItem.rightBarButtonItem?.tintColor = .black
    
       setupSearchBar()
        
        
        tableView.register(MessageCell.self, forCellReuseIdentifier: cellId)
        
        guard Auth.auth().currentUser != nil else{
           return
        }
        
        fetchUsers()
        
      
        
    }
    
    
    
    fileprivate func setupSearchBar() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let searchBarHeaderView = SearchBarHeaderView()
//        return searchBarHeaderView
//
//
//
//    }

    
    
    func fetchUsers() {
        
        let ref = Database.database().reference().child("users")
        
        ref.observeSingleEvent(of: .value) { (snapchat) in
            
            guard let dictionaries = snapchat.value as? [String:Any] else {
                return
            }
            
            print(dictionaries)
            
            dictionaries.forEach { (key,value) in
                if key == Auth.auth().currentUser?.uid {
                    return
                }
                
                guard let userDictionary = value as? [String:Any] else{
                    return
                }
                
                let user = User(uid: key, dictionary: userDictionary)
                
                self.users.append(user)
                
                self.tableView.reloadData()
                
                
                
            }
            
            
        }
        
        
        
        
    }
    
    var dest:UIViewController? = nil
    
    func setupBarButtonItems(){
        
        
       
       let destVC = ProfileImagePickerController()
            
              //2.设置目标控制器Modal出来的样式
              destVC.modalPresentationStyle = .popover
               //3.设置目标控制器Modal出来之后的大小
              destVC.preferredContentSize = CGSize(width:150, height: 180)
              dest = destVC
              let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
              btn.setImage(UIImage(named: "plus"), for: .normal)
              btn.addTarget(self, action: #selector(MessageController.popover(sender:)), for: .touchUpInside)
              btn.setTitleColor(UIColor.orange, for: .normal)
              navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)

       
        
        
        
    }
    
    
    @objc func popover(sender:UIButton) {
        
       //4.获取目标控制器的popoverPresentationController
        guard let popoverVC = dest!.popoverPresentationController else {
            return
        }
        //5.给popoverVC设置背景颜色
        popoverVC.backgroundColor = UIColor.white
       //5.给popoverPresentationController设置代理
        popoverVC.delegate = self
       //6.设置sourceView和sourceRect
        popoverVC.sourceView = sender
        popoverVC.sourceRect = sender.bounds
         //7.如果sourceView是UIBarButtonItem类型，必须要有下面这一句.这里的sender是UIButton类型的，所已不需要下面这一句
        // popoverVC.barButtonItem = UIBarButtonItem(customView: sender)
       //8.present目标控制器
        present(dest!, animated: true, completion: nil)
    }
    
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filtered = users.filter({ (text) -> Bool in
//            let tmp:NSString = text as NSString
//            let range = tmp.range(of: searchText, options: .caseInsensitive)
//            return range.location != NSNotFound
//        })
//
//        if(filtered.count == 0){
//            searchActive = false
//        }else{
//            searchActive = true
//        }
//
//        self.tableView.reloadData()
//
//    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return users.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MessageCell

        cell.nameLabel.text = users[indexPath.row].email
        
        
        
//        if(searchActive){
//            cell.nameLabel.text = filtered[indexPath.row]
//            cell.imageView?.image = UIImage(named: img[indexPath.row])
//        }else{
       // cell.imageView?.image = UIImage(named: "1.jpg")
//            cell.nameLabel.text = data[indexPath.row]
//        }
//
        return cell
        
      
        
        
       // cell.update(count: 2)
//        cell.imageView?.image = UIImage(named: img[indexPath.row])
//        return cell
        
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
    
        let chatController = ChatController(collectionViewLayout: layout)
        
        self.navigationController?.pushViewController(chatController, animated: true)
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
        
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    {
         return "删除"
    }
    
    
   
  
    
    
   
   
    
    
    
    
    
    
    
    
    
    
    
    

  

}


extension MessageController:UIPopoverPresentationControllerDelegate{
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
