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
//        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let currentPlayerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Your turn"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .brown
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
            playerImageView.widthAnchor.constraint(equalToConstant: 54),
            playerImageView.heightAnchor.constraint(equalToConstant: 53),
            
            currentPlayerLabel.leadingAnchor.constraint(equalTo: playerImageView.trailingAnchor, constant: 20),
            currentPlayerLabel.widthAnchor.constraint(equalToConstant: 161),
            currentPlayerLabel.heightAnchor.constraint(equalToConstant: 24),
            currentPlayerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12)
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
            currentPlayerLabel.text = "You turn"
            hidePlayerImage()
        case .nought:
            playerImageView.image = Skins.getSelected().o
            currentPlayerLabel.text = "Player Two turn"
            showPlayerImage()
        }
    }
}
