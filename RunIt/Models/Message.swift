//
//  Message.swift
//  RunIt
//
//  Created by jwu on 3/31/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import Foundation
import Firebase

class Message {
    
    var id:String
    var from:String
    var to:String
    var date:Double
    var text:String
    
    init(id:String, from:String, to:String, date:Double, text:String) {
        
        self.id = id
        self.from = from
        self.to = to
        self.date = date
        self.text = text
        
    }
    

    static func hash(forMembers members: [String]) -> String {
           let hash = members[0].hashString ^ members[1].hashString
           let memberHash = String(hash)
           return memberHash
       }
    
    
    
    static func transformMessage(dict:[String:Any], keyId:String)-> Message?{
         guard let from = dict["from"] as? String,
                   let to = dict["to"] as? String,
                   let date = dict["date"] as? Double else {
                       return nil
               }
        
        
        
        
        
        let text = (dict["text"] as? String) == nil ? "" : (dict["text"] as? String)
        
        let message = Message(id: keyId, from: from, to: to, date: date, text: text!)
        
        return message
        
    }
    
    
    
}


extension String {
    var hashString: Int {
        let unicodeScalars = self.unicodeScalars.map { $0.value }
        return unicodeScalars.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }
}
