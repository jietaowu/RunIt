//
//  MeController.swift
//  RunIt
//
//  Created by jwu on 2/16/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit


class MeController: UITableViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    
    let FBLoginManager = LoginManager()
    
    var services = [
        ["支付"],
        ["收藏","相册","表情"],
        ["退出"]
    ]
    
    
    
    var iconImageView = [["1"],["2","2","2"],["exit"]]
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    
    
       
        
       self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        
        var cameraIcon = UIImage(named: "Camera")
        cameraIcon = cameraIcon?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: cameraIcon, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.setBackgroundImage(UIImage(named: "AlbumOperateMoreViewBkg"), for: .normal, barMetrics: .default)
        
        
        tableView.register(MeCell.self, forCellReuseIdentifier: cellId)
        
        tableView.sectionHeaderHeight = 5
        tableView.sectionFooterHeight = 5
        
        
       if AccessToken.current != nil{
        
         var userId = AccessToken.current?.userID
    
       }else{
        
        let firebaseAuth = Auth.auth()
                       do {
                         try firebaseAuth.signOut()
                           
                          let loginManager = LoginManager()
                           loginManager.logOut()
                           
                           
                       print("signing out")
                           let loginController = LoginController()
                        
                        
                           loginController.modalPresentationStyle = .fullScreen
                            
                           self.present(loginController, animated: true)
                           
                       } catch let signOutError as NSError {
                         print ("Error signing out: %@", signOutError)
                       }
        
        
        }
        
    
    }
    
    
   
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        if section == 0{
            let profileHeaderView = ProfileHeaderView()
            return profileHeaderView
        }else{
            let view = UIView(frame: .zero)
            return view
            
        }
        
            
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0{
             return 150
        }else{
            return 0
        }
        
       
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return services.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId , for: indexPath) as! MeCell
        cell.accessoryType = .disclosureIndicator
        cell.serviceLabel.text = services[indexPath.section][indexPath.row]
        cell.imageView?.image = UIImage(named: iconImageView[indexPath.section][indexPath.row])
        return cell
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if [indexPath.section][indexPath.row] == 2{
           
             // 1
             let optionMenu = UIAlertController(title: nil, message: "退出后不会删除任何历史数据，下次登录后依然可以使用本账号。", preferredStyle: .actionSheet)
                 
             // 2
            let yesAction = UIAlertAction(title: "退出登录", style: .default) { (_) in
            
                
                let firebaseAuth = Auth.auth()
                do {
                  try firebaseAuth.signOut()
                    
                   let loginManager = LoginManager()
                    loginManager.logOut()
                    
                    
                print("signing out")
                    let loginController = LoginController()
                    loginController.modalPresentationStyle = .fullScreen
                    self.present(loginController, animated: true)
                    
                } catch let signOutError as NSError {
                  print ("Error signing out: %@", signOutError)
                }
                  
            }
            yesAction.setValue(UIColor(red: 240/255, green: 128/255, blue: 128/255, alpha: 1), forKey: "titleTextColor")
                 
             // 3
             let cancelAction = UIAlertAction(title: "取消", style: .cancel)
            cancelAction.setValue(UIColor(red: 73/255, green: 73/255, blue: 73/255, alpha: 1), forKey: "titleTextColor")
            
             // 4
             optionMenu.addAction(yesAction)
             optionMenu.addAction(cancelAction)
                 
             // 5
             self.present(optionMenu, animated: true, completion: nil)
            
            
            
            
        }
    }
    
    
  
    
   
    
    

    

}
