//
//  MeController.swift
//  RunIt
//
//  Created by jwu on 4/13/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit
import Firebase

class MeController: UIViewController {
    
    
    private lazy var profileImageView:UIImageView = {
        let imageView = UIImageView()
        //imageView.layer.borderWidth = 1
        imageView.image = UIImage(named: "1")
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPhotos))
    
    
    
    
    private lazy var usernameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "谁抢走了我的猪蹄子"
        return label
    }()
    
    
    private lazy var endormentLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.text = "🐷猪都能上天"
        return label
    }()
    
    
    let postsLabel: UILabel = {
        
        let label = UILabel()
    
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "动态", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        
    }()
    
    
    
    let followingLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "关注", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "粉丝", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavigationItems()
        
        
        
        view.backgroundColor = .white
        view.addSubview(profileImageView)
        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 70, height: 70)
        
        
        view.addSubview(usernameLabel)
        usernameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 20)
        
        view.addSubview(endormentLabel)
        endormentLabel.anchor(top: usernameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 15)
        
        setupUserStatsView()
        
        profileImageView.addGestureRecognizer(tapGesture)
        tapGesture.numberOfTouchesRequired = 1
        
        
    }
    
    
    
    fileprivate func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followingLabel, followersLabel])
        
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
    }
    
    
    @objc func showSetting(){
        
        let settingController = SettingController()
        navigationController?.pushViewController(settingController, animated: true)
        
        
    }
    
    
    func setupNavigationItems(){
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        btn.setImage(UIImage(named: "icons8-settings-25"), for: .normal)
        btn.setTitleColor(UIColor.orange, for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        btn.addTarget(self, action: #selector(showSetting), for: .touchUpInside)
        
    }
    
    
    @objc func presentPhotos(sender:UITapGestureRecognizer){
        
        print("tapping")
        
//        let picker = UIImagePickerController()
//
//        picker.sourceType = .photoLibrary
//
//        picker.delegate = self
//
//        self.present(picker, animated: true, completion: nil)
        
        
        
        
    }
    
    
}


extension MeController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageSelected = info[UIImagePickerController.InfoKey.originalImage] {
            
    
           
            
            
        }
        
        dismiss(animated: true, completion: nil)
        

    }
    
    
    
    
    
    
    
    
    
    
}
