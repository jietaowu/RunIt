//
//  MessageController.swift
//  RunIt
//
//  Created by jwu on 2/16/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit
import Firebase

class InboxController: UITableViewController, UISearchBarDelegate{
    

    var searchActive:Bool = false
    
    var messages = [Inbox]()

    var users = [User]()
    
    var filtered:[String] = []
    
    var parentId:String?
    
    
     let searchController = UISearchController(searchResultsController: nil)
    
    
    let cellId = "messageCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tabBarController?.tabBar.isHidden = false
        
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
        
        

       setupSearchBar()
        
        tableView.register(MessageCell.self, forCellReuseIdentifier: cellId)
        
        observeInbox()
        
        fetchUsers()
    
        
    }
    
    
    
    fileprivate func setupSearchBar() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    

    func fetchUsers() {
       
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        Database.database().reference().child("users").observe(.value, with: { (snapchat) in
            
            if let dict = snapchat.value as? [String:Any] {
                 
                dict.forEach { (key, value) in
                    
                    if key == Auth.auth().currentUser?.uid {
                        return
                    }
                    
                    guard let userDictionary = value as? [String:Any] else{
                        return
                    }
                    
                    let user = User(uid: key, dictionary: userDictionary)
                    
                    self.users.append(user)
                    
                    
                    

                    
                }
                
                
                
                
                
                
                
            }
            
        
        })
    }
    
    
    var dest:UIViewController? = nil
    
    func setupBarButtonItems(){
        
        
       
       let destVC = ActionPickerController()
            
              //2.设置目标控制器Modal出来的样式
              destVC.modalPresentationStyle = .popover
               //3.设置目标控制器Modal出来之后的大小
              destVC.preferredContentSize = CGSize(width:150, height: 180)
              dest = destVC
              let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
              btn.setImage(UIImage(named: "plus"), for: .normal)
              btn.addTarget(self, action: #selector(InboxController.popover(sender:)), for: .touchUpInside)
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
    

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return messages.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MessageCell
        
        cell.backgroundColor = .green
    
      
        
        //let date = NSDate(timeIntervalSince1970: messages[indexPath.row].date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"

    
        return cell
        
    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chatController = ChatController()
        chatController.parentId = users[indexPath.row].uid
        
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
    
    
   
    func observeInbox()  {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let ref = Database.database().reference().child(REF_INBOX).child(uid)
        ref.queryOrdered(byChild: "date").queryLimited(toLast: 1).observe(.childAdded) { (snapchat) in
            
            if let dict = snapchat.value as? Dictionary<String, Any>{
                
                guard let partnerId = dict["to"] as? String else {
                    return
                }
                
                guard let date = dict["date"] as? Double else {
                    return
                }
                
                guard let text = dict["text"] as? String else{
                    return
                }
                
                let message = Inbox(date: date, txt: text)
                
                self.messages.append(message)
                
                self.tableView.reloadData()
            }
            
            self.tableView.reloadData()
            print(self.messages)
           
        
        }
        
         self.tableView.reloadData()
        
    
    }
  
}


extension InboxController:UIPopoverPresentationControllerDelegate{
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

