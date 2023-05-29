//
//  Username.swift
//  FitnessApp
//
//  Created by Mac on 2023-05-29.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class Username: UIViewController {
    
    let usernameTopic = UILabel()
    let optionLbl = UILabel()
    let toggleSwitch = UISwitch()
    let feetTxt = UILabel()
    let centiTxt = UILabel()
    let userTxt = UITextField()
    let cmLbl = UILabel()
    
    
    let continueBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureUserTopic()
        configureOptionLbl()
    
        
        configureUserTxt()
        
        configureContinueBtn()
        
    }
    
    func configureUserTopic(){
        usernameTopic.text = "Username"
        usernameTopic.textAlignment = .center
        usernameTopic.textColor = .white
        usernameTopic.font = UIFont(name: usernameTopic.font.fontName, size: 24)
        usernameTopic.translatesAutoresizingMaskIntoConstraints = false
        
        setUpUsernameLbl()
    }
    
    func setUpUsernameLbl(){
        self.view.addSubview(usernameTopic)
        
        NSLayoutConstraint.activate([
            
            usernameTopic.widthAnchor.constraint(equalToConstant: 350),
            usernameTopic.heightAnchor.constraint(equalToConstant: 40),
            usernameTopic.centerXAnchor.constraint(equalTo: usernameTopic.centerXAnchor),
            ])
        usernameTopic.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
    }
    
    func configureOptionLbl(){
        optionLbl.text = "Enter a name to continue"
        optionLbl.textAlignment = .center
        optionLbl.textColor = .gray
        optionLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpOptionLbl()
    }
    
    func setUpOptionLbl(){
        self.view.addSubview(optionLbl)
        
        NSLayoutConstraint.activate([
            
            optionLbl.widthAnchor.constraint(equalToConstant: 350),
            optionLbl.heightAnchor.constraint(equalToConstant: 40),
            optionLbl.centerXAnchor.constraint(equalTo: optionLbl.centerXAnchor),
            ])
        optionLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        
    }
    
    func configureUserTxt(){
        userTxt.returnKeyType = .done
        userTxt.autocorrectionType = .no
        userTxt.layer.borderWidth = 1.5
        userTxt.layer.borderColor = UIColor.white.cgColor
        userTxt.placeholder = "Username"
        userTxt.autocapitalizationType = .none
        userTxt.textColor = .white
        userTxt.textAlignment = .center

        
        setupUserTxt()
    }
    func setupUserTxt(){
        self.view.addSubview(userTxt)
        
        userTxt.layer.cornerRadius = 5
        userTxt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            userTxt.widthAnchor.constraint(equalToConstant: 350),
            userTxt.heightAnchor.constraint(equalToConstant: 40),
            //heightTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        userTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 350).isActive = true
        userTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //userTxt.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 130).isActive = true
    }

    //continue button
    func configureContinueBtn(){
        continueBtn.configuration = .gray()
        continueBtn.configuration?.baseForegroundColor = .black
        continueBtn.configuration?.cornerStyle = .medium
        continueBtn.layer.borderWidth = 1
        continueBtn.layer.borderColor = UIColor.orange.cgColor
        continueBtn.layer.backgroundColor = UIColor.orange.cgColor

        continueBtn.setTitle("Continue", for: .normal)
        //loginBtn.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        continueBtn.semanticContentAttribute = .forceRightToLeft
        
        setupContinueBtn()
    }
    
    func setupContinueBtn(){
        self.view.addSubview(continueBtn)
        
        continueBtn.layer.cornerRadius = 20
        
        continueBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            continueBtn.widthAnchor.constraint(equalToConstant: 320),
            continueBtn.heightAnchor.constraint(equalToConstant: 50),
            continueBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        continueBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -111).isActive = true
        /*loginBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -28).isActive = true*/
        
        
        continueBtn.addTarget(self, action: #selector(gotoHome), for: .touchUpInside)
    }
    
    @objc func gotoHome(){
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        let email = currentUser?.email
        let collectionRef = db.collection("user_tbl")
        let docRef = collectionRef.document(email!)
        
        let home = Home()
        home.title = "Home"
        navigationController?.pushViewController(home, animated: true)
    }

}
