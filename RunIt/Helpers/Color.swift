//
//  Color.swift
//  RunIt
//
//  Created by jwu on 2/15/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit

extension UIColor{
    
    static func getCustomColor(red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor{
        return .init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    
    
}

