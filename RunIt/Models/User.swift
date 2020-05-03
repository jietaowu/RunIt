//
//  Users.swift
//  RunIt
//
//  Created by jwu on 3/17/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import Foundation

struct User {
    
    var uid: String
    var username: String
    var email:String
    var profileImage:String
    
    
    init(uid: String, dictionary:[String:Any]) {
       
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        
        
    }
    
    
    static func transformUser(dict: [String: Any]) -> User? {
           guard let email = dict["email"] as? String,
               let username = dict["username"] as? String,
               let profileImageUrl = dict["profileImageUrl"] as? String,
               let uid = dict["uid"] as? String else {
                   return nil
           }
        
        let values = ["email": email, "profileImage": profileImageUrl, "username": username]
        
           
        let user = User(uid: uid, dictionary: values )
        
        
        return user
        
         
       }
        
    
}

