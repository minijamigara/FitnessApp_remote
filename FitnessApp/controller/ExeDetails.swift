//
//  ExeDetails.swift
//  FitnessApp
//
//  Created by Mac on 2023-05-19.
//

import UIKit


class ExeDetails: UIViewController {
    
    let exeName = UILabel()
    let exeDes = UILabel()
    
    let rectrangleSets = UIView()
    let setsLbl = UILabel();
    let setValLbl = UILabel();
    
    let rectrangleReps = UIView()
    let repsLbl = UILabel();
    let repValLbl = UILabel();
    
    let TimerLbl = UILabel()
    let StartStopBtn = UIButton()
    let resetBtn = UIButton()
    
    var timer : Timer = Timer()
    var count : Int = 0
    var timeCounting : Bool = false
    
    let warmUp: WARMUP

    init(warmUp: WARMUP) {
        self.warmUp = warmUp
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupExerciseContainer()
        configureName()
        configureDes()
        configureSetContainer()
        configureRepContainer()
        
        configureTimeLbl()
        configureStartBtn()
        configureResetBtn()
        
        StartStopBtn.setTitleColor(UIColor.gray, for: .normal)
        //TimerLbl.frame = CGRect(x: 0, y: 400, width: 200, height: 50)
                      
        
    }
    
    func configureTimeLbl(){
        TimerLbl.text = "00:00:00"
        TimerLbl.textAlignment = .center
        TimerLbl.textColor = .white
        TimerLbl.font = UIFont(name: TimerLbl.font.fontName, size: 24)
        TimerLbl.translatesAutoresizingMaskIntoConstraints = false
        
        setUpTimeLbl()
    }
    
    func setUpTimeLbl(){
        self.view.addSubview(TimerLbl)
        
        NSLayoutConstraint.activate([
            
            TimerLbl.widthAnchor.constraint(equalToConstant: 350),
            TimerLbl.heightAnchor.constraint(equalToConstant: 40),
            TimerLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
        TimerLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 480).isActive = true
        
    }
    
    //start stop button
    func configureStartBtn(){
        StartStopBtn.configuration = .gray()
        //StartStopBtn.configuration?.baseForegroundColor = .black
        StartStopBtn.configuration?.cornerStyle = .medium
        StartStopBtn.layer.borderWidth = 1
        StartStopBtn.layer.borderColor = UIColor.orange.cgColor
        StartStopBtn.layer.backgroundColor = UIColor.orange.cgColor

        StartStopBtn.setTitle("Start", for: .normal)
        //loginBtn.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        StartStopBtn.semanticContentAttribute = .forceRightToLeft
        
        setupStartBtn()
    }
    
    func setupStartBtn(){
        self.view.addSubview(StartStopBtn)
        
        StartStopBtn.layer.cornerRadius = 5
        
        StartStopBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            StartStopBtn.widthAnchor.constraint(equalToConstant: 150),
            StartStopBtn.heightAnchor.constraint(equalToConstant: 45),
            StartStopBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),

        ])
        StartStopBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 515).isActive = true
        StartStopBtn.addTarget(self, action: #selector(startStopTapped), for: .touchUpInside)
    }
    
    //reset button
    func configureResetBtn(){
        resetBtn.configuration = .gray()
        //resetBtn.configuration?.baseForegroundColor = .black
        resetBtn.configuration?.cornerStyle = .medium
        resetBtn.layer.borderWidth = 1
        resetBtn.layer.borderColor = UIColor.orange.cgColor
        resetBtn.layer.backgroundColor = UIColor.orange.cgColor

        resetBtn.setTitle("Reset", for: .normal)
        resetBtn.setTitleColor(UIColor.gray, for: .normal)
        //loginBtn.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        resetBtn.semanticContentAttribute = .forceRightToLeft
        
        setupResetBtn()
    }
    
    func setupResetBtn(){
        self.view.addSubview(resetBtn)
        
        resetBtn.layer.cornerRadius = 5
        
        resetBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resetBtn.widthAnchor.constraint(equalToConstant: 150),
            resetBtn.heightAnchor.constraint(equalToConstant: 45),
            resetBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 225),

        ])
        resetBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 515).isActive = true
        resetBtn.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
    }
    
    
    @objc func resetTapped(_sender : Any){
        let alert = UIAlertController(title: "Reset timer?", message: "Are you sure you would like to reset timer", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_)in
            
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(_)in
            self.count = 0
            self.timer.invalidate()
            self.TimerLbl.text = self.makeTimeString(hours: 0, minutes: 0, seconda: 0)
            self.StartStopBtn.setTitle("Start", for: .normal)
            self.StartStopBtn.setTitleColor(UIColor.gray, for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func startStopTapped(_sender : Any){
        if(timeCounting){
            timeCounting = false
            timer.invalidate()
            StartStopBtn.setTitle("START", for: .normal)
            StartStopBtn.setTitleColor(UIColor.gray, for: .normal)
        }else{
            timeCounting = true
            StartStopBtn.setTitle("STOP", for: .normal)
            StartStopBtn.setTitleColor(UIColor.gray, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func timerCounter() -> Void{
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconda: time.2)
        TimerLbl.text = timeString
    }
    func secondsToHoursMinutesSeconds(seconds : Int) -> (Int, Int, Int){
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours : Int, minutes : Int, seconda : Int) -> String{
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconda)
        return timeString
        
    }
    
    func setupExerciseContainer(){
        let imageName = "exe1.jpeg"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: 0, y: 0, width: 400, height: 250)
        imageView.layer.cornerRadius = 20
        view.addSubview(imageView)
    }
    
    func configureName(){
        exeName.text = warmUp.exe_name
        exeName.textAlignment = .center
        exeName.textColor = .white
        exeName.font = UIFont(name: exeName.font.fontName, size: 24)
        exeName.translatesAutoresizingMaskIntoConstraints = false
        
        setUpNameLbl()
    }
    
    func setUpNameLbl(){
        self.view.addSubview(exeName)
        
        NSLayoutConstraint.activate([
            
            exeName.widthAnchor.constraint(equalToConstant: 350),
            exeName.heightAnchor.constraint(equalToConstant: 40),
            exeName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
        exeName.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        
    }
    
    func configureDes(){
        exeDes.text = warmUp.exe_des
        exeDes.numberOfLines = 25
        exeDes.textAlignment = .center
        exeDes.textColor = .white
        exeDes.translatesAutoresizingMaskIntoConstraints = false
        
        setUpDesLbl()
    }
    
    func setUpDesLbl(){
        self.view.addSubview(exeDes)
        
        NSLayoutConstraint.activate([
            
            exeDes.widthAnchor.constraint(equalToConstant: 350),
            exeDes.heightAnchor.constraint(equalToConstant: 100),
            exeDes.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            exeDes.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
            exeDes.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 10),
        ])
        exeDes.topAnchor.constraint(equalTo: view.topAnchor, constant: 280).isActive = true
    }
    
    //sets container
    func configureSetContainer(){
        rectrangleSets.frame = CGRect(x:30, y: 410, width: 150 , height: 70)
        rectrangleSets.backgroundColor = UIColor.purple
        rectrangleSets.layer.opacity = 0.4
        rectrangleSets.layer.cornerRadius = 20
        self.view.addSubview(rectrangleSets)
        
        setValLbl.text = String(warmUp.exe_set)
        setValLbl.textAlignment = .center
        setValLbl.textColor = .white
        setValLbl.font = UIFont(name: setValLbl.font.fontName, size: 24)
        setValLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleSets.addSubview(setValLbl)
        NSLayoutConstraint.activate([
            
            setValLbl.widthAnchor.constraint(equalToConstant: 350),
            setValLbl.heightAnchor.constraint(equalToConstant: 30),
            setValLbl.centerXAnchor.constraint(equalTo: rectrangleSets.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        rectrangleSets.topAnchor.constraint(equalTo: rectrangleSets.topAnchor, constant: 10).isActive = true
        
        setsLbl.text = "Sets count"
        setsLbl.textAlignment = .center
        setsLbl.textColor = .white
        setsLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleSets.addSubview(setsLbl)
        NSLayoutConstraint.activate([
            
            setsLbl.widthAnchor.constraint(equalToConstant: 350),
            setsLbl.heightAnchor.constraint(equalToConstant: 40),
            setsLbl.centerXAnchor.constraint(equalTo: rectrangleSets.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        setsLbl.topAnchor.constraint(equalTo: rectrangleSets.topAnchor, constant: 30).isActive = true
    }
    
    //rep container
    func configureRepContainer(){
        rectrangleReps.frame = CGRect(x:210, y: 410, width: 150 , height: 70)
        rectrangleReps.backgroundColor = UIColor.purple
        rectrangleReps.layer.opacity = 0.4
        rectrangleReps.layer.cornerRadius = 20
        self.view.addSubview(rectrangleReps)
        
        repValLbl.text = String(warmUp.exe_rep)
        repValLbl.textAlignment = .center
        repValLbl.textColor = .white
        repValLbl.font = UIFont(name: repValLbl.font.fontName, size: 24)
        repValLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleReps.addSubview(repValLbl)
        NSLayoutConstraint.activate([
            
            repValLbl.widthAnchor.constraint(equalToConstant: 350),
            repValLbl.heightAnchor.constraint(equalToConstant: 30),
            repValLbl.centerXAnchor.constraint(equalTo: rectrangleReps.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        rectrangleReps.topAnchor.constraint(equalTo: rectrangleReps.topAnchor, constant: 10).isActive = true
        
        repsLbl.text = "Repetition count"
        repsLbl.textAlignment = .center
        repsLbl.textColor = .white
        repsLbl.translatesAutoresizingMaskIntoConstraints = false
        rectrangleReps.addSubview(repsLbl)
        NSLayoutConstraint.activate([
            
            repsLbl.widthAnchor.constraint(equalToConstant: 350),
            repsLbl.heightAnchor.constraint(equalToConstant: 40),
            repsLbl.centerXAnchor.constraint(equalTo: rectrangleReps.centerXAnchor),
            //totLbl.centerYAnchor.constraint(equalTo: rectrangleTotHr.centerYAnchor),
            ])
        repsLbl.topAnchor.constraint(equalTo: rectrangleReps.topAnchor, constant: 30).isActive = true
    }
        
}


