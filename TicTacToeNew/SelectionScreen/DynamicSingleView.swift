//
//  DynamicBotView.swift
//  TicTacToeNew
//
//  Created by Danila Okuneu on 5.10.24.
//

import UIKit
import SnapKit

final class DynamicSingleView: UIView, Dynamic {
	
	
	weak var delegate: DifficultyDelegate?
	private var isShowDificulties = false {
		didSet {
			change(opacity: isShowDificulties ? 1 : 0, for: difficultiesStackView)
			change(height: isShowDificulties ? 80 + difficultiesStackView.bounds.height : 60, for: self)
			delegate?.dynamicViewDidChangedHeight(self)
		}
	}
	
	// MARK: - UI Components
	private let singlePlayerButton: UIButton = {
		let button = UIButton()
		button.setTitle("Single Player", for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
		button.setTitleColor(.black, for: .normal)
		button.backgroundColor = .clear
//		button.setImage("Singleplayer", for: .normal)
		button.setImage(UIImage(named: "Singleplayer"), for: .normal)
		button.imageView?.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	private let difficultiesStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = 10
		stack.layer.opacity = 0
		stack.distribution = .fillEqually
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	
	// MARK: - Initializers
	init() {
		super.init(frame: .zero)
		
		setupViews()
		setButtonsTargets()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Layout
	private func setupViews() {
		backgroundColor = UIColor.app(.lightPurple)
		layer.cornerRadius = 30
		addSubview(singlePlayerButton)
		addSubview(difficultiesStackView)
		
		setupDifficultyButtons()
		makeConstraints()
	}
	
	
	private func makeConstraints() {
		snp.makeConstraints { make in
			make.height.equalTo(60)
		}
		
		difficultiesStackView.snp.makeConstraints { make in
			make.bottom.equalToSuperview().offset(-10)
			make.left.equalToSuperview().offset(10)
			make.right.equalToSuperview().offset(-10)
		}
		
		singlePlayerButton.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.left.right.equalToSuperview()
			make.height.equalTo(60)
		}
	}
	
	// MARK: - Methods
	private func setupDifficultyButtons() {
		for difficulty in Difficulty.allCases {
			let button = UIButton()
			button.setTitle(difficulty.rawValue, for: .normal)
			button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
			button.layer.cornerRadius = 20
			button.backgroundColor = UIColor.app(.lightBlue)
			button.setTitleColor(UIColor.app(.activeButton), for: .normal)
			button.addTarget(self, action: #selector(selectDifficulty), for: .touchUpInside)
			
			button.snp.makeConstraints { make in
				make.height.equalTo(40)
			}

			difficultiesStackView.addArrangedSubview(button)
		}
	}
	
	
	private func setButtonsTargets() {
		singlePlayerButton.addTarget(self, action: #selector(showDifficulties), for: .touchUpInside)
	}
	
	
	// MARK: - Actions
	@objc private func showDifficulties() {
		isShowDificulties.toggle()
	}
	
	@objc private func selectDifficulty(_ sender: UIButton) {
		isShowDificulties.toggle()
		
		if let title = sender.titleLabel?.text {
			delegate?.pushViewController(difficulty: Difficulty(rawValue: title) ?? .easy)
		}
	}
}

// MARK: - DifficultyDelegate protocol
protocol DifficultyDelegate: DynamicDelegate {
	func pushViewController(difficulty: Difficulty)
}

