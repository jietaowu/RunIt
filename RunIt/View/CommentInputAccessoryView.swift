//
//  CommentInputAccessoryView.swift
//  RunIt
//
//  Created by jwu on 2/25/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit

protocol MessageInputAccessoryViewDelegate {
    func didSubmit(for comment:String)
}

class CommentInputAccessoryView: UIView {
    
    var delegate:MessageInputAccessoryViewDelegate?
    
    
    fileprivate let commentTextView:CommentInputTextView = {
        let tv = CommentInputTextView()
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.backgroundColor = .red
        return tv
        
    }()
    
    fileprivate let submitButton:UIButton = {
        let sb = UIButton(type: .system)
        sb.setTitle("Submit", for: .normal)
        sb.setTitleColor(.black, for: .normal)
        sb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        sb.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return sb
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        
        //1
        autoresizingMask = .flexibleHeight
        
        
        addSubview(commentTextView)
        
        
        
        
        addSubview(submitButton)
        
        submitButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 50, height: 50)
        
        
       
      
        
        setupLineSeparatorView()
        
        if #available(iOS 11.0, *){
                   
//
//                      commentTextView.anchor(top: topAnchor, left: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: submitButton.leadingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 0, height: 0)
            
            commentTextView.translatesAutoresizingMaskIntoConstraints = false
           
            commentTextView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
            commentTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
             commentTextView.trailingAnchor.constraint(equalTo: submitButton.trailingAnchor, constant: -8).isActive = true
            commentTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
            
            
            
                  } else {
                      // Fallback on earlier versions
                  }
        

        
}
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var intrinsicContentSize: CGSize{
        return .zero
    }
    
    
    
    
    func setupLineSeparatorView()  {
        
        let lineSeparatorView = UIView()
               lineSeparatorView.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
               addSubview(lineSeparatorView)
               lineSeparatorView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
    
    }
    
    @objc func handleSubmit() {
        
        guard let messageText = commentTextView.text else { return }
        
        delegate?.didSubmit(for: messageText)
        
        
        
    }
    
    
    
}
