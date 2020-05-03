//
//  MessageController.swift
//  RunIt
//
//  Created by jwu on 2/16/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class InboxController: UITableViewController, UISearchBarDelegate{
    
    
    var searchActive:Bool = false
    
    var messages = [Inbox]()
    
    var users = [User]()
    
    var filtered:[String] = []
    
    let partnerId:String? = nil
    
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
        
        observeInbox()
        
        tableView.register(InboxCell.self, forCellReuseIdentifier: cellId)
        
        var user = Auth.auth().currentUser
        
        if user == nil{
            self.dismiss(animated: true) {
                let loginController = LoginController()
                loginController.modalPresentationStyle = .fullScreen
                self.present(loginController, animated: true, completion: nil)
            }
            
        }
        
        setupSearchBar()
        
    }
    
    
    
    fileprivate func setupSearchBar() {
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
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
        
        return users.count
    
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! InboxCell
        
        //last message
        cell.lastMessage.text = messages[indexPath.row].text
        
        
        //time
        let date = NSDate(timeIntervalSince1970: messages[indexPath.row].date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        cell.dateLabel.text = dateFormatter.string(from: date as Date)
        
        cell.usernameLabel.text = users[indexPath.row].username
        
        let url = URL(string: users[indexPath.row].profileImage)
        
        cell.avatar.sd_setImage(with: url, completed: nil)
    
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chatMessageVC = ChatController()
        
        let profileUrlString = users[indexPath.row].profileImage
        
        let url = URL(string: profileUrlString)
        let data = try! Data(contentsOf: url!)
        
        chatMessageVC.imagePartner  = UIImage(data: data)
        chatMessageVC.partnerUsername = users[indexPath.row].username
        chatMessageVC.partnerId = users[indexPath.row].uid
        
        
        
        navigationController?.pushViewController(chatMessageVC, animated: true)
        
        
    }
    
    func observeInbox()  {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        //获取最新的时间的短信
        let ref = Database.database().reference().child(REF_INBOX).child(uid)
        ref.queryOrdered(byChild: "date").queryLimited(toLast: 8).observe(.childAdded) { (snapchat) in
            
            if let dict = snapchat.value as? Dictionary<String, Any>{
                
                let date  = dict["date"] as? Double
                
                let text = dict["text"] as? String
                
                
                let message = Inbox(date: date!, txt: text!)
                
                
                self.messages.append(message)
                
                
                guard let partnerId = dict["to"] as? String else {
                    return
                }
                
                let uid = (partnerId == uid) ? (dict["from"] as! String) : partnerId
                
                let channelId = Message.hash(forMembers: [uid, partnerId])
                
                
                //getting info here
                
                let ref = Database.database().reference().child("users").child(uid)
                ref.observe(.value) { (snapchat) in
                    
                    if let dict = snapchat.value as? Dictionary<String,Any> {
                        let user = User(uid: uid, dictionary: dict)
                        
                        self.users.append(user)
                        
                        
                        self.tableView.reloadData()
                        
                        
                    }
                    
                }
                
                
            }
            
            self.tableView.reloadData()
            
        }
        
    }
    
}


typealias UserCompletion = (User) -> Void


extension InboxController:UIPopoverPresentationControllerDelegate{
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

