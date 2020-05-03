//
//  ChatMessageCell.swift
//  RunIt
//
//  Created by jwu on 2/19/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell{
    
    
    var chatMessage: Message? {
        didSet {
            
            guard let text = chatMessage?.text else{
                return
            }
            
            guard let time = chatMessage?.date else {
                return
            }
            
        
        }
    }
    
    var user:User?{
        
        didSet{
            
            guard let profileImage = user?.profileImage else{
                return
            }
        }
        
    }
    
    
    func configureCell(uid:String, message:Message, image:UIImage)  {
           
        if uid == message.from{
            
            avatarLeadingConstraint = avatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
                   avatarLeadingConstraint.isActive = false
                   
            avatarTrailingConstraint = avatar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
            avatarTrailingConstraint.isActive = true
            
            timeTrailingConstraint = avatar.leadingAnchor.constraint(equalTo: avatar.leadingAnchor, constant: 40)
            timeTrailingConstraint.isActive = true
            
            
            messageLeadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 32)
                       messageLeadingConstraint.isActive = false
            messageTrailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: avatar.leadingAnchor, constant: -32)
            messageTrailingConstraint.isActive = true
            
           
            
            
        }else{
            
            avatar.image = image
            
            avatarLeadingConstraint = avatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
            avatarLeadingConstraint.isActive = true
                   
            avatarTrailingConstraint = avatar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
            avatarTrailingConstraint.isActive = false
            
            
            timeTrailingConstraint = timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
            timeTrailingConstraint.isActive = true
            
            
            
            
            messageLeadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 32)
            messageLeadingConstraint.isActive = true
            
            messageTrailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: avatar.leadingAnchor, constant: -32)
                       messageTrailingConstraint.isActive = false
            
           
            
        }
           
           
           
       }
    
    
    
    let messageLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(15)
        return label
    }()
    

    let bubbleBackgroundView = UIView()
    
    let timeLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.backgroundColor = .red
        label.textColor = .black
        label.numberOfLines = 0
        label.font = label.font.withSize(8)
        return label
    }()
    
    
    
    
    let avatar:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    
    
    
    var messageLeadingConstraint: NSLayoutConstraint!
    var messageTrailingConstraint: NSLayoutConstraint!
    
    
    var avatarLeadingConstraint: NSLayoutConstraint!
    var avatarTrailingConstraint: NSLayoutConstraint!
    
    
    var timeLeadingConstraint: NSLayoutConstraint!
    var timeTrailingConstraint: NSLayoutConstraint!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .default
       
        backgroundColor = .clear
        
        bubbleBackgroundView.backgroundColor = UIColor.rgb(red: 242, green: 242, blue: 242)
        bubbleBackgroundView.layer.cornerRadius = 12
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubbleBackgroundView)
        
        addSubview(messageLabel)
       
    
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .black
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(avatar)
    
        addSubview(timeLabel)
        
        
        // lets set up some constraints for our label
        let constraints = [
            
            avatar.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            avatar.widthAnchor.constraint(equalToConstant: 40),
            avatar.heightAnchor.constraint(equalToConstant: 40),
            
            timeLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 10),
//            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
//            timeLabel.widthAnchor.constraint(equalToConstant: 100),
            
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200),

            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
        ]
        NSLayoutConstraint.activate(constraints)
        
        

        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
