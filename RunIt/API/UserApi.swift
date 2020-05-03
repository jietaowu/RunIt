//
//  UserAPI.swift
//  RunIt
//
//  Created by jwu on 3/28/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit
import Firebase

class UserApi {
    
     var currentUserId: String {
           return Auth.auth().currentUser != nil ? Auth.auth().currentUser!.uid : ""
       }
    
    
    func signIn(email:String, password:String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
        }
        
    }
    
   
    
    
    
    
    
}
