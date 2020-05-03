//
//  CustomCell.swift
//  RunIt
//
//  Created by jwu on 2/16/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
       
//        update(count: 2)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(count: Int) {
       // Count > 0, show count
       if count > 0 {

           // Create label
           let fontSize: CGFloat = 14
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: fontSize)
           label.textAlignment = .center
           label.textColor = UIColor.white
           label.backgroundColor = UIColor.red
        
           
        
        

           // Add count to label and size to fit
           label.text = "\(NSNumber(value: count))"
           label.sizeToFit()

           // Adjust frame to be square for single digits or elliptical for numbers > 9
           var frame: CGRect = label.frame
        
    
        
        

           frame.size.height += CGFloat(Int(0.4 * fontSize))
           frame.size.width = (count <= 9) ? frame.size.height : frame.size.width + CGFloat(Int(fontSize))
        
           label.frame = frame

           // Set radius and clip to bounds
           label.layer.cornerRadius = frame.size.height / 2.0
           label.clipsToBounds = true

           // Show label in accessory view and remove disclosure
           self.accessoryView = label
           self.accessoryType = .none
       } else {
           self.accessoryView = nil
           self.accessoryType = .disclosureIndicator
       }
    }
    
    
    
    
}
