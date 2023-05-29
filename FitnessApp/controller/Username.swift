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
    let heightTxt = UITextField()
    let cmLbl = UILabel()
    
    
    let continueBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureUserTopic()
        configureOptionLbl()
    
        
        configureHeightTxt()
        
        configureContinueBtn()
        
    }
    
    func configureUserTopic(){
        usernameTopic.text = "Usename"
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
        optionLbl.text = "Enter a username to continue"
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
    
    func configureFeetTxt(){
        feetTxt.text = "Feet"
        feetTxt.textAlignment = .left
        feetTxt.textColor = .white
        feetTxt.translatesAutoresizingMaskIntoConstraints = false
        
        setUpFeetLbl()
        
    }
    
    func setUpFeetLbl(){
        view.addSubview(feetTxt)
        
        NSLayoutConstraint.activate([
            
            feetTxt.widthAnchor.constraint(equalToConstant: 150),
            feetTxt.heightAnchor.constraint(equalToConstant: 40),
            ])
        feetTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        feetTxt.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 25).isActive = true
        
    }
    
    func configureHeightTxt(){
        heightTxt.returnKeyType = .done
        heightTxt.autocorrectionType = .no
        heightTxt.layer.borderWidth = 1.5
        heightTxt.layer.borderColor = UIColor.white.cgColor
        heightTxt.placeholder = "Username"
        heightTxt.autocapitalizationType = .none
        heightTxt.textColor = .white
        heightTxt.textAlignment = .center

        
        setupHeightTxt()
    }
    func setupHeightTxt(){
        self.view.addSubview(heightTxt)
        
        heightTxt.layer.cornerRadius = 5
        heightTxt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            heightTxt.widthAnchor.constraint(equalToConstant: 80),
            heightTxt.heightAnchor.constraint(equalToConstant: 40),
            //heightTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        heightTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 350).isActive = true
        heightTxt.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 130).isActive = true
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
        
        
        continueBtn.addTarget(self, action: #selector(gotoHeight), for: .touchUpInside)
    }
    
    @objc func gotoHeight(){
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        let email = currentUser?.email
        let collectionRef = db.collection("user_tbl")
        let docRef = collectionRef.document(email!)
        
        let height = Height()
        height.title = "Height"
        navigationController?.pushViewController(height, animated: true)
    }

}
