//
//  InboxController.swift
//  RunIt
//
//  Created by jwu on 2/16/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage


class ChatController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    let cellId = "cellId"
    
    var messages = [Message]()
    
    var imagePartner:UIImage?
    var partnerUsername:String?
    var partnerId:String?
    
    
    var bottomConstraint: NSLayoutConstraint?
    var keyboardHeight:CGFloat = 0
    
    var topLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    
    
    var tableView:UITableView = UITableView()
    
    lazy var messageInputContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icons8-image-25"), for: .normal)
        button.addTarget(self, action: #selector(addImageButton), for: .touchUpInside)
        return button
    }()
    
    
    let inputMessageTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Aa"
        return textField
    }()
    
    
    let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()

        self.tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 50, paddingRight: 0, width: 0, height: 0)
        tableView.backgroundColor = .white
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.alwaysBounceVertical = true
        tableView.keyboardDismissMode = .interactive
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchMessages()
        
        setupContainerView()
        

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSendTapped()
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    
    
    @objc func handleSendTapped(){
        
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        if let text = inputMessageTextField.text, text != nil {
            sendToFirebase(dict:["text": text as Any])
        }
        
        
        inputMessageTextField.text = ""
        
        inputMessageTextField.resignFirstResponder()
        
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ChatMessageCell
        
        cell?.isUserInteractionEnabled = true
        cell?.messageLabel.text = messages[indexPath.row].text
        cell?.timeLabel.text = messages[indexPath.row].date as? String
        
        
        let profileImageURL = UserDefaults.standard.string(forKey: "profileImage")
        
        cell?.avatar.sd_setImage(with: URL(string: profileImageURL!), completed: nil)
        
        cell!.configureCell(uid: Auth.auth().currentUser!.uid, message:messages[indexPath.row], image: imagePartner!)
        
        return cell!
        
        
    }
    

    @objc func fetchMessages(){
        
        var to = Auth.auth().currentUser!.uid
        
        receiveMessage(from: partnerId ?? "", to: to)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.scrollToBottom()
        }
        
        
    }
    
    
    func scrollToBottom() {
        if messages.count > 0 {
            let index = IndexPath(row: messages.count - 1, section: 0)
            tableView.scrollToRow(at: index, at: UITableView.ScrollPosition.bottom, animated: false)
        }
    }
    
    
    
    func setupContainerView() {
        
        inputMessageTextField.returnKeyType = .go
        inputMessageTextField.delegate = self
        
        view.addSubview(messageInputContainerView)
        
        
        let constraints = [
            
            messageInputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            messageInputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            messageInputContainerView.heightAnchor.constraint(equalToConstant: 50),
            messageInputContainerView.widthAnchor.constraint(equalToConstant: view.frame.width)
        
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        
        bottomConstraint = messageInputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomConstraint?.isActive = true
        
        
        messageInputContainerView.addSubview(imageButton)
        imageButton.anchor(top: nil, left: messageInputContainerView.leftAnchor, bottom: messageInputContainerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: -10, paddingRight: 10, width: 40, height: 40)
        
        messageInputContainerView.addSubview(inputMessageTextField)
        messageInputContainerView.addSubview(bottomLineView)
        bottomLineView.anchor(top: nil, left: messageInputContainerView.leftAnchor, bottom: messageInputContainerView.bottomAnchor, right: messageInputContainerView.rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 1)
    
        inputMessageTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1).isActive = true
        
        inputMessageTextField.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor, constant: 50).isActive = true
        inputMessageTextField.trailingAnchor.constraint(equalTo: messageInputContainerView.trailingAnchor, constant: -50).isActive = true
        
    }
    
}


extension ChatController{
    
    func sendToFirebase(dict: Dictionary<String,Any>)  {
        
        let date:Double = Date().timeIntervalSince1970
        var value = dict
        value["from"] = Auth.auth().currentUser?.uid
        value["to"] = partnerId
        value["date"] = date
        value["read"] = true
        
        sendMessage(from: Auth.auth().currentUser!.uid, to: partnerId ?? "", value: value)
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.scrollToBottom()
        }
        
    }
    
    
    
    //send messages
    func sendMessage(from:String, to:String, value:Dictionary<String,Any>)  {
        
        let channelId = Message.hash(forMembers: [from,to])
        
        let ref = Database.database().reference().child("feedMessages").child(channelId)
        ref.childByAutoId().updateChildValues(value)
        
        var dict = value
        
        let refFromInbox = Database.database().reference().child(REF_INBOX).child(from).child(channelId)
        refFromInbox.updateChildValues(dict)
        
        let refToInbox = Database.database().reference().child(REF_INBOX).child(to).child(channelId)
        refToInbox.updateChildValues(dict)
        
        tableView.reloadData()
        
        
    }
    
    
    //接受短信
    func receiveMessage(from:String, to:String)  {
        
        let channel = Message.hash(forMembers: [from, to])
        
        let ref = Database.database().reference().child("feedMessages").child(channel)
        ref.queryOrderedByKey().queryLimited(toLast: 5).observe(.childAdded) { (snapchat) in
            
            if let dict = snapchat.value as? Dictionary<String, Any> {
                
                if let message = Message.transformMessage(dict: dict, keyId: snapchat.key){
                    self.messages.append(message)
                    
                    self.tableView.reloadData()
                }
                
            }
            
            
        }
        
    }
    
    
    @objc func addImageButton(){
        
        var pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    
    @objc func adjustForKeyboard(notification: Notification) {
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            bottomConstraint?.constant = 0
        } else {
            if #available(iOS 11.0, *) {
                bottomConstraint?.constant = -keyboardViewEndFrame.height + view.safeAreaInsets.bottom - 10
                
            } else {
                bottomConstraint?.constant = -keyboardViewEndFrame.height
            }
        }
        
        
        UIView.animate(withDuration: 5, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
    }
    
    
    func setupNavigationItems()  {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = topLabel
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 0
        
        let attributed = NSMutableAttributedString(string: partnerUsername ?? "" , attributes: [.font : UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.black])
        
        attributed.append(NSAttributedString(string: "\n"))
        
        attributed.append(NSAttributedString(string: "手机在线", attributes: [.font : UIFont.systemFont(ofSize: 10), .foregroundColor: UIColor.black]))
        topLabel.attributedText = attributed
    }
    
    
    
    
}


extension ChatController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        
    }
    
    
    
    func handleImageSelectedForInfo(_ info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = imageSelected
            print(selectedImageFromPicker)
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = imageOriginal
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
}
