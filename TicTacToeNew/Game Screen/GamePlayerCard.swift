//
//  CustomButtons.swift
//  TicTacToeNew
//
//  Created by Evgeniy on 02.10.2024.
//

import UIKit
import SnapKit

final class PlayerCard: UIView {
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    init(image: UIImage, text: String) {
        super.init(frame: .zero)
        imageView.image = image
        label.text = text
        setupViews()
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
        
        addSubview(imageView)
        addSubview(label)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Констрейнты для imageView
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            imageView.heightAnchor.constraint(equalToConstant: 53),
            imageView.widthAnchor.constraint(equalToConstant: 54),
            
            // Констрейнты для label
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
