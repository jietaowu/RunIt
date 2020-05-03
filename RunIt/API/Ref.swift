//
//  Ref.swift
//  RunIt
//
//  Created by jwu on 3/27/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import Foundation
import Firebase

let REF_USER = "users"
let REF_INBOX = "inbox"
let REF_ACTION = "action"

let URL_STORAGE_ROOT = "gs://runit-272308.appspot.com/"



class Ref {
    
    //database
    let databaseRoot:DatabaseReference = Database.database().reference()
    
    //users
    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_USER)
    }
    
    //users uid
    func databaseSpecificUser(uid: String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }
    
    
    var databaseMessage:DatabaseReference{
        return databaseRoot.child(REF_ACTION)
    }
    
    
    
    //send the messages from xx to xx
    func databaseMessageSendTo(from:String, to:String) -> DatabaseReference {
        return databaseMessage.child(from).child(to)
    }
    
    
    
    
    
    
    
    
    
    
    
}

