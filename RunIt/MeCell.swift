//
//  MeCell.swift
//  RunIt
//
//  Created by jwu on 2/16/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit

class MeCell: UITableViewCell {

    
    

     
       
       
       public lazy var serviceLabel:UILabel = {
          let serviceLabel = UILabel()
           serviceLabel.text = "亲爱的"
          serviceLabel.font = UIFont.systemFont(ofSize: 16)
          serviceLabel.translatesAutoresizingMaskIntoConstraints = false
          return serviceLabel
       }()
       
//       private lazy var subtitleLabel:UILabel = {
//           let subtitleLabel = UILabel()
//           subtitleLabel.text = "[转帐]朋友已确认收钱"
//           subtitleLabel.font = UIFont.systemFont(ofSize: 14)
//           subtitleLabel.textColor = UIColor.getCustomColor(red: 199, green: 199, blue: 199)
//           //subtitleLabel.textColor = UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1)
//           subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
//           return subtitleLabel
//       }()
       
      
      
       
       
       
      
       
       
       
       
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           
           selectionStyle = .none
           
           
           
           addSubview(imageView!)
           imageView?.translatesAutoresizingMaskIntoConstraints = false
           imageView?.layer.cornerRadius = 5
           imageView?.clipsToBounds = true
           imageView?.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
           imageView?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
           imageView?.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
           imageView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
           imageView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
            addSubview(serviceLabel)
        serviceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        serviceLabel.leadingAnchor.constraint(equalTo: imageView!.trailingAnchor, constant: 20).isActive = true
        serviceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
            
          
           
//           let stackView = UIStackView(arrangedSubviews: [nameLabel, subtitleLabel])
//           stackView.axis = .vertical
//           addSubview(stackView)
//           stackView.translatesAutoresizingMaskIntoConstraints = false
//           stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
//           stackView.leadingAnchor.constraint(equalTo: imageView!.trailingAnchor, constant: 20).isActive = true
//           stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
           
           
           
           
           
       
           
           
           
           
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       
       
       
       
       
       
       
     
       
       


}
