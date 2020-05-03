//
//  MainTabBarController.swift
//  RunIt
//
//  Created by jwu on 2/15/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    let messageController = UINavigationController(rootViewController: InboxController())
    
    let meController = UINavigationController(rootViewController: MeController())
    
    let peopleTableViewController =  UINavigationController(rootViewController: NearbyController())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = UIColor(red: 7/255, green: 193/255, blue: 96/255, alpha: 1)
        
        
        
        messageController.navigationItem.title = "微信"
        messageController.tabBarItem.title = "微信"
        messageController.tabBarItem.selectedImage = UIImage(named: "tabbar_mainframeHL")
        messageController.tabBarItem.image = UIImage(named: "tabbar_mainframe")
        messageController.tabBarItem.badgeColor = .red
        messageController.tabBarItem.badgeValue = "6"
        
        peopleTableViewController.navigationItem.title = "通讯录"
        peopleTableViewController.tabBarItem.title = "通讯录"
        peopleTableViewController.tabBarItem.selectedImage = UIImage(named: "tabbar_contactsHL")
        peopleTableViewController.tabBarItem.image = UIImage(named: "tabbar_contacts")
       
        meController.navigationItem.title = "我"
        meController.tabBarItem.title = "我"
        meController.tabBarItem.selectedImage = UIImage(named: "tabbar_meHL")
        meController.tabBarItem.image = UIImage(named: "tabbar_me")
              

    
        viewControllers = [messageController, peopleTableViewController,  meController]

        
       
        
        
        
        
    }
    
    
  
        
        
       
        
    
        
        
        
        
        
        
        

    
    
    
    
    
    
    
    
    
    
    
    
   
    
    
  
    

   
}
