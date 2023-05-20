//
//  Landing.swift
//  FitnessApp
//
//  Created by Mac on 2023-05-20.
//

import UIKit
import UIKit
import Firebase
class Home: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        //create instance of view controller
        let landing = Landing()
        let notify = NotifyVC()
        let profile = AccountVC()
        
        
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
    }

}
class NotifyVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
class AccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

class Landing: UIViewController {
    let userLbl = UILabel()
    
    var rectrangleStep = UIView()
    let stepValLbl = UILabel();
    let stepsLbl = UILabel();
    
    let rectrangleCal = UIView()
    let calLbl = UILabel();
    let calsLbl = UILabel();
    
    // Firebase Firestore reference
    let db = Firestore.firestore()
    
    // Data source for the card views
    var Waarmup: [WARMUP] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Fetch the data from Firestore
        db.collection("beginner_tbl").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var newWARMUP: [WARMUP] = []
                for document in querySnapshot!.documents {
                    let Waarmup = WARMUP(snapshot: document)
                    newWARMUP.append(Waarmup)
                }
                self.Waarmup = newWARMUP
                self.addCardViews()
                print("Fetched \(self.Waarmup.count) WARMUP")
            }
        }
        
        // Do any additional setup after loading the view.
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
    
    func addCardViews() {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .black
        
        
        
        var yPosition: CGFloat = 100.0
        let contentWidth = view.frame.width - 40.0
        
        
        // Create a welcome label
        let welcomeLable = UILabel(frame: CGRect(x: 20.0, y: 60, width: contentWidth, height: 30.0))
        welcomeLable.textColor = .white
        welcomeLable.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        scrollView.addSubview(welcomeLable)
        yPosition += 0.0
        
        //welcome text
        if(hour < 12 && hour > 0){
            //welcomeLbl.text = hour.codingKey.stringValue
            welcomeLable.text = "Good morning"
        }else if (hour < 2 && hour > 12){
            welcomeLable.text = "Good afternoon"
        }else{
            welcomeLable.text = "Good evening"
        }
        
        // Create a "logout" button
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.configuration = .gray()
        logoutButton.configuration?.baseForegroundColor = .black
        logoutButton.configuration?.cornerStyle = .medium
        logoutButton.layer.borderColor = UIColor.orange.cgColor
        logoutButton.layer.borderWidth = 1
        logoutButton.layer.backgroundColor = UIColor.orange.cgColor
        logoutButton.layer.cornerRadius = 10.0
        logoutButton.frame = CGRect(x: 20.0, y: 10, width: contentWidth, height: 50.0)
        logoutButton.addTarget(self, action: #selector(backToLogin), for: .touchUpInside)
        scrollView.addSubview(logoutButton)
        yPosition += 0.0
        
        if(FirebaseAuth.Auth.auth().currentUser != nil){
            logoutButton.isHidden = false
        }else{
            logoutButton.isHidden = true
        }
        
        //step container
        rectrangleStep = UIView(frame: CGRect(x: 20.0, y: yPosition, width: 150, height: 125.0))
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
        yPosition += 150.0
        
        //calory container
        rectrangleCal.frame = CGRect(x:210, y: 100, width: 150 , height: 125)
        rectrangleCal.backgroundColor = UIColor.purple
        rectrangleCal.layer.opacity = 0.4
        rectrangleCal.layer.cornerRadius = 20
        scrollView.addSubview(rectrangleCal)
        
        let imageName1 = "kcal.png"
        let image1 = UIImage(named: imageName1)
        let imageView1 = UIImageView(image: image1!)
        
        imageView1.frame = CGRect(x: 50, y: 5, width: 50, height: 50)
        rectrangleCal.addSubview(imageView1)
        
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
        
        for (index, warm) in Waarmup.enumerated() {
            let cardView = UIView(frame: CGRect(x: 20.0, y: yPosition, width: contentWidth, height: 80.0))
            cardView.backgroundColor = .gray
            cardView.layer.cornerRadius = 10.0
            cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            cardView.layer.shadowRadius = 2.0
            cardView.layer.shadowOpacity = 0.2
            cardView.layer.opacity = 0.5
            
            
            let imageName = "runner.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: 10.0, y: 15.0, width: 50.0, height: 50.0)
            cardView.addSubview(imageView)
            
            let nameLabel = UILabel(frame: CGRect(x: 120.0, y: 10.0, width: cardView.frame.width - 70.0, height: 30.0))
            nameLabel.text = warm.exe_name
            nameLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
            cardView.addSubview(nameLabel)
            
            let stackView = UIStackView(frame: CGRect(x: 50.0, y: 55.0, width: cardView.frame.width - 70.0, height: 120.0))
            stackView.axis = .vertical
            stackView.spacing = 5.0
            stackView.distribution = .fillEqually
            
            
            
            let durationLabel = UILabel()
            durationLabel.text = "duration: \(warm.exe_hours)"
            durationLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
            stackView.addArrangedSubview(durationLabel)
            
            /*let repetitionsLabel = UILabel()
            repetitionsLabel.text = "repetitions:\(warm.exe_rep)"
            repetitionsLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
            repetitionsLabel.textAlignment = .left
            stackView.addArrangedSubview(repetitionsLabel)*/
            
            cardView.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20.0),
                stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0),
                stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10.0)
            ])
            
            /*let difficultyIcon = UIImageView(image: UIImage(systemName: "bolt.fill"))
            difficultyIcon.tintColor = .systemYellow
            difficultyIcon.frame = CGRect(x: cardView.frame.width - 45.0, y: 25.0, width: 20.0, height: 20.0)
            cardView.addSubview(difficultyIcon)*/
            
            let imageName1 = "play-button.png"
            let image1 = UIImage(named: imageName1)
            let imageView1 = UIImageView(image: image1!)
            imageView1.frame = CGRect(x: cardView.frame.width - 55.0, y: 25.0, width: 30.0, height: 30.0)
            cardView.addSubview(imageView1)
            
            // Add a tap gesture recognizer to the card view
            //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped(_:)))
            //cardView.addGestureRecognizer(tapGesture)
            cardView.isUserInteractionEnabled = true
            cardView.tag = index
            
            scrollView.addSubview(cardView)
            
            yPosition += 100.0
        }
        // Set the content size of the scroll view
        let contentHeight = yPosition + 20.0
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        // Add the scroll view to the main view
        view.addSubview(scrollView)
        
        
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
