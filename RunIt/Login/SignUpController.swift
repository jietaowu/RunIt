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
import GoogleSignIn


class SignUpController: UIViewController, GIDSignInDelegate{
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let userId = user.userID
        let idToken = user.authentication.idToken
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        
        
        guard let auth = user.authentication else { return }
        
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        
        
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            
            
            let user = Auth.auth().currentUser
            
            guard let uid = user?.uid else {
                return
            }
            
            
            let dictionaryValues = ["uid": uid, "email": user?.email, "name": fullName]
            
            
            let values = [uid:dictionaryValues]
            
            
            Database.database().reference().child("users").updateChildValues(values) { (err, ref) in
                
                if let error = err{
                    print("Failed to save user info into db:", err)
                    return
                }
                
                print("Successfully saved user info to db")
                
                
            }
            
            if let error = error {
                print(error.localizedDescription)
                print("failed")
            } else {
                
                print("Login Successful.")
                
                self.dismiss(animated: true, completion: nil)
                
                let tabController = MainTabBarController()
                tabController.modalPresentationStyle = .fullScreen
                self.navigationController?.present(tabController, animated: true, completion: nil)
                
            }
            
            
        }
        
        
    }
    
    
    lazy var signUpStackView:UIStackView = {
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
    
    
    //authentication
    
    lazy var signInFacebookButton:UIButton = {
        let signInFacebookButton = UIButton(type: .system)
        signInFacebookButton.setTitle("Facebook", for: UIControl.State.normal)
        signInFacebookButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        signInFacebookButton.backgroundColor = UIColor(red: 58/255, green: 85/255, blue: 159/255, alpha: 1)
        signInFacebookButton.layer.cornerRadius = 5
        signInFacebookButton.layer.borderWidth = 1
        signInFacebookButton.layer.borderColor = UIColor(red: 58/255, green: 85/255, blue: 159/255, alpha: 1).cgColor
        signInFacebookButton.clipsToBounds = true
        signInFacebookButton.setImage(UIImage(named: "icons8-facebook-old-25")?.withRenderingMode(.alwaysOriginal) , for: UIControl.State.normal)
        signInFacebookButton.imageView?.contentMode = .scaleAspectFit
        signInFacebookButton.tintColor = .white
        signInFacebookButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: -15, bottom: 12, right: 0)
        signInFacebookButton.addTarget(self, action: #selector(fbButtonDidTap), for: .touchUpInside)
        return signInFacebookButton
    }()
    
    
    lazy var signInGoogleButton:UIButton = {
        let signInGoogleButton = UIButton(type: .system)
        signInGoogleButton.setTitle("Google", for: UIControl.State.normal)
        signInGoogleButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        signInGoogleButton.backgroundColor = .white
        signInGoogleButton.layer.cornerRadius = 5
        signInGoogleButton.clipsToBounds = true
        signInGoogleButton.layer.borderWidth = 1
        signInGoogleButton.layer.borderColor = UIColor.rgb(red: 244, green: 244, blue: 244).cgColor
        signInGoogleButton.setImage(UIImage(named: "icons8-google-25")?.withRenderingMode(.alwaysOriginal) , for: UIControl.State.normal)
        signInGoogleButton.imageView?.contentMode = .scaleAspectFit
        signInGoogleButton.tintColor = .black
        signInGoogleButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: -35, bottom: 12, right: 0)
        signInGoogleButton.addTarget(self, action: #selector(ggButtonDidTap), for: .touchUpInside)
        return signInGoogleButton
        
    }()
    
    
    lazy var authStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 40
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
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
                
                
                let dictionaryValues = ["uid": uid, "email": user?.email, "name" : user?.displayName]
                
                
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
        
        view.addSubview(signUpStackView)
        signUpStackView.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        signUpStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        signUpStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        
        signUpStackView.addArrangedSubview(emailTextField)
        signUpStackView.addArrangedSubview(passwordTextField)
        signUpStackView.addArrangedSubview(signUpButton)
        
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        
        authStackView.addArrangedSubview(signInFacebookButton)
        authStackView.addArrangedSubview(signInGoogleButton)
        view.addSubview(authStackView)
        authStackView.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 50, paddingRight: 20, width: 0, height: 50)
        
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        
        
        
        
        
        
        
        if AccessToken.current != nil{
            
            let mainTabController = MainTabBarController()
            mainTabController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(mainTabController, animated: true, completion: nil)
            
            var userId = AccessToken.current?.userID
            
            
            // Extend the code sample from 6a. Add Facebook Login to Your Code
            // Add to your viewDidLoad method:
            
            
            
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
    
    
    @objc func ggButtonDidTap(){
        
        GIDSignIn.sharedInstance()?.signIn()
        
        
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
            
            let messageController = InboxController()
            messageController.modalPresentationStyle = .fullScreen
            self.present(messageController, animated: true, completion: nil)
            
            
            
        }
        
        
        
    }
    
    
    func setupNavBar()  {
        
        navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.barTintColor = .white
        
        
    }
    
    
    
    
}
