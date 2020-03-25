//
//  ChatMessageCell.swift
//  RunIt
//
//  Created by jwu on 2/19/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell{

   let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
         //textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .red
      //  textView.text = "Sample message"
    
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    
    let textBubbleView:UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
       addSubview(messageTextView)
       // messageTextView.frame = contentView.frame
        
        
        addSubview(textBubbleView)
       
        textBubbleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        textBubbleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        textBubbleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
        
        
        textBubbleView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        textBubbleView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
    // textBubbleView.frame = contentView.frame
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//        messageLabel.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(messageLabel)
//        messageLabel.backgroundColor = .green
//        messageLabel.text = "Some MESSAGE "
//
//        messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
//        messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        
        
        
        
        
        
   
    
  
    
}
