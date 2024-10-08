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
	let singlePlayerButton = DynamicSingleView()
    let twoPlayersButton = UIButton()
    let leaderbordButton = UIButton()
    let labelSelectGame = UILabel()
	
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
		
		selectionView.dropShadow()
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
		buttonStackView.backgroundColor = .white
		
        NSLayoutConstraint.activate([
			buttonStackView.leadingAnchor.constraint(equalTo: selectionView.leadingAnchor, constant: 20),
			buttonStackView.trailingAnchor.constraint(equalTo: selectionView.trailingAnchor, constant: -20),
			buttonStackView.topAnchor.constraint(equalTo: labelSelectGame.bottomAnchor, constant: 10),
			buttonStackView.bottomAnchor.constraint(equalTo: selectionView.bottomAnchor, constant: -20)
        ])
        
    }
    
        
    func setTwoPlayersButton() {
        
        twoPlayersButton.setTitle("Two Players", for: .normal)
        twoPlayersButton.layer.cornerRadius = 30
        twoPlayersButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
		twoPlayersButton.setTitleColor(UIColor.app(.black), for: .normal)
		twoPlayersButton.backgroundColor = UIColor.app(.lightPurple)
		twoPlayersButton.setImage(UIImage(named: "Multiplayer"), for: .normal)
        twoPlayersButton.imageView?.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
        twoPlayersButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
			twoPlayersButton.heightAnchor.constraint(equalToConstant: 60)
        ])

		twoPlayersButton.tag = GameMode.twoPlayer.hashValue
    }
    
    func setLeaderbordButton() {
        
        leaderbordButton.setTitle("Leaderbord", for: .normal)
        leaderbordButton.layer.cornerRadius = 30
        leaderbordButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
		leaderbordButton.setTitleColor(UIColor.app(.black), for: .normal)
		leaderbordButton.backgroundColor = UIColor.app(.lightPurple)
		leaderbordButton.setImage(UIImage(named: "Leaderboard"), for: .normal)
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
	
	private func setupNavigationBar() {
		
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
	
	// MARK: - Button actions
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
        
		let gameViewController = GameViewController()
		gameViewController.gameMode = GameMode.twoPlayer
		self.navigationController?.pushViewController(gameViewController, animated: true)
	}
	
	@objc private func pushLeaderboard() {
		self.navigationController?.pushViewController(LeaderboardViewController(), animated: true)
	}
}


// MARK: - Extension
extension SelectGameViewController: DifficultyDelegate {
	
	func pushViewController(difficulty: Difficulty) {
		
		let gameViewController = GameViewController()
		gameViewController.gameMode = GameMode.singlePlayer
		gameViewController.difficulty = difficulty
		self.navigationController?.pushViewController(gameViewController, animated: true)
	}
	
	func dynamicViewDidChangedHeight(_ dynamicTimeView: Dynamic) {
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
			self.view.layoutIfNeeded()
		}
	}

	
}
