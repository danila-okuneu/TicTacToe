//
//  HStackView.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 29.09.24.
//

import UIKit


final class SkinsHorizontalStackView: UIStackView {
    
    init(views: UIView...) {
        super.init(frame: .zero)
        
        spacing = 20
        distribution = .fillEqually
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(views: views)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private methods
    
    private func addSubviews(views: [UIView]) {
        
        for view in views {
            addArrangedSubview(view)
        }
    }
    
}
