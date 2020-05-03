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
            guard let txt = inbox?.txt else{
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
    
    
    
     public lazy var nameLabel:UILabel = {
       let nameLabel = UILabel()
        nameLabel.text = "亲爱的"
        nameLabel.font = UIFont.systemFont(ofSize: 16)
       nameLabel.translatesAutoresizingMaskIntoConstraints = false
       return nameLabel
    }()
    
    let subtitleLabel:UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.backgroundColor = .red
        subtitleLabel.text = "[转帐]朋友已确认收钱"
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = UIColor.getCustomColor(red: 199, green: 199, blue: 199)
        //subtitleLabel.textColor = UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
    }()
    
     lazy var dateLabel:UILabel = {
        //create another label
          let dateFontSize:CGFloat = 12
          let dateLabel = UILabel()
          dateLabel.text = "2021/12/29"
          dateLabel.textColor = UIColor.getCustomColor(red: 199, green: 199, blue: 199)
          dateLabel.font = UIFont.systemFont(ofSize: dateFontSize)
          dateLabel.translatesAutoresizingMaskIntoConstraints = false
          return dateLabel
    }()
    
    //custom
    
    // Create label
    let fontSize: CGFloat = 14
    
    private lazy var label:UILabel = {
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
       
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, subtitleLabel])
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        
        //test
        addSubview(label)
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
