//
//  SelectGameVC.swift
//  TicTacToe
//
//  Baha
//
import UIKit

class SelectViewController: UIViewController {
	//w 285
	//h 247
	
	//size 20 px - single
	//h69 w245 - stack
	//robot icon - w38 h 29 , in between  - 8
	
	private lazy var mainView: UIView = {
		$0.backgroundColor = .white
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.layer.cornerRadius = 25
		$0.layer.shadowColor = UIColor.black.cgColor
		$0.layer.shadowOpacity = 0.1
		$0.layer.shadowOffset = CGSize(width: 0, height: 2)
		$0.layer.shadowRadius = 10
		return $0
	}(UIView())
	
	private lazy var playButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .red
		button.setTitle("SINGLE", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
		button.frame = CGRect(x: 100, y: 200, width: 100, height: 50)
		return button
	}()
	
	private lazy var labelGame = setLabel(text: "Select Game", size: 24)
	
	private lazy var labelSingle = setLabel(text: "Single Player", size: 20, weight: .bold)
	
	private lazy var labelMulti = setLabel(text: "Two Players", size: 20, weight: .bold)
	
	private lazy var imageViewSingle: UIImageView = {
		$0.contentMode = .scaleAspectFill
		$0.clipsToBounds = true
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.heightAnchor.constraint(equalToConstant: 29).isActive = true
		$0.widthAnchor.constraint(equalToConstant: 38).isActive = true
		$0.image = UIImage(named: "Single")
		return $0
	}(UIImageView())
	
	private lazy var imageViewMulti: UIImageView = {
		$0.contentMode = .scaleAspectFill
		$0.clipsToBounds = true
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.heightAnchor.constraint(equalToConstant: 29).isActive = true
		$0.widthAnchor.constraint(equalToConstant: 38).isActive = true
		$0.image = UIImage(named: "Multi")
		return $0
	}(UIImageView())
	
	private lazy var viewSingle =  setView()
	
	private lazy var viewMulti =  setView()
	
	
	
	
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		view.backgroundColor = UIColor(red: 230/255, green: 233/255, blue: 249/255, alpha: 1.0)
		
		addSubviewsToView()
		setViews()
		playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside) // На время фикс
		setConstraints()
		setupNavigationBar()
	}
	
	private func addSubviewsToView() {
		[labelGame, viewSingle, viewMulti].forEach {
			mainView.addSubview($0)
		}
		[mainView, labelGame, playButton].forEach {
			view.addSubview($0)
		}
	}
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			mainView.widthAnchor.constraint(equalToConstant: 285),
			mainView.heightAnchor.constraint(equalToConstant: 247),
			mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			labelGame.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
			labelGame.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
			viewSingle.heightAnchor.constraint(equalToConstant: 69),
			viewSingle.topAnchor.constraint(equalTo: labelGame.bottomAnchor, constant: 20),
			viewSingle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
			viewSingle.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
			imageViewSingle.centerYAnchor.constraint(equalTo: viewSingle.centerYAnchor),
			imageViewSingle.leadingAnchor.constraint(equalTo: viewSingle.leadingAnchor, constant: 42),
			labelSingle.leadingAnchor.constraint(equalTo: imageViewSingle.trailingAnchor, constant: 8),
			labelSingle.centerYAnchor.constraint(equalTo: viewSingle.centerYAnchor),
			
			viewMulti.heightAnchor.constraint(equalToConstant: 69),
			viewMulti.topAnchor.constraint(equalTo: viewSingle.bottomAnchor, constant: 20),
			viewMulti.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
			viewMulti.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
			imageViewMulti.leadingAnchor.constraint(equalTo: viewMulti.leadingAnchor, constant: 42),
			imageViewMulti.centerYAnchor.constraint(equalTo: viewMulti.centerYAnchor),
			labelMulti.leadingAnchor.constraint(equalTo: imageViewMulti.trailingAnchor, constant: 8),
			labelMulti.centerYAnchor.constraint(equalTo: viewMulti.centerYAnchor),
			
		])
	}
	
	private func setViews(){
		viewSingle.addSubview(imageViewSingle)
		viewSingle.addSubview(labelSingle)
		viewMulti.addSubview(imageViewMulti)
		viewMulti.addSubview(labelMulti)
		
		
	}
	
	private func setLabel(text: String, size: CGFloat, weight: UIFont.Weight = .bold) -> UILabel {
		let label = UILabel()
		label.text = text
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: size, weight: weight)
		return label
	}
	
	private func setView() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 30
		view.backgroundColor = UIColor(red: 230/255, green: 233/255, blue: 249/255, alpha: 1.0)
		return view
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
	
	@objc private func playButtonTapped() {
		self.navigationController?.pushViewController(GameViewController(), animated: true)
	}
	
	@objc private func backButtonTapped() {
		self.navigationController?.popViewController(animated: true)
	}
	
	@objc private func settingsButtonTapped() {
		self.navigationController?.pushViewController(SettingsViewController(), animated: true)
	}
	
}
