//
//  SignInScreen.swift
//  FitnessApp
//
//  Created by Mac on 2023-05-15.
//

import UIKit
import FirebaseAuth

class SignUpScreen: UIViewController {
    
    let rectrangleView = UIView()
    //let usernameTxt = UITextField();
    let emailTxt = UITextField();
    let passwordTxt = UITextField();
    //let con_passwordTxt = UITextField()
    let loginLbl = UILabel();
    let loginBtn = UIButton();
    let noAccLbl = UILabel();

    override func viewDidLoad() {
        super.viewDidLoad()
        /*let imageName = "welcomeImg.jpg"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)*/
        
        //imageView.frame = CGRect(x: 0, y: 30, width: 475, height: 800)
        //imageView.contentMode = .scaleAspectFill - no need
        //view.addSubview(imageView)
        
        view.backgroundColor = .white
        
        rectrangleView.frame = CGRect(x:0, y: 350, width: 393 , height: 600)
        //rectrangleView.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        rectrangleView.backgroundColor = UIColor.black
        rectrangleView.layer.opacity = 0.9
        rectrangleView.layer.cornerRadius = 90
        self.view.addSubview(rectrangleView)
        configureLoginLableText()
        //configureUsernameTxt()
        configureEmailTxt()
        configurePasswordTxt()
        //configureConPasswordTxt()
        configureSignInBtn()
        configurenoAccLbl()
        
    }
    
    func configurenoAccLbl(){
        noAccLbl.text = "Already have an account"
        noAccLbl.textAlignment = .center
        noAccLbl.textColor = .white
        //loginLbl.font = UIFont(name: loginLbl.font.fontName, size: 28)
        noAccLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpNoAccLbl()
    }
    
    func setUpNoAccLbl(){
        rectrangleView.addSubview(noAccLbl)
        
        NSLayoutConstraint.activate([
            
            noAccLbl.widthAnchor.constraint(equalToConstant: 350),
            noAccLbl.heightAnchor.constraint(equalToConstant: 40),
            noAccLbl.centerXAnchor.constraint(equalTo: rectrangleView.centerXAnchor),
            ])
        noAccLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        
        /*noAccLbl.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoSignIn))
        noAccLbl.addGestureRecognizer(tapGestureRecognizer)*/
        
        noAccLbl.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoSignIn))
        noAccLbl.addGestureRecognizer(tapGestureRecognizer)

    }
    
    /*@objc func gotoSignIn(){
        let login = LoginScreen()
        login.title = "SignIn"
        navigationController?.pushViewController(login, animated: true)
    }*/
    @objc func gotoSignIn(){
        let login = LoginScreen()
        login.title = "SignIn"
        navigationController?.pushViewController(login, animated: true)
    }
    
    func configureSignInBtn(){
        loginBtn.configuration = .gray()
        loginBtn.configuration?.baseForegroundColor = .black
        loginBtn.configuration?.cornerStyle = .medium
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor.orange.cgColor
        loginBtn.layer.backgroundColor = UIColor.orange.cgColor

        loginBtn.setTitle("SignUp", for: .normal)
        //loginBtn.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        loginBtn.semanticContentAttribute = .forceRightToLeft
        
        setupSignInBtn()
    }
    
    func setupSignInBtn(){
        rectrangleView.addSubview(loginBtn)
        
        loginBtn.layer.cornerRadius = 20
        
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginBtn.widthAnchor.constraint(equalToConstant: 350),
            loginBtn.heightAnchor.constraint(equalToConstant: 40),
            loginBtn.centerXAnchor.constraint(equalTo: rectrangleView.centerXAnchor),
            //loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        loginBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -111).isActive = true
        /*loginBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -28).isActive = true*/
        
        
        loginBtn.addTarget(self, action: #selector(gotoProfile), for: .touchUpInside)
    }
    
    @objc func gotoProfile(){
        
        guard let email = emailTxt.text, !email.isEmpty,
              let password = passwordTxt.text, !password.isEmpty else{
            print("Missing field data")
            return
        }
        
        //get auth instance
        //attempt sign in
        //if fail , display err msg
        //if pass continue to create acc
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self]result, error in
            guard let strongSelf = self else{
                return
            }
            guard error == nil else{
                //show acc creation
                strongSelf.showCreateAccount(email : email, password : password)
                return
            }
            print("You have signed in")
            //strongSelf.usernameTxt.isHidden = true
            strongSelf.emailTxt.isHidden = true
            strongSelf.passwordTxt.isHidden = true
            //strongSelf.con_passwordTxt.isHidden = true
        })
        
        
        
        /*let myProfile = MyProfile()
        myProfile.title = "My Profile"
        navigationController?.pushViewController(myProfile, animated: true)*/
    }
    
    func showCreateAccount(email : String, password : String){
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .default,
                                     handler: {_ in
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self ]result,error in
                
                guard let strongSelf = self else{
                    return
                }
                guard error == nil else{
                    //show acc creation
                    print("Account created fail")
                    return
                }
                print("You have signed in")
                let home = Gender()
                self?.navigationController?.pushViewController(home, animated: true)
                
            })
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                     handler: {_ in
            
        }))
        
        present(alert, animated: true)
    }
    
    func configureLoginLableText(){
        loginLbl.text = "SignUp"
        loginLbl.textAlignment = .center
        loginLbl.textColor = .white
        loginLbl.font = UIFont(name: loginLbl.font.fontName, size: 28)
        loginLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpLoginLable()
    }
    func setUpLoginLable(){
        rectrangleView.addSubview(loginLbl)
        
        NSLayoutConstraint.activate([
            
            loginLbl.widthAnchor.constraint(equalToConstant: 350),
            loginLbl.heightAnchor.constraint(equalToConstant: 40),
            loginLbl.centerXAnchor.constraint(equalTo: rectrangleView.centerXAnchor),
            loginLbl.topAnchor.constraint(equalTo: rectrangleView.topAnchor,constant: 15)
            ])
    }

    func configureEmailTxt(){
        emailTxt.returnKeyType = .done
        emailTxt.autocorrectionType = .no
        emailTxt.layer.borderWidth = 1.5
        emailTxt.layer.borderColor = UIColor.white.cgColor
        emailTxt.placeholder = "Email"
        emailTxt.autocapitalizationType = .none
        emailTxt.textColor = .white
        emailTxt.textAlignment = .center
        
        setUpEmailTxt()
    }
    func setUpEmailTxt(){
        rectrangleView.addSubview(emailTxt)
        
        emailTxt.layer.cornerRadius = 20
        emailTxt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            emailTxt.widthAnchor.constraint(equalToConstant: 350),
            emailTxt.heightAnchor.constraint(equalToConstant: 40),
            emailTxt.centerXAnchor.constraint(equalTo: rectrangleView.centerXAnchor),
            emailTxt.topAnchor.constraint(equalTo: rectrangleView.topAnchor,constant: 150)
            
        ])
    }
    
    func configurePasswordTxt(){
        passwordTxt.returnKeyType = .done
        passwordTxt.autocorrectionType = .no
        passwordTxt.layer.borderWidth = 1.5
        passwordTxt.layer.borderColor = UIColor.white.cgColor
        passwordTxt.placeholder =  "Password"
        passwordTxt.textColor = .white
        passwordTxt.textAlignment = .center
        
        setUpPasswordTxt()
    }
    func setUpPasswordTxt(){
        rectrangleView.addSubview(passwordTxt)
        
        passwordTxt.layer.cornerRadius = 20
        passwordTxt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            passwordTxt.widthAnchor.constraint(equalToConstant: 350),
            passwordTxt.heightAnchor.constraint(equalToConstant: 40),
            passwordTxt.centerXAnchor.constraint(equalTo: rectrangleView.centerXAnchor),
            passwordTxt.topAnchor.constraint(equalTo: rectrangleView.topAnchor,constant: 210)
        ])
    }
}
