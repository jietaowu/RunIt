//
//  LoginController.swift
//  RunIt
//
//  Created by jwu on 3/20/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import JGProgressHUD



class LoginController: UIViewController {

    
    lazy var signInFacebookButton:UIButton = {
        let signInFacebookButton = UIButton(type: .system)
        signInFacebookButton.translatesAutoresizingMaskIntoConstraints = false
        signInFacebookButton.setTitle("Sign in with Facebook", for: UIControl.State.normal)
        signInFacebookButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        signInFacebookButton.backgroundColor = UIColor(red: 58/255, green: 85/255, blue: 159/255, alpha: 1)
        signInFacebookButton.layer.cornerRadius = 5
        signInFacebookButton.clipsToBounds = true
        
        signInFacebookButton.setImage(UIImage(named: "icon-facebook") , for: UIControl.State.normal)
        signInFacebookButton.imageView?.contentMode = .scaleAspectFit
        signInFacebookButton.tintColor = .white
        signInFacebookButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: -15, bottom: 12, right: 0)
        signInFacebookButton.addTarget(self, action: #selector(fbButtonDidTap), for: .touchUpInside)
        return signInFacebookButton
    }()
    
    
    lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 40
        
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var emailTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.textContentType = .emailAddress
        return textField
    }()
    
    lazy var passwordTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.textContentType = .password
        return textField
    }()
    
    
    lazy var signUpButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
        
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signUpButton)
        
        view.addSubview(signInFacebookButton)
        signInFacebookButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 40)
        
        
        //        let loginButton = FBLoginButton(
        //
        //        )
        //        loginButton.addTarget(self, action: #selector(fbButtonDidTap), for: .touchUpInside)
        //        loginButton.translatesAutoresizingMaskIntoConstraints = false
        //        view.addSubview(loginButton)
        //        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        //        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        //        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        
        
        
        
        //
        //        if AccessToken.current != nil{
        //
        //
        //            let mainTabController = MainTabBarController()
        //            mainTabController.modalPresentationStyle = .fullScreen
        //            self.navigationController?.present(mainTabController, animated: true, completion: nil)
        //
        //            var userId = AccessToken.current?.userID
        //
        //
        //            // Extend the code sample from 6a. Add Facebook Login to Your Code
        //            // Add to your viewDidLoad method:
        //            loginButton.permissions = ["public_profile", "email"]
        //
        //        }
        //        }else{
        //
        //            do {
        //                try Auth.auth().signOut()
        //                FBLoginManager.logOut()
        //                self.dismiss(animated: true, completion: nil)
        //            } catch let err {
        //                print(err)
        //            }
        //
        //        }
        
        
        
        
        
    }
    
    @objc func fbButtonDidTap() {
        
        let fbLoginManager = LoginManager()
        
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            
            if let error = error {
                return
            }
            
            guard let accessToken = AccessToken.current else {
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential, completion: { (result, error) in
                if let error = error {
                    return
                }
                

                
                let user = Auth.auth().currentUser
                
                
                guard let uid = user?.uid else {
                    return
                }
                
                
                let mainTabController = MainTabBarController()
                
                UIApplication.shared.keyWindow?.rootViewController = mainTabController
                mainTabController.modalPresentationStyle = .fullScreen
                self.navigationController?.present(mainTabController, animated: true, completion: nil)
                
                
                
                
            })
        }
        
        
    }
    
    
    
    
    
    
    
    
    @objc func handleLogin() {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, err) in
            
            
            
            if let err = err {
                print("Failed to sign in with email:", err)
                return
            }
            
            print("Successfully logged back in with user:", user?.user.uid ?? "")
            
            
            self.dismiss(animated: true, completion: nil)
            
            
            let tabController = MainTabBarController()
            tabController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(tabController, animated: true, completion: nil)
            
        })
    }
    
}
