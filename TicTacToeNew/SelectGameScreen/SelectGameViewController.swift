//
//  SelectGameVC.swift
//  TicTacToe
//
//  Kirill
//
import UIKit

final class SelectGameViewController: UIViewController {
    
    
	let selectionView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.layer.cornerRadius = 35
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	
    let buttonStackView = UIStackView()
	let singlePlayerButton = DynamicBotView()
    let twoPlayersButton = UIButton()
    let leaderbordButton = UIButton()
    let labelSelectGame = UILabel()
    let imageSingle = UIImage(named: "Singleplayer.png")
    let imageTwoPlayers = UIImage(named: "Multiplayer")
    let imageLeaderbord = UIImage(named: "Multiplayer Icon")
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
		view.backgroundColor = UIColor.app(.lightPurple)
		
		view.addSubview(selectionView)
		selectionView.addSubview(labelSelectGame)
		selectionView.addSubview(buttonStackView)
		
		buttonStackView.addArrangedSubview(singlePlayerButton)
		buttonStackView.addArrangedSubview(twoPlayersButton)
		buttonStackView.addArrangedSubview(leaderbordButton)
		
		setupSelectionView()
        setButtonsStackView()
        setTwoPlayersButton()
        setLeaderbordButton()
        setLabelSelectGame()
		
		
		singlePlayerButton.delegate = self
		setButtonTargets() // Add targets for buttons
		setupNavigationBar() // Add NavigationItems (Back Button and Settings Button)
	}
    
    
	private func setupSelectionView() {
		
		
		
		NSLayoutConstraint.activate([
			selectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
			selectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			selectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
	}
	
	
    func setButtonsStackView() {
        buttonStackView.axis = .vertical
		buttonStackView.distribution = .fillProportionally
        buttonStackView.spacing = 20
        view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
		
		
		
        
        NSLayoutConstraint.activate([
			buttonStackView.leadingAnchor.constraint(equalTo: selectionView.leadingAnchor, constant: 20),
			buttonStackView.trailingAnchor.constraint(equalTo: selectionView.trailingAnchor, constant: -20),
			buttonStackView.topAnchor.constraint(equalTo: labelSelectGame.bottomAnchor, constant: 10),
			buttonStackView.bottomAnchor.constraint(equalTo: selectionView.bottomAnchor, constant: -20)
        ])
        
    }
    
        
    func setTwoPlayersButton() {
        
        twoPlayersButton.setTitle("  Two Players", for: .normal)
        twoPlayersButton.layer.cornerRadius = 30
        twoPlayersButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        twoPlayersButton.setTitleColor(UIColor.black, for: .normal)
        twoPlayersButton.backgroundColor = UIColor(red: 230/255, green: 233/255, blue: 249/255, alpha: 1)
        twoPlayersButton.setImage(imageTwoPlayers, for: .normal)
        twoPlayersButton.imageView?.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
        twoPlayersButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
			twoPlayersButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        twoPlayersButton.tag = GameMode.multiPlayer.hashValue
    }
    
    func setLeaderbordButton() {
        
        leaderbordButton.setTitle("  Leaderbord", for: .normal)
        leaderbordButton.layer.cornerRadius = 30
        leaderbordButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        leaderbordButton.setTitleColor(UIColor.black, for: .normal)
        leaderbordButton.backgroundColor = UIColor(red: 230/255, green: 233/255, blue: 249/255, alpha: 1)
        leaderbordButton.setImage(imageLeaderbord, for: .normal)
        leaderbordButton.imageView?.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
        leaderbordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            leaderbordButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    func setLabelSelectGame () {
        
        labelSelectGame.text = "Select Game"
        labelSelectGame.textColor = .black
		labelSelectGame.textAlignment = .center
        labelSelectGame.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        labelSelectGame.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			labelSelectGame.topAnchor.constraint(equalTo: selectionView.topAnchor, constant: 20),
			labelSelectGame.leadingAnchor.constraint(equalTo: selectionView.leadingAnchor, constant: 20),
			labelSelectGame.trailingAnchor.constraint(equalTo: selectionView.trailingAnchor, constant: -20),
			labelSelectGame.heightAnchor.constraint(equalToConstant: 24)
		])
	}
	
	private func setButtonTargets() {
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
        switch sender.tag {
        case GameMode.singlePlayer.hashValue:
            self.navigationController?.pushViewController(DifficultySelectionViewController(), animated: true)
        case GameMode.multiPlayer.hashValue:
            let gameViewController = GameViewController()
            gameViewController.gameMode = .multiPlayer
            self.navigationController?.pushViewController(gameViewController, animated: true)
        default:
            break
        }
	}
	
	@objc private func pushLeaderboard() {
		self.navigationController?.pushViewController(LeaderboardViewController(), animated: true)
	}
}

protocol DifficultyDelegate: DynamicDelegate {
	func pushViewController(difficulty: DifficultyLevel)
}
extension SelectGameViewController: DifficultyDelegate {
	
	func pushViewController(difficulty: DifficultyLevel) {
		
		let gameViewController = GameViewController()
		gameViewController.gameMode = GameMode.singlePlayer
		gameViewController.difficultyLevel = difficulty
		self.navigationController?.pushViewController(gameViewController, animated: true)
	}
	
	func dynamicViewDidChangedHeight(_ dynamicTimeView: Dynamic) {
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
			self.view.layoutIfNeeded()
		}
	}

	
}
