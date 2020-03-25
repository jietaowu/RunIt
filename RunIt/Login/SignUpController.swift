//
//  AuthController.swift
//  RunIt
//
//  Created by jwu on 2/15/20.
//  Copyright © 2020 jwu. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit


class SignUpController: UIViewController, LoginButtonDelegate {
    
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
        return textField
    }()
    
    lazy var passwordTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        return textField
    }()
    
   
    
    lazy var signUpButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.setTitle("Sign Up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
        
    }()
    
    
    
    let alreadyHaveAccountButton: UIButton = {
           let button = UIButton(type: .system)
           
           let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
           
           attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)
               ]))
           
           button.setAttributedTitle(attributedTitle, for: .normal)
           
           button.addTarget(self, action: #selector(handleAlreadyHaveAccount), for: .touchUpInside)
           return button
       }()
    
    let FBLoginManager = LoginManager()
    
    @objc func handleAlreadyHaveAccount() {
        
        let loginController = LoginController()
        loginController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(loginController, animated: true)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let error = error{
            print(error.localizedDescription)
            return
        }
        
        
        
        FBLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            
        
            Auth.auth().signIn(with: credential) { (user, error) in
                
                
                if let err = error{
                    print("failed to create user:", err)
                    return
                }
                
                
                let user = Auth.auth().currentUser
                
                
                guard let uid = user?.uid else {
                    return
                }
                
                
                let dictionaryValues = ["email": user?.email]
                
                
                let values = [uid:dictionaryValues]
                
                
                Database.database().reference().child("users").updateChildValues(values) { (err, ref) in
                    
                    if let error = err{
                        print("Failed to save user info into db:", err)
                        return
                    }
                    
                
                    
                    print("Successfully saved user info to db")
                    
                    
                let mainTabController = MainTabBarController()
                           mainTabController.modalPresentationStyle = .fullScreen
                           self.navigationController?.present(mainTabController, animated: true, completion: nil)
                
            
                
                }
                
            }
            
            
            

            
        }
        
    
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("user logged in")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
    
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signUpButton)
        
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        
        let loginButton = FBLoginButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        
        loginButton.delegate = self
        
        if AccessToken.current != nil{
            
            let mainTabController = MainTabBarController()
            mainTabController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(mainTabController, animated: true, completion: nil)
            
            var userId = AccessToken.current?.userID
            
            
            // Extend the code sample from 6a. Add Facebook Login to Your Code
            // Add to your viewDidLoad method:
            loginButton.permissions = ["public_profile", "email"]
            
            
        }else{
           
            
            do {
                try Auth.auth().signOut()
                FBLoginManager.logOut()
                self.dismiss(animated: true, completion: nil)
                } catch let err {
                    print(err)
            }
        }
        
        
        
        
        
        
    }
    
    @objc func handleSignUp()  {
        
        guard let Email = emailTextField.text, let Password = passwordTextField.text else {
            return
        }
        
        
        Auth.auth().createUser(withEmail: Email, password: Password) { (result, error:Error?) in
            
            if let err = error{
                print("failed to create user:", err)
                return
            }
            
            
            let user = Auth.auth().currentUser
            
            
            guard let uid = user?.uid else {
                return
            }
            
            
            let dictionaryValues = ["email": user?.email]
            
            
            let values = [uid:dictionaryValues]
            
            
            Database.database().reference().child("users").updateChildValues(values) { (err, ref) in
                
                if let error = err{
                    print("Failed to save user info into db:", err)
                    return
                }
                
            
                
                print("Successfully saved user info to db")
                
                
            }
            
            let messageController = MessageController()
            messageController.modalPresentationStyle = .fullScreen
            self.present(messageController, animated: true, completion: nil)
            
            
            
        }
        
        
        
    }
    
    
    func setupNavBar()  {
        
        navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.barTintColor = .white
        
        
    }
    
    
    
    
}
