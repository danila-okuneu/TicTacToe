//
//  CurrentPlayerIndicator.swift
//  TicTacToeNew
//
//  Created by Evgeniy on 03.10.2024.
//

import UIKit

protocol PlayerIndicatorDelegate: AnyObject {
	func updateIndicator(for player: Player)
}

class CurrentPlayerIndicator: UIView {
	
	private let playerImageView: UIImageView = {
		let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		return imageView
	}()
	
	private let currentPlayerLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.font = UIFont.boldSystemFont(ofSize: Constants.labelFontSize)
		label.text = "Your turn"
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupViews()
	}
	
	
	private func setupViews() {
		addSubview(playerImageView)
		addSubview(currentPlayerLabel)
		
		// Настройки для constraints
		playerImageView.translatesAutoresizingMaskIntoConstraints = false
		currentPlayerLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			playerImageView.topAnchor.constraint(equalTo: topAnchor),
			playerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			playerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
			playerImageView.widthAnchor.constraint(equalToConstant: Constants.playerImageWidth),
			playerImageView.heightAnchor.constraint(equalToConstant: Constants.playerImageHeight),
			
			currentPlayerLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: Constants.horizontalSpacing),
			currentPlayerLabel.widthAnchor.constraint(equalToConstant: Constants.stepLabelWidth),
			currentPlayerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}
	
	private func hidePlayerImage() {
		playerImageView.isHidden = true
	}
	
	private func showPlayerImage() {
		playerImageView.isHidden = false
	}
}

extension CurrentPlayerIndicator: PlayerIndicatorDelegate {
	func updateIndicator(for player: Player) {
		switch player {
		case .cross:
			playerImageView.image = Skins.getSelected().x
			UIImageView.animateImagePress(playerImageView)  // Анимация при смене картинки
			currentPlayerLabel.text = "You turn"
			showPlayerImage()
		case .nought:
			playerImageView.image = Skins.getSelected().o
			UIImageView.animateImagePress(playerImageView)  // Анимация при смене картинки
			currentPlayerLabel.text = "Player Two turn"
			showPlayerImage()
		}
	}
}

extension CurrentPlayerIndicator {
		private struct Constants {
			static let screenWidth: CGFloat = UIScreen.main.bounds.width
			static let screenHeight: CGFloat = UIScreen.main.bounds.height
		   
			static let playerImageHeight = screenHeight * (53 / 844)
			static let playerImageWidth = screenWidth * (54 / 390)
			
			static let stepLabelWidth = screenWidth * (161 / 390)
			
			static let horizontalSpacing = screenWidth * (20 / 390)
			static let verticalSpacing = screenHeight * (20 / 844)
	  
			static let labelFontSize = screenWidth * (20 / 390)
		}
}
