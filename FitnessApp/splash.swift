//
//  ViewController.swift
//  FitnessApp
//
//  Created by Mac on 2023-05-14.
//

import UIKit

class splash: UIViewController {

    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageName = "loginImg.jpg"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 550, height: 800)
        //imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        nextButton.addTarget(self, action: #selector(startHighlight), for: .touchDown)
        nextButton.addTarget(self, action: #selector(stopHighlight), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(stopHighlight), for: .touchUpOutside)

        configureButton()
    }
    func configureButton(){
        nextButton.configuration = .gray()
        nextButton.configuration?.baseForegroundColor = .systemPink
        nextButton.configuration?.cornerStyle = .medium
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.white.cgColor

        nextButton.setTitle("Get Started", for: .normal)
        nextButton.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        nextButton.semanticContentAttribute = .forceRightToLeft
        //nextButton.configuration = .filled()
        //nextButton.configuration?.baseBackgroundColor = .systemPink
        setupButton()
    }
    func setupButton(){
        view.addSubview(nextButton)
        
        nextButton.layer.cornerRadius = 20
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        //nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        //nextButton.addTarget(self, action: #selector(gotoLogin), for: .touchUpInside)
    }
    @objc func startHighlight(sender: UIButton) {
        nextButton.layer.borderColor = UIColor.systemPink.cgColor
        nextButton.layer.borderWidth = 1
    }
    @objc func stopHighlight(sender: UIButton) {
        nextButton.layer.borderColor = UIColor.white.cgColor
        nextButton.layer.borderWidth = 1
    }
    /*
    @objc func gotoLogin(){
        let loginScreen = LoginScreen()
        loginScreen.title = "Login"
        navigationController?.pushViewController(loginScreen, animated: true)
    }*/
}

