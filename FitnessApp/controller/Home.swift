//
//  Home.swift
//  FitnessApp
//
//  Created by Mac on 2023-05-16.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

let logOutBtn = UIButton();

var currentTime = Date()
var calendar = Calendar.current

public var hour = calendar.component(.hour, from: currentTime)

class Home: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get data
        /*
        let db = Firestore.firestore()
        db.collection("beginner_tbl").document("exercise1").getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                if let name = data?["exe_name"] as? String {
                    print("Name: \(name)")
                }
                if let age = data?["exe_hours"] as? Int {
                    print("Hours: \(age)")
                }
                //print(data as Any)

            } else {
                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }*/

        
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
    
    let rectrangleStep = UIView()
    let stepValLbl = UILabel();
    let stepsLbl = UILabel();
    
    let rectrangleCal = UIView()
    let calLbl = UILabel();
    let calsLbl = UILabel();
    
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .black
        title = "Home"
        view.addSubview(scrollView)
        scrollView.backgroundColor = .black
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        configureWelcomeLbl()
        configureUserLbl()
        setupStepsContainer()
        setupCalContainer()
        
        setupStackView()
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
        scrollView.addSubview(welcomeLbl)
        
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
        scrollView.addSubview(userLbl)
        
        NSLayoutConstraint.activate([
            
            userLbl.widthAnchor.constraint(equalToConstant: 350),
            userLbl.heightAnchor.constraint(equalToConstant: 40),
            ])
        userLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
        userLbl.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 12).isActive = true
        
    }
    
    //step container
    func setupStepsContainer(){
        rectrangleStep.frame = CGRect(x:30, y: 100, width: 150 , height: 125)
        rectrangleStep.backgroundColor = UIColor.purple
        rectrangleStep.layer.opacity = 0.4
        rectrangleStep.layer.cornerRadius = 20
        scrollView.addSubview(rectrangleStep)
        
        let imageName = "feet.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 50, y: 5, width: 50, height: 50)
        rectrangleStep.addSubview(imageView)
        
        stepsLbl.text = "1500"
        stepsLbl.textAlignment = .center
        stepsLbl.textColor = .white
        stepsLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleStep.addSubview(stepsLbl)
        NSLayoutConstraint.activate([
            
            stepsLbl.widthAnchor.constraint(equalToConstant: 350),
            stepsLbl.heightAnchor.constraint(equalToConstant: 40),
            stepsLbl.centerXAnchor.constraint(equalTo: rectrangleStep.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        stepsLbl.topAnchor.constraint(equalTo: rectrangleStep.topAnchor, constant: 50).isActive = true
        
        stepValLbl.text = "Total steps"
        stepValLbl.textAlignment = .center
        stepValLbl.textColor = .white
        stepValLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleStep.addSubview(stepValLbl)
        NSLayoutConstraint.activate([
            
            stepValLbl.widthAnchor.constraint(equalToConstant: 350),
            stepValLbl.heightAnchor.constraint(equalToConstant: 40),
            stepValLbl.centerXAnchor.constraint(equalTo: rectrangleStep.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        stepValLbl.topAnchor.constraint(equalTo: rectrangleStep.topAnchor, constant: 70).isActive = true
    }
    
    //Calory container
    func setupCalContainer(){
        rectrangleCal.frame = CGRect(x:210, y: 100, width: 150 , height: 125)
        rectrangleCal.backgroundColor = UIColor.purple
        rectrangleCal.layer.opacity = 0.4
        rectrangleCal.layer.cornerRadius = 20
        scrollView.addSubview(rectrangleCal)
        
        let imageName = "kcal.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 50, y: 5, width: 50, height: 50)
        rectrangleCal.addSubview(imageView)
        
        calsLbl.text = "450"
        calsLbl.textAlignment = .center
        calsLbl.textColor = .white
        calsLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleCal.addSubview(calsLbl)
        NSLayoutConstraint.activate([
            
            calsLbl.widthAnchor.constraint(equalToConstant: 350),
            calsLbl.heightAnchor.constraint(equalToConstant: 40),
            calsLbl.centerXAnchor.constraint(equalTo: rectrangleCal.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        calsLbl.topAnchor.constraint(equalTo: rectrangleCal.topAnchor, constant: 50).isActive = true
        
        calLbl.text = "Burned Calories"
        calLbl.textAlignment = .center
        calLbl.textColor = .white
        calLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleCal.addSubview(calLbl)
        NSLayoutConstraint.activate([
            
            calLbl.widthAnchor.constraint(equalToConstant: 350),
            calLbl.heightAnchor.constraint(equalToConstant: 40),
            calLbl.centerXAnchor.constraint(equalTo: rectrangleCal.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        calLbl.topAnchor.constraint(equalTo: rectrangleCal.topAnchor, constant: 70).isActive = true
    }
    
    func setupStackView(){
        let container1 = UIView()
        let container2 = UIView()
        scrollView.addSubview(stackView)
        
        scrollView.frame = CGRect(x: 0, y: 300, width: view.bounds.width, height: view.bounds.height)

        stackView.backgroundColor = .black
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
            stackView.topAnchor.constraint(equalTo: userLbl.topAnchor,constant: 50).isActive = true
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 50).isActive=true

        // Set the content size of the scroll view
        scrollView.contentSize = scrollView.bounds.size
        
        scrollView.addSubview(rectrangleCal)
        scrollView.addSubview(rectrangleStep)

    }
    
    
}

class NotifyVC : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Notify"
    }
}

//profile
class ProfileVC : UIViewController{
    @IBOutlet weak var imageView: UIImageView!
    
    let userLbl = UILabel();
    let joinTimeLbl = UILabel();
    let dateLbl = UILabel();
    let imageButton = UIButton()
    
    let rectrangleTotHr = UIView()
    let totLbl = UILabel();
    let totValLbl = UILabel();
    
    let rectrangleBMI = UIView()
    let BMILbl = UILabel();
    let BMIValLbl = UILabel();
    
    let usernameTxt = UITextField()
    let saveBtn = UIButton();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Profile"
        
        let imageName = "user.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        //imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 120, y: 180, width: 160, height: 160)
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        configureLoginLableText()
        configureImgBtn()
        configureJoinTimeLbl()
        configureDateLbl()
        
        setupTotHrContainer()
        setupBMIContainer()
        
        configureUsernameTxt()
        configureSaveBtn()
        
        
    }
    func configureLoginLableText(){
        userLbl.text = "Minija"
        userLbl.textAlignment = .center
        userLbl.textColor = .white
        userLbl.font = UIFont(name: userLbl.font.fontName, size: 22)
        userLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpUserLable()
    }
    func setUpUserLable(){
        view.addSubview(userLbl)
        
        NSLayoutConstraint.activate([
            
            userLbl.widthAnchor.constraint(equalToConstant: 350),
            userLbl.heightAnchor.constraint(equalToConstant: 40),
            userLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userLbl.bottomAnchor.constraint(equalTo: view.topAnchor,constant: 380)
            ])
    }
    
    func configureImgBtn(){
        imageButton.setImage(UIImage(named: "edit.png"), for: .normal)
        imageButton.imageView?.contentMode = .scaleAspectFit
        imageButton.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
        view.addSubview(imageButton)
        
        setUpImgBtn()
    }
    func setUpImgBtn(){
        
        imageButton.layer.cornerRadius = 20
        
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageButton.widthAnchor.constraint(equalToConstant: 45),
            imageButton.heightAnchor.constraint(equalToConstant: 45),
            imageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        imageButton.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
    }
    
    @objc func imageButtonTapped() {
        // Implement your button tap action here
    }
    
    func configureJoinTimeLbl(){
        joinTimeLbl.text = "Joined"
        joinTimeLbl.textAlignment = .left
        joinTimeLbl.textColor = .gray
        joinTimeLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpJoinTimeLbl()
    }
    func setUpJoinTimeLbl(){
        view.addSubview(joinTimeLbl)
        
        NSLayoutConstraint.activate([
            
            joinTimeLbl.widthAnchor.constraint(equalToConstant: 260),
            joinTimeLbl.heightAnchor.constraint(equalToConstant: 40),
            //joinTimeLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            joinTimeLbl.bottomAnchor.constraint(equalTo: view.topAnchor,constant: 410)
            ])
        joinTimeLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 125).isActive = true
    }
    func configureDateLbl(){
        dateLbl.text = "May 2023"
        dateLbl.textAlignment = .right
        dateLbl.textColor = .gray
        dateLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpDateLbl()
    }
    func setUpDateLbl(){
        view.addSubview(dateLbl)
        
        NSLayoutConstraint.activate([
            
            dateLbl.widthAnchor.constraint(equalToConstant: 260),
            dateLbl.heightAnchor.constraint(equalToConstant: 40),
            dateLbl.bottomAnchor.constraint(equalTo: view.topAnchor,constant: 410)
            ])
        joinTimeLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 50).isActive = true
    }
    
    //tot hour container
    func setupTotHrContainer(){
        rectrangleTotHr.frame = CGRect(x:30, y: 420, width: 150 , height: 70)
        rectrangleTotHr.backgroundColor = UIColor.orange
        rectrangleTotHr.layer.opacity = 0.4
        rectrangleTotHr.layer.cornerRadius = 20
        self.view.addSubview(rectrangleTotHr)
        
        totValLbl.text = "102"
        totValLbl.textAlignment = .center
        totValLbl.textColor = .white
        totValLbl.font = UIFont(name: totValLbl.font.fontName, size: 24)
        totValLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleTotHr.addSubview(totValLbl)
        NSLayoutConstraint.activate([
            
            totValLbl.widthAnchor.constraint(equalToConstant: 350),
            totValLbl.heightAnchor.constraint(equalToConstant: 30),
            totValLbl.centerXAnchor.constraint(equalTo: rectrangleTotHr.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        totValLbl.topAnchor.constraint(equalTo: rectrangleTotHr.topAnchor, constant: 5).isActive = true
        
        totLbl.text = "Total hours"
        totLbl.textAlignment = .center
        totLbl.textColor = .white
        totLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleTotHr.addSubview(totLbl)
        NSLayoutConstraint.activate([
            
            totLbl.widthAnchor.constraint(equalToConstant: 350),
            totLbl.heightAnchor.constraint(equalToConstant: 40),
            totLbl.centerXAnchor.constraint(equalTo: rectrangleTotHr.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        totLbl.topAnchor.constraint(equalTo: rectrangleTotHr.topAnchor, constant: 30).isActive = true
    }
    
    //BMI container
    func setupBMIContainer(){
        rectrangleBMI.frame = CGRect(x:210, y: 420, width: 150 , height: 70)
        rectrangleBMI.backgroundColor = UIColor.orange
        rectrangleBMI.layer.opacity = 0.4
        rectrangleBMI.layer.cornerRadius = 20
        self.view.addSubview(rectrangleBMI)
        
        BMIValLbl.text = "84"
        BMIValLbl.textAlignment = .center
        BMIValLbl.textColor = .white
        BMIValLbl.font = UIFont(name: BMIValLbl.font.fontName, size: 24)
        BMIValLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleBMI.addSubview(BMIValLbl)
        NSLayoutConstraint.activate([
            
            BMIValLbl.widthAnchor.constraint(equalToConstant: 350),
            BMIValLbl.heightAnchor.constraint(equalToConstant: 30),
            BMIValLbl.centerXAnchor.constraint(equalTo: rectrangleBMI.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        BMIValLbl.topAnchor.constraint(equalTo: rectrangleBMI.topAnchor, constant: 5).isActive = true
        
        BMILbl.text = "BMI"
        BMILbl.textAlignment = .center
        BMILbl.textColor = .white
        BMILbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleBMI.addSubview(BMILbl)
        NSLayoutConstraint.activate([
            
            BMILbl.widthAnchor.constraint(equalToConstant: 350),
            BMILbl.heightAnchor.constraint(equalToConstant: 40),
            BMILbl.centerXAnchor.constraint(equalTo: rectrangleBMI.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        BMILbl.topAnchor.constraint(equalTo: rectrangleBMI.topAnchor, constant: 30).isActive = true
    }
    
    //username
    func configureUsernameTxt(){
        usernameTxt.returnKeyType = .done
        usernameTxt.autocorrectionType = .no
        usernameTxt.layer.borderWidth = 1.5
        usernameTxt.layer.borderColor = UIColor.white.cgColor
        usernameTxt.placeholder = "Username"
        usernameTxt.text = ""
        usernameTxt.autocapitalizationType = .none
        usernameTxt.textColor = .gray
        usernameTxt.textAlignment = .center

        
        SetupUsernameTxt()
    }
    func SetupUsernameTxt(){
        self.view.addSubview(usernameTxt)
        
        usernameTxt.layer.cornerRadius = 20
        usernameTxt.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            usernameTxt.widthAnchor.constraint(equalToConstant: 320),
            usernameTxt.heightAnchor.constraint(equalToConstant: 50),
            usernameTxt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        usernameTxt.topAnchor.constraint(equalTo: view.topAnchor, constant: 550).isActive = true
    }
    
    //save button
    func configureSaveBtn(){
        saveBtn.configuration = .gray()
        saveBtn.configuration?.baseForegroundColor = .black
        saveBtn.configuration?.cornerStyle = .medium
        saveBtn.layer.borderWidth = 1
        saveBtn.layer.borderColor = UIColor.orange.cgColor
        saveBtn.layer.backgroundColor = UIColor.orange.cgColor

        saveBtn.setTitle("Save", for: .normal)
        //loginBtn.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        saveBtn.semanticContentAttribute = .forceRightToLeft
        
        setupSaveBtn()
    }
    
    func setupSaveBtn(){
        self.view.addSubview(saveBtn)
        
        saveBtn.layer.cornerRadius = 20
        
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveBtn.widthAnchor.constraint(equalToConstant: 320),
            saveBtn.heightAnchor.constraint(equalToConstant: 50),
            saveBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        saveBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -111).isActive = true
        /*loginBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -28).isActive = true*/
        
        
        //saveBtn.addTarget(self, action: #selector(gotoGoal), for: .touchUpInside)
    }
    

}
