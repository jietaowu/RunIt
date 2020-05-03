//
//  PeopleCell.swift
//  RunIt
//
//  Created by jwu on 3/28/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit
import Firebase

class NearbyCell: UITableViewCell {

    
        
        var user:User?{
            didSet{

                
                guard let uid = user?.uid else {
                    return
                }
                
                guard let name = user?.username else {
                    return
                }
                
                
                guard let profileImage = user?.profileImage else {
                    return
                }
                
            

            }
        }
        
        

         let profileImageView:UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "1.jpg")
            return imageView
        }()
        
        
        
         public lazy var nameLabel:UILabel = {
           let nameLabel = UILabel()
            nameLabel.textColor = .black
            nameLabel.numberOfLines = 0
            nameLabel.font = UIFont.systemFont(ofSize: 14)
           return nameLabel
        }()
    

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            selectionStyle = .none
            
            addSubview(profileImageView)
            profileImageView.layer.cornerRadius = 5
            profileImageView.clipsToBounds = true
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
            profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
            profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
           
            
            addSubview(nameLabel)
            nameLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 0, width: 80, height: 30)
            
        
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        

    


}
