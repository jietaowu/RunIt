//
//  Users.swift
//  RunIt
//
//  Created by jwu on 3/17/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import Foundation

struct User {
    
    let uid:String
    
    let email:String
    
    init(uid:String,dictionary:[String:Any]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
    }
    
    
}
