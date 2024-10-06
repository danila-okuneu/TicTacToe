//
//  CustomButtons.swift
//  TicTacToeNew
//
//  Created by Evgeniy on 02.10.2024.
//

import UIKit
import SnapKit

final class PlayerCard: UIView {
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.app(.black)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: Constants.labelFontSize)
        return label
    }()
    
    init(image: UIImage, text: String) {
        super.init(frame: .zero)
        imageView.image = image
        label.text = text
        setupViews()
        backgroundColor = UIColor.app(.lightBlue)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        layer.cornerRadius = 30
        layer.masksToBounds = true
        backgroundColor = UIColor.app(.lightBlue)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(cardView)
        cardView.addSubview(imageView)
        cardView.addSubview(label)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalMargin), // Верхний отступ
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalMargin), // Левый отступ
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalMargin), // Правый отступ
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalMargin) // Нижний отступ
        ])
        
        NSLayoutConstraint.activate([
            // Констрейнты для imageView
            imageView.heightAnchor.constraint(equalToConstant: Constants.playerImageHeight),
            imageView.widthAnchor.constraint(equalToConstant: Constants.playerImageWidth),
            imageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.imageHorizontalMargin),
            imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.imageHorizontalMargin),
            
            label.widthAnchor.constraint(equalToConstant: Constants.labelWidth),
            label.heightAnchor.constraint(equalToConstant: Constants.labelHeiht),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.verticalMargin),
            label.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: cardView.trailingAnchor)
            
        ])
        
    }
}

extension PlayerCard {
    private struct Constants {
        // Fixed sizes
        static let labelFontSize = screenWidth * (16 / 390)
        // Getting screen dimensions
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height
       
        
        // Relative sizes
        static let playerImageHeight = screenHeight * (53 / 844)
        static let playerImageWidth = screenWidth * (53 / 390)
        static let labelHeiht = screenHeight * (20 / 844)
        static let labelWidth = screenWidth * (83 / 390)
        static let imageHorizontalMargin = screenWidth * (15 / 390)
        
        static let horizontalMargin = screenWidth * (10 / 390)
        static let verticalMargin = screenHeight * (10 / 844)
    }
}
