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
    let ticTacToeLabel = UILabel()
    let logoStackView = UIStackView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayButton()
        setupTicTacToeLabel()
        setLogoStackView()
        setupXskin1Image()
        setupOskin1Image()
        
        
		setupNavigationBar()
		playButton.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
		view.backgroundColor = UIColor.app(.lightPurple)
    }
    
	override func viewWillAppear(_ animated: Bool) {
	
		
		
		Saves.load()
		
		xskin1Image.image = Skins.get(pair: Skins.selectedPair).x
		oskin1Image.image = Skins.get(pair: Skins.selectedPair).o
	}
    
    func setLogoStackView() {
        view.addSubview(logoStackView)
        logoStackView.axis = .horizontal
        logoStackView.distribution = .fillEqually
        logoStackView.alignment = .center
        logoStackView.spacing = 0.5
        self.view.addSubview(logoStackView)
        logoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        logoStackView.addArrangedSubview(oskin1Image)
        logoStackView.addArrangedSubview(xskin1Image)
        
        NSLayoutConstraint.activate([
            logoStackView.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100),
            logoStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            logoStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
        ])
        
    }
    
    func setupPlayButton() {
        view.addSubview(playButton)
        
        playButton.setTitle("Let's play", for: .normal)
        playButton.layer.cornerRadius = 36
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        playButton.tintColor = .white
		playButton.dropShadow()
		playButton.backgroundColor = UIColor.app(.activeButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            playButton.heightAnchor.constraint(equalToConstant: 72),
            playButton.widthAnchor.constraint(equalToConstant: 348)
        ])
        
        
    }
    func setupXskin1Image () {
        view.addSubview(xskin1Image)
        xskin1Image.contentMode = .scaleAspectFit
        xskin1Image.image = Skins.get(pair: Skins.selectedPair).x
        xskin1Image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            xskin1Image.trailingAnchor.constraint(equalTo: logoStackView.centerXAnchor),
            xskin1Image.centerYAnchor.constraint(equalTo: logoStackView.centerYAnchor, constant: 15),
            xskin1Image.heightAnchor.constraint(equalToConstant: 120),
            xskin1Image.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func setupOskin1Image () {
        view.addSubview(oskin1Image)
        oskin1Image.contentMode = .scaleAspectFit
		oskin1Image.image = Skins.get(pair: Skins.selectedPair).o
        oskin1Image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            oskin1Image.leadingAnchor.constraint(equalTo: logoStackView.centerXAnchor),
            oskin1Image.centerYAnchor.constraint(equalTo: logoStackView.centerYAnchor),
            oskin1Image.heightAnchor.constraint(equalToConstant: 150),
            oskin1Image.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
   
    
   
    
    func setupTicTacToeLabel () {
        view.addSubview(ticTacToeLabel)
        ticTacToeLabel.text = "TIC-TAC-TOE"
        ticTacToeLabel.textColor = .black
        ticTacToeLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        ticTacToeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ticTacToeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            ticTacToeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
	
	func setupNavigationBar() {
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			image: UIImage(named: "Rules Icon"),
			style: .plain,
			target: self,
			action: #selector(rulesButtonTapped)
		)
		
		navigationItem.leftBarButtonItem?.tintColor = UIColor.app(.pink)
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			image: UIImage(named: "Settings Icon"),
			style: .plain,
			target: self,
			action: #selector(settingsButtonTapped)
		)
	}
	@objc private func playTapped() {
		self.navigationController?.pushViewController(SelectGameViewController(), animated: true)
	}
	
	@objc private func rulesButtonTapped() {
		self.navigationController?.pushViewController(RulesViewController(), animated: true)
	}
	
	@objc private func settingsButtonTapped() {
		self.navigationController?.pushViewController(SettingsViewController(), animated: true)
	}
    
}
