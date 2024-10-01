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
        setupXskin1Image()
        setupOskin1Image()
        setupRulesIcon()
        setupSettingsIcon()
        setupTicTacToeLabel()
        
        view.backgroundColor = UIColor.white
    }
    
    
    func setLogoStackView() {
        view.addSubview(logoStackView)
        logoStackView.axis = .horizontal
        logoStackView.distribution = .fillEqually
        logoStackView.spacing = 5
        
        NSLayoutConstraint.activate([
            logoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
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
            xskin1Image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            xskin1Image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func setupOskin1Image () {
        view.addSubview(oskin1Image)
        oskin1Image.contentMode = .scaleAspectFit
        oskin1Image.image = UIImage(named: "oSkin1")
        oskin1Image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            oskin1Image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            oskin1Image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
            ticTacToeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 444),
            ticTacToeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
	
}

