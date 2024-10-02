//
//  CustomNavBar.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 30.09.24.
//

import UIKit


final class CustomNavigationController: UINavigationController {
    
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        navigationBar.tintColor = UIColor.app(.black)
        navigationBar.isTranslucent = true
        
        navigationBar.barTintColor = UIColor.app(.lightPurple)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.app(.black), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)]
        view.backgroundColor = UIColor.app(.lightPurple)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
