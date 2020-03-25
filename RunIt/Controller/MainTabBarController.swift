//
//  MainTabBarController.swift
//  RunIt
//
//  Created by jwu on 2/15/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    let messageControlelr = UINavigationController(rootViewController: MessageController())
    
    let addressBookController = AddressBookController()
    
    let meController = MeController()
    
    let discoverController = DiscoverController()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = UIColor(red: 7/255, green: 193/255, blue: 96/255, alpha: 1)
        
        

        messageControlelr.navigationItem.title = "微信"
        messageControlelr.tabBarItem.title = "微信"
        messageControlelr.tabBarItem.selectedImage = UIImage(named: "tabbar_mainframeHL")
        messageControlelr.tabBarItem.image = UIImage(named: "tabbar_mainframe")
        messageControlelr.tabBarItem.badgeColor = .red
        messageControlelr.tabBarItem.badgeValue = "6"
        
        addressBookController.navigationItem.title = "通讯录"
        addressBookController.tabBarItem.title = "通讯录"
        addressBookController.tabBarItem.selectedImage = UIImage(named: "tabbar_contactsHL")
        addressBookController.tabBarItem.image = UIImage(named: "tabbar_contacts")
       
        meController.navigationItem.title = "我"
        meController.tabBarItem.title = "我"
        meController.tabBarItem.selectedImage = UIImage(named: "tabbar_meHL")
        meController.tabBarItem.image = UIImage(named: "tabbar_me")
              
        discoverController.navigationItem.title = "发现"
        discoverController.tabBarItem.title = "发现"
        discoverController.tabBarItem.selectedImage = UIImage(named: "tabbar_discoverHL")
        discoverController.tabBarItem.image = UIImage(named: "tabbar_discover")
        
        
       
        
        
       viewControllers = [messageControlelr, addressBookController,discoverController, meController]
       
    }
    
    
  
        
        
       
        
    
        
        
        
        
        
        
        

    
    
    
    
    
    
    
    
    
    
    
    
   
    
    
  
    

   
}
