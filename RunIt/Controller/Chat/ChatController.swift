//
//  ChatController.swift
//  RunIt
//
//  Created by jwu on 2/16/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit
import ISEmojiView
import Firebase


class ChatController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MessageInputAccessoryViewDelegate  {
    
    
    lazy var containerView: CommentInputAccessoryView = {
           let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
           let commentInputAccessoryView = CommentInputAccessoryView(frame: frame)
           commentInputAccessoryView.delegate = self
           return commentInputAccessoryView
       }()
    
      func didSubmit(for comment: String) {
         
        
        
         guard let uid = Auth.auth().currentUser?.uid else{
             return
         }
         
         
         let values = ["text": comment, "creationDate": Date().timeIntervalSince1970, "uid": uid] as [String:Any]
         
         Database.database().reference().child("comments").child(uid).childByAutoId().updateChildValues(values) { (err, ref) in
             
             
             if let err = err {
                           print("Failed to insert comment:", err)
                           return
                       }
             
             print("successfully inserted comment.")
             
             
         }
         
         
         
     }
     
    
    
    
    
    
        

    

    let cellId = "cellId"
    
    
    private lazy var messageInputContainerView:CommentInputAccessoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let commentInputAccessoryView = CommentInputAccessoryView(frame: frame)
        return commentInputAccessoryView
    }()
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        
         showIncomingMessage()
        
        showOutgoingMessage(text: "I’ve saved the bubble image which I created in previous lesson as SVG, and then imported it in PaintCode.")
        
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    func showIncomingMessage() {
        let width: CGFloat = 0.66 * view.frame.width
        let height: CGFloat = width / 0.75

        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 22, y: height))
        bezierPath.addLine(to: CGPoint(x: width - 17, y: height))
        bezierPath.addCurve(to: CGPoint(x: width, y: height - 17), controlPoint1: CGPoint(x: width - 7.61, y: height), controlPoint2: CGPoint(x: width, y: height - 7.61))
        bezierPath.addLine(to: CGPoint(x: width, y: 17))
        bezierPath.addCurve(to: CGPoint(x: width - 17, y: 0), controlPoint1: CGPoint(x: width, y: 7.61), controlPoint2: CGPoint(x: width - 7.61, y: 0))
        bezierPath.addLine(to: CGPoint(x: 21, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 4, y: 17), controlPoint1: CGPoint(x: 11.61, y: 0), controlPoint2: CGPoint(x: 4, y: 7.61))
        bezierPath.addLine(to: CGPoint(x: 4, y: height - 11))
        bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 4, y: height - 1), controlPoint2: CGPoint(x: 0, y: height))
        bezierPath.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
        bezierPath.addCurve(to: CGPoint(x: 11.04, y: height - 4.04), controlPoint1: CGPoint(x: 4.07, y: height + 0.43), controlPoint2: CGPoint(x: 8.16, y: height - 1.06))
        bezierPath.addCurve(to: CGPoint(x: 22, y: height), controlPoint1: CGPoint(x: 16, y: height), controlPoint2: CGPoint(x: 19, y: height))
        bezierPath.close()

        let incomingMessageLayer = CAShapeLayer()
        incomingMessageLayer.path = bezierPath.cgPath
        incomingMessageLayer.frame = CGRect(x: 0,
                                            y: 0,
                                            width: width,
                                            height: height)

        let imageView = UIImageView(image: UIImage(named: "2"))
        imageView.frame.size = CGSize(width: width, height: height)
        imageView.frame = CGRect(x: 40, y: 100, width: 300, height: 250)
       // imageView.frame = view.frame
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.mask = incomingMessageLayer

        view.addSubview(imageView)
    }
    
    
    
    func showOutgoingMessage(text: String) {
        
    let label =  UILabel()
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = .white
    label.text = text

    let constraintRect = CGSize(width: 0.66 * view.frame.width,
                                height: .greatestFiniteMagnitude)
    let boundingBox = text.boundingRect(with: constraintRect,
                                        options: .usesLineFragmentOrigin,
                                        attributes: [.font: label.font],
                                        context: nil)
    label.frame.size = CGSize(width: ceil(boundingBox.width),
                              height: ceil(boundingBox.height))

    let bubbleSize = CGSize(width: label.frame.width + 28,
                                 height: label.frame.height + 20)

    let width = bubbleSize.width
    let height = bubbleSize.height

    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: width - 22, y: height))
    bezierPath.addLine(to: CGPoint(x: 17, y: height))
    bezierPath.addCurve(to: CGPoint(x: 0, y: height - 17), controlPoint1: CGPoint(x: 7.61, y: height), controlPoint2: CGPoint(x: 0, y: height - 7.61))
    bezierPath.addLine(to: CGPoint(x: 0, y: 17))
    bezierPath.addCurve(to: CGPoint(x: 17, y: 0), controlPoint1: CGPoint(x: 0, y: 7.61), controlPoint2: CGPoint(x: 7.61, y: 0))
    bezierPath.addLine(to: CGPoint(x: width - 21, y: 0))
    bezierPath.addCurve(to: CGPoint(x: width - 4, y: 17), controlPoint1: CGPoint(x: width - 11.61, y: 0), controlPoint2: CGPoint(x: width - 4, y: 7.61))
    bezierPath.addLine(to: CGPoint(x: width - 4, y: height - 11))
    bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 4, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
    bezierPath.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
    bezierPath.addCurve(to: CGPoint(x: width - 11.04, y: height - 4.04), controlPoint1: CGPoint(x: width - 4.07, y: height + 0.43), controlPoint2: CGPoint(x: width - 8.16, y: height - 1.06))
    bezierPath.addCurve(to: CGPoint(x: width - 22, y: height), controlPoint1: CGPoint(x: width - 16, y: height), controlPoint2: CGPoint(x: width - 19, y: height))
    bezierPath.close()

    let outgoingMessageLayer = CAShapeLayer()
    outgoingMessageLayer.path = bezierPath.cgPath
    outgoingMessageLayer.frame = CGRect(x: view.frame.width/2 - width/2,
                                        y: view.frame.height/2 - height/2,
                                        width: width,
                                        height: height)
    outgoingMessageLayer.fillColor = UIColor(red: 0.09, green: 0.54, blue: 1, alpha: 1).cgColor

    view.layer.addSublayer(outgoingMessageLayer)

    label.center = view.center
    view.addSubview(label)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
       title = "jwu@oakland.edu"
        
      
        
        
        

        self.tabBarController?.tabBar.isHidden = true
        
        collectionView.backgroundColor = .white
    
        collectionView.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        
       collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
       collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
              
        
        
//        view.addSubview(messageInputContainerView)
//
//        messageInputContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        messageInputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        collectionView.keyboardDismissMode = .interactive
        collectionView.alwaysBounceVertical = true
        
        
//        messageInputContainerView.addSubview(inputTextField)
//        messageInputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        messageInputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        messageInputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
//       
//        
//        messageInputContainerView.addSubview(inputTextField)
//        inputTextField.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor, constant: 20).isActive = true
//        inputTextField.topAnchor.constraint(equalTo: self.messageInputContainerView.topAnchor, constant: 5).isActive = true
//        inputTextField.trailingAnchor.constraint(equalTo: self.messageInputContainerView.trailingAnchor, constant: -50).isActive = true
//        inputTextField.bottomAnchor.constraint(equalTo: self.messageInputContainerView.bottomAnchor, constant: -5).isActive = true
      
     
        
       
        
        
       
        
    }
    
   @objc func handleSendTapped(){
          
        guard let uid = Auth.auth().currentUser?.uid else{
                   return
               }
               
               
    let values = ["text": "hello world", "creationDate": Date().timeIntervalSince1970, "uid": uid] as [String:Any]
               
               Database.database().reference().child("comments").child(uid).childByAutoId().updateChildValues(values) { (err, ref) in
                   
                   
                   if let err = err {
                                 print("Failed to insert comment:", err)
                                 return
                             }
                   
                   print("successfully inserted comment.")
    }
    
    
    
    }
      
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ChatMessageCell
       // cell?.textBubbleView.frame = CGRect(x: 48, y: 48, width: 100, height: 150)
       // cell?.messageTextView.text = "xxxxx"
        
       
        return cell!
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    
   
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    
    
    override var inputAccessoryView: UIView? {
           get {
               return containerView
           }
       }
       
    
    
    
    
    
 
    
    

}



