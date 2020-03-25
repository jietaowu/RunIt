//
//  ProfileHeaderView.swift
//  RunIt
//
//  Created by jwu on 2/16/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView{

    private lazy var profileImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "1.jpg")
       imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.masksToBounds = true
       return imageView
    }()
    
    
      private lazy var nameLabel:UILabel = {
          let nameLabel = UILabel()
          nameLabel.translatesAutoresizingMaskIntoConstraints = false
          return nameLabel
          
      }()
    
    private lazy var subtitleLabel:UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
        
    }()
    
    
   
    
   override init(frame: CGRect) {
          super.init(frame: frame)
    
    
    
    
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(profileImageView)
    
           profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
                 
             
                profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
                profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
    
    
    
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    
    
    
    
    
    

}
