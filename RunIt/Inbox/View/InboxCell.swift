//
//  MessageCell.swift
//  RunIt
//
//  Created by jwu on 2/16/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit

class InboxCell: CustomCell {
    
   
    
    var user:User?{
        didSet{
            guard let username = user?.username else {
                return
            }

            guard let email = user?.email else {
                return
            }

            guard let profile = user?.profileImage else {
                return
            }
            
        }
    }
    
    var inbox:Inbox?{
        didSet{
            guard let txt = inbox?.text else{
                return
            }
            
            guard let date = inbox?.date else {
                return
            }
            
        }
    }
    
    

     let avatar:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "1.jpg")
        return imageView
    }()
    
    
    
     public lazy var usernameLabel:UILabel = {
       let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16)
       nameLabel.translatesAutoresizingMaskIntoConstraints = false
       return nameLabel
    }()
    
    let lastMessage:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.getCustomColor(red: 199, green: 199, blue: 199)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var dateLabel:UILabel = {
          let dateFontSize:CGFloat = 12
          let dateLabel = UILabel()
          dateLabel.textColor = UIColor.getCustomColor(red: 199, green: 199, blue: 199)
          dateLabel.font = UIFont.systemFont(ofSize: dateFontSize)
          dateLabel.translatesAutoresizingMaskIntoConstraints = false
          return dateLabel
    }()
    
    let fontSize: CGFloat = 14
    
    private lazy var badge:UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: fontSize)
                     label.textAlignment = .center
                     label.textColor = UIColor.white
                     label.backgroundColor = UIColor.red
        label.text = "2"
        label.sizeToFit()
        //(count <= 9) ? frame.size.height : frame.size.width + CGFloat(Int(fontSize))
        label.widthAnchor.constraint(equalToConstant: 20).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        return label
        
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        selectionStyle = .none
        
        addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: CGFloat(12)).isActive = true
        
        
        addSubview(avatar)
        avatar.layer.cornerRadius = 5
        avatar.clipsToBounds = true
        avatar.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        avatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        avatar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 40).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 40).isActive = true
       

        addSubview(badge)
        badge.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        badge.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, lastMessage])
              stackView.axis = .vertical
              addSubview(stackView)
              stackView.translatesAutoresizingMaskIntoConstraints = false
              stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
              stackView.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: badge.leadingAnchor, constant: -20).isActive = true
              stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
