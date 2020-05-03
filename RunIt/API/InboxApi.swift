//
//  InboxAPI.swift
//  RunIt
//
//  Created by jwu on 3/27/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import Foundation
import Firebase


typealias InboxCompletion = (Inbox)->Void

class InboxApi {
    
    func lastMessages(uid:String) {
        
         let ref = Database.database().reference().child(REF_INBOX).child(uid)
        
         ref.queryOrdered(byChild: "date").queryLimited(toLast: 1).observe(.childAdded) { (snapchat) in
            
            if let dict = snapchat.value as? [String:Any] {
               
                guard let parnterId = dict["to"] as? String else {
                    return
                }
                
                let uid = (parnterId == Auth.auth().currentUser?.uid) ? (dict["from"] as? String) : parnterId
                
                
                
                //let channelId = Message.hash(forMembers: [uid, parnterId])
                
                
                
                
                
                
                
            }
            
            
          
            
            
            
            
            
        }
        
        
    }
    
   
    
    
    
    
    
    
}
