//
//  ViewController.swift
//  TicTacToe
//
//  Kirill
//

import UIKit

class MainViewController: UIViewController {

    let playButton = UIButton()
    let xskin1Image = UIImageView()
    let oskin1Image = UIImageView()
    let rulesIcon = UIImageView()
    let settingsIcon = UIImageView()
    let ticTacToeLabel = UILabel()
    let logoStackView = UIStackView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayButton()
        setupRulesIcon()
        setupSettingsIcon()
        setupTicTacToeLabel()
        setLogoStackView()
        setupXskin1Image()
        setupOskin1Image()
        
        
        view.backgroundColor = UIColor.white
    }
    
    
    func setLogoStackView() {
        view.addSubview(logoStackView)
        logoStackView.axis = .horizontal
        logoStackView.distribution = .fillEqually
        logoStackView.alignment = .center
        logoStackView.spacing = 5.0
        self.view.addSubview(logoStackView)
        logoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        logoStackView.addArrangedSubview(oskin1Image)
        logoStackView.addArrangedSubview(xskin1Image)
        
        NSLayoutConstraint.activate([
//            logoStackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            logoStackView.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            logoStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            logoStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
        ])
        
    }
    
    func setupPlayButton() {
        view.addSubview(playButton)
        
        playButton.setTitle("Let's play", for: .normal)
        playButton.layer.cornerRadius = 30
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        playButton.tintColor = .white
        playButton.backgroundColor = UIColor(red: 132/255, green: 128/255, blue: 212/255, alpha: 1)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            playButton.heightAnchor.constraint(equalToConstant: 72),
            playButton.widthAnchor.constraint(equalToConstant: 348)
        ])
        
        
    }
    func setupXskin1Image () {
        view.addSubview(xskin1Image)
        xskin1Image.contentMode = .scaleAspectFit
        xskin1Image.image = UIImage(named: "Xskin1")
        xskin1Image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            xskin1Image.trailingAnchor.constraint(equalTo: logoStackView.centerXAnchor, constant: -50),
            xskin1Image.centerYAnchor.constraint(equalTo: logoStackView.centerYAnchor),
        ])
    }
    
    func setupOskin1Image () {
        view.addSubview(oskin1Image)
        oskin1Image.contentMode = .scaleAspectFit
        oskin1Image.image = UIImage(named: "oSkin1")
        oskin1Image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            oskin1Image.leadingAnchor.constraint(equalTo: logoStackView.centerXAnchor, constant: 50),
            oskin1Image.centerYAnchor.constraint(equalTo: logoStackView.centerYAnchor),
        ])
    }
    
    func setupRulesIcon () {
        view.addSubview(rulesIcon)
        rulesIcon.contentMode = .scaleAspectFill
        rulesIcon.image = UIImage(named: "Rules Icon")
        rulesIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rulesIcon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            rulesIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            rulesIcon.heightAnchor.constraint(equalToConstant: 36),
            rulesIcon.widthAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    func setupSettingsIcon () {
        view.addSubview(settingsIcon)
        settingsIcon.contentMode = .scaleAspectFill
        settingsIcon.image = UIImage(named: "Settings Icon")
        settingsIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsIcon.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            settingsIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsIcon.heightAnchor.constraint(equalToConstant: 36),
            settingsIcon.widthAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    func setupTicTacToeLabel () {
        view.addSubview(ticTacToeLabel)
        ticTacToeLabel.text = "TIC-TAC-TOE"
        ticTacToeLabel.textColor = .black
        ticTacToeLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        ticTacToeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ticTacToeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            ticTacToeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
	
}

