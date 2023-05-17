//
//  Home.swift
//  FitnessApp
//
//  Created by Mac on 2023-05-16.
//

import UIKit
import FirebaseAuth

let logOutBtn = UIButton();

var currentTime = Date()
var calendar = Calendar.current

public var hour = calendar.component(.hour, from: currentTime)

class Home: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tabBar.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        //create instance of view controller
        let landing = LandingVC()
        let notify = NotifyVC()
        let profile = ProfileVC()
        
        configureLogOutBtn()
        
        //ssign view controller to tab bar
        self.setViewControllers([landing,notify,profile], animated: false)
        
        guard let items = self.tabBar.items else{
            return
        }
        let images = ["house","bell","brain.head.profile"]
        
        for x in 0...2{
            items[x].image = UIImage(systemName: images[x])
        }
        
        //change tint color
        self.tabBar.tintColor = .orange
        
        func configureLogOutBtn(){
            logOutBtn.configuration = .gray()
            logOutBtn.configuration?.baseForegroundColor = .black
            logOutBtn.configuration?.cornerStyle = .medium
            logOutBtn.layer.borderWidth = 1
            logOutBtn.layer.borderColor = UIColor.orange.cgColor
            logOutBtn.layer.backgroundColor = UIColor.orange.cgColor

            logOutBtn.setTitle("Logout", for: .normal)
            //loginBtn.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
            logOutBtn.semanticContentAttribute = .forceRightToLeft
            
            setupLogoutBtn()
        }
        
        func setupLogoutBtn(){
            if(FirebaseAuth.Auth.auth().currentUser != nil){
                logOutBtn.isHidden = false
            }else{
                logOutBtn.isHidden = true
            }
            view.addSubview(logOutBtn)
            
            logOutBtn.layer.cornerRadius = 10
            
            logOutBtn.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                logOutBtn.widthAnchor.constraint(equalToConstant: 80),
                logOutBtn.heightAnchor.constraint(equalToConstant: 35),
                //loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
            logOutBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
            logOutBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -28).isActive = true
            

            logOutBtn.addTarget(self, action: #selector(backToLogin), for: .touchUpInside)
        }
        
    }
    @objc func backToLogin(){
        do{
            try FirebaseAuth.Auth.auth().signOut()
            
            let login = LoginScreen()
            self.navigationController?.pushViewController(login, animated: true)
        }
        catch{
            print("An error occured !")
        }
    }
}

//Landing screen

class LandingVC : UIViewController{
    
    let scrollView = UIScrollView()
    let welcomeLbl = UILabel();
    let userLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Home"
        view.addSubview(scrollView)
        scrollView.backgroundColor = .black
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        configureWelcomeLbl()
        configureUserLbl()
    }
    
    func configureWelcomeLbl(){
        if(hour < 12 && hour > 0){
            //welcomeLbl.text = hour.codingKey.stringValue
            welcomeLbl.text = "Good morning"
        }else if (hour < 2 && hour > 12){
            welcomeLbl.text = "Good afternoon"
        }else{
            welcomeLbl.text = "Good evening"
        }
        welcomeLbl.textAlignment = .left
        welcomeLbl.textColor = .white
        welcomeLbl.font = UIFont(name: welcomeLbl.font.fontName, size: 18)
        welcomeLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpWelcomeLbl()
        
    }
    
    func setUpWelcomeLbl(){
        view.addSubview(welcomeLbl)
        
        NSLayoutConstraint.activate([
            
            welcomeLbl.widthAnchor.constraint(equalToConstant: 350),
            welcomeLbl.heightAnchor.constraint(equalToConstant: 40),
            ])
        welcomeLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        welcomeLbl.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 12).isActive = true
    }
    
    func configureUserLbl(){
        userLbl.text = "Minija Migara"
        userLbl.textAlignment = .left
        userLbl.textColor = .white
        userLbl.font = UIFont(name: welcomeLbl.font.fontName, size: 22)
        userLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpUserLbl()
        
    }
    
    func setUpUserLbl(){
        view.addSubview(userLbl)
        
        NSLayoutConstraint.activate([
            
            userLbl.widthAnchor.constraint(equalToConstant: 350),
            userLbl.heightAnchor.constraint(equalToConstant: 40),
            ])
        userLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
        userLbl.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 12).isActive = true
    }
}

class NotifyVC : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Notify"
    }
}

class ProfileVC : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Profile"
    }
}
