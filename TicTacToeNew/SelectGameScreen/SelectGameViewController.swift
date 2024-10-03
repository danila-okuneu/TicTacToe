//
//  SelectGameVC.swift
//  TicTacToe
//
//  Kirill
//
import UIKit

class SelectGameViewController: UIViewController {
    
    
    let buttonsView = UIStackView()
    let singlePlayerButton = UIButton()
    let twoPlayersButton = UIButton()
    let leaderbordButton = UIButton()
    let labelSelectGame = UILabel()
    let imageSingle = UIImage(named: "Singleplayer.png")
    let imageTwoPlayers = UIImage(named: "Multiplayer")
    let imageLeaderbord = UIImage(named: "Multiplayer Icon")
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 245/255, green: 247/255, blue: 255/255, alpha: 1)
        
        
        setButtonsView()
        setSinglePlayerButton()
        setTwoPlayersButton()
        setLeaderbordButton()
        setLabelSelectGame()
		
		setButtonTargets() // Add targets for buttons
		setupNavigationBar() // Add NavigationItems (Back Button and Settings Button)
	}
    
    
    func setButtonsView() {
        buttonsView.axis = .vertical
        buttonsView.distribution = .fillEqually
        buttonsView.alignment = .center
        buttonsView.spacing = 0.5
        view.addSubview(buttonsView)
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        buttonsView.layer.cornerRadius = 30
        buttonsView.layer.shadowColor = UIColor.black.cgColor
        buttonsView.layer.shadowOpacity = 0.150
        buttonsView.layer.shadowOffset = CGSize(width: 4, height: 4)
        buttonsView.layer.shadowRadius = 10
        buttonsView.addArrangedSubview(singlePlayerButton)
        buttonsView.addArrangedSubview(twoPlayersButton)
        buttonsView.addArrangedSubview(leaderbordButton)
        buttonsView.addArrangedSubview(labelSelectGame)
        
        NSLayoutConstraint.activate([
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 336),
            buttonsView.widthAnchor.constraint(equalToConstant: 285)
            
        ])
        
    }
    
    func setSinglePlayerButton() {
        view.addSubview(singlePlayerButton)
        
        singlePlayerButton.setTitle("  Single Player", for: .normal)
        singlePlayerButton.layer.cornerRadius = 30
        singlePlayerButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        singlePlayerButton.setTitleColor(UIColor.black, for: .normal)
        singlePlayerButton.backgroundColor = UIColor(red: 230/255, green: 233/255, blue: 249/255, alpha: 1)
        singlePlayerButton.setImage(imageSingle, for: .normal)
        singlePlayerButton.imageView?.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
        singlePlayerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            singlePlayerButton.centerXAnchor.constraint(equalTo: buttonsView.centerXAnchor),
            singlePlayerButton.topAnchor.constraint(equalTo: labelSelectGame.bottomAnchor, constant: 20),
            singlePlayerButton.heightAnchor.constraint(equalToConstant: 69),
            singlePlayerButton.widthAnchor.constraint(equalToConstant: 245)
        ])
    }
    
    func setTwoPlayersButton() {
        view.addSubview(twoPlayersButton)
        
        twoPlayersButton.setTitle("  Two Players", for: .normal)
        twoPlayersButton.layer.cornerRadius = 30
        twoPlayersButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        twoPlayersButton.setTitleColor(UIColor.black, for: .normal)
        twoPlayersButton.backgroundColor = UIColor(red: 230/255, green: 233/255, blue: 249/255, alpha: 1)
        twoPlayersButton.setImage(imageTwoPlayers, for: .normal)
        twoPlayersButton.imageView?.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
        twoPlayersButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            twoPlayersButton.centerXAnchor.constraint(equalTo: buttonsView.centerXAnchor),
            twoPlayersButton.topAnchor.constraint(equalTo: singlePlayerButton.bottomAnchor, constant: 20),
            twoPlayersButton.heightAnchor.constraint(equalToConstant: 69),
            twoPlayersButton.widthAnchor.constraint(equalToConstant: 245)
        ])
    }
    
    func setLeaderbordButton() {
        view.addSubview(leaderbordButton)
        
        leaderbordButton.setTitle("  Leaderbord", for: .normal)
        leaderbordButton.layer.cornerRadius = 30
        leaderbordButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        leaderbordButton.setTitleColor(UIColor.black, for: .normal)
        leaderbordButton.backgroundColor = UIColor(red: 230/255, green: 233/255, blue: 249/255, alpha: 1)
        leaderbordButton.setImage(imageLeaderbord, for: .normal)
        leaderbordButton.imageView?.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
        leaderbordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leaderbordButton.centerXAnchor.constraint(equalTo: buttonsView.centerXAnchor),
            leaderbordButton.topAnchor.constraint(equalTo: twoPlayersButton.bottomAnchor, constant: 20),
            leaderbordButton.heightAnchor.constraint(equalToConstant: 69),
            leaderbordButton.widthAnchor.constraint(equalToConstant: 245)
        ])
    }
    
    func setLabelSelectGame () {
        view.addSubview(labelSelectGame)
        labelSelectGame.text = "Select Game"
        labelSelectGame.textColor = .black
        labelSelectGame.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        labelSelectGame.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelSelectGame.topAnchor.constraint(equalTo: buttonsView.topAnchor, constant: 20),
            labelSelectGame.centerXAnchor.constraint(equalTo: buttonsView.centerXAnchor),
        ])
    }
	
	private func setButtonTargets() {
		singlePlayerButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
		twoPlayersButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
		leaderbordButton.addTarget(self, action: #selector(pushLeaderboard), for: .touchUpInside)
	}
	
	func setupNavigationBar() {
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			image: UIImage(named: "backButtonIcon"),
			style: .plain,
			target: self,
			action: #selector(backButtonTapped)
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
	
	@objc private func backButtonTapped() {
		self.navigationController?.popViewController(animated: true)
	}
	
	@objc private func settingsButtonTapped() {
		self.navigationController?.pushViewController(SettingsViewController(), animated: true)
	}
	

	@objc private func startGame(_ sender: UIButton) {
		self.navigationController?.pushViewController(GameViewController(), animated: true)
	}
	
	@objc private func pushLeaderboard() {
		self.navigationController?.pushViewController(LeaderboardViewController(), animated: true)
	}
}

