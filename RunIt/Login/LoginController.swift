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
import GoogleSignIn


class LoginController: UIViewController, GIDSignInDelegate{
    
    //--------------------------------------------------------------------------
    // MARK:    Google login
    //--------------------------------------------------------------------------
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
        
        
        let dimension = round(100 * UIScreen.main.scale)
        
        let profileImageURL = user.profile.imageURL(withDimension: 400)?.absoluteString
        
        guard let url = NSURL(string: profileImageURL ?? "") as? URL else {
            return
        }
        
        
        guard let auth = user.authentication else { return }
        
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        
        

        Auth.auth().signIn(with: credentials) { (authResult, error) in
            
            
            UserDefaults.standard.setValue(profileImageURL, forKey: "profileImage")
            
            let uid = Api.User.currentUserId
            
            let user = Auth.auth().currentUser
            
        
            let dictionaryValues = ["email": user?.email, "username": fullName, "profileImage": profileImageURL]
            
            
            let values = [uid:dictionaryValues]
            
            let ref = Ref().databaseUsers.child("users").updateChildValues(values) { (err, ref) in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                } else {
                    
                    self.dismiss(animated: true, completion: nil)
                    
                    let tabController = MainTabBarController()
                    tabController.modalPresentationStyle = .fullScreen
                    self.navigationController?.present(tabController, animated: true, completion: nil)
                    
                    

                }
                
                
                
            }
            
            
        }
        
        
        
    }
    
    
    //--------------------------------------------------------------------------
    // MARK:    Facebook login
    //--------------------------------------------------------------------------
    lazy var signInFacebookButton:UIButton = {
        let signInFacebookButton = UIButton(type: .system)
        signInFacebookButton.setTitle("Facebook", for: UIControl.State.normal)
        signInFacebookButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        signInFacebookButton.backgroundColor = UIColor.rgb(red: 58, green: 85, blue: 159)
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
    
    //--------------------------------------------------------------------------
    // MARK:    Google login
    //--------------------------------------------------------------------------
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
    
    
    lazy var loginStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 40
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var emailTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.textContentType = .emailAddress
        return textField
    }()
    
    lazy var passwordTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.textContentType = .password
        return textField
    }()
    
    
    lazy var loginButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
        
    }()
    
    
    //--------------------------------------------------------------------------
    // MARK:    Don't have an account ?
    //--------------------------------------------------------------------------
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)
        ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    //--------------------------------------------------------------------------
    // MARK:    Terms of Service
    //--------------------------------------------------------------------------
    
    lazy var termsOfServiceLabel:UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        return label
    }()
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
        
        
        view.backgroundColor = .white
        view.addSubview(loginStackView)
        loginStackView.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        loginStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        loginStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        
        loginStackView.addArrangedSubview(emailTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        loginStackView.addArrangedSubview(loginButton)
        
        view.addSubview(dontHaveAccountButton)
        
        dontHaveAccountButton.anchor(top: loginStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        
        authStackView.addArrangedSubview(signInFacebookButton)
        authStackView.addArrangedSubview(signInGoogleButton)
        view.addSubview(authStackView)
        authStackView.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 50, paddingRight: 20, width: 0, height: 50)
        
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        
        
        view.addSubview(termsOfServiceLabel)
        termsOfServiceLabel.anchor(top: authStackView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: -20, width: 0, height: 30)
        
        setupTerms()
        
        
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
            
            
            var email:String?
            var username:String?
            var FBuid:String?
            
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields" : "id, email, name,picture.width(480).height(480)"]  )
            graphRequest.start { (connection, result, error) in
                
                if error != nil{
                    print(error?.localizedDescription)
                }
                
                
                let data = result as? [String:Any]
                
                let FBid = data?["id"] as? String
                
                let useremail = data?["email"] as? String
                
                let name = data?["name"] as? String
                
                connection?.start()
                
                
                email = useremail
                username = name
                FBuid = FBid
                
                
            }
            
            
            Auth.auth().signIn(with: credential, completion: { (result, error) in
                
                if error != nil {
                    return
                }
                
                let user = Auth.auth().currentUser
                
                guard let uid = user?.uid else {
                    return
                }
                
                
                guard let profileImageUID = FBuid else{
                    return
                }
                
                let url = "https://graph.facebook.com/\(profileImageUID)/picture?type=large&return_ssl_resources=1"
                
                
                
                let dictionaryValues = ["email": email , "username": username, "profileImage": url]
                
                
                let values = [uid:dictionaryValues]
                
                
                
                
                Database.database().reference().child("users").updateChildValues(values) { (err, ref) in
                    
                    
                    if let error = error {
                        
                        print(error.localizedDescription)
                        
                    } else {
                        
                        print("Login Successful.")
                        
                        self.dismiss(animated: true, completion: nil)
                        
                        let tabController = MainTabBarController()
                        tabController.modalPresentationStyle = .fullScreen
                        self.navigationController?.present(tabController, animated: true, completion: nil)
                        
                        
                    }
                }
                
            })
            
        }
        
    }
    
    @objc func handleShowSignUp() {
        
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
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
    
    
    func setupTerms()  {
        
        
        let attributedTermsText = NSMutableAttributedString(string: "By signing in you agree to the ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.65)                                                                      ])
        let attributedSubTermsText = NSMutableAttributedString(string: "Terms of Service and Privacy Policy", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor : UIColor(white: 0, alpha: 0.65)                                                                      ])
        attributedTermsText.append(attributedSubTermsText)
        
        termsOfServiceLabel.attributedText = attributedTermsText
        termsOfServiceLabel.numberOfLines = 0
        termsOfServiceLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLabel(gesture:))))
        
    }
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        
        let txt = termsOfServiceLabel.text
        
        let termsRange = (txt as! NSString).range(of: "Terms of Service and Privacy Policy")
        
        if gesture.didTapAttributedTextInLabel(label: termsOfServiceLabel, inRange: termsRange){
            
            guard let url = URL(string: "https://stackoverflow.com") else { return }
            UIApplication.shared.open(url)
            
        }
        
        
    }
    
    
    
    func setupNavigationItems()  {
        
        navigationController?.isNavigationBarHidden = true
        
    }
    
    
}





