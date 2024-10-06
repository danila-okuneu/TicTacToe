//
//  ShadowExtension.swift
//  TicTacToeNew
//
//  Created by Danila Okuneu on 6.10.24.
//

import UIKit

extension UIView {
	
	func dropShadow() {
		clipsToBounds = false
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.15
		layer.shadowRadius = 10
	}
}
