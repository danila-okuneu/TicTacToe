//
//  DynamicProtocols.swift
//  TicTacToeNew
//
//  Created by Danila Okuneu on 6.10.24.
//

import UIKit


// MARK: - Dynamic protocols
protocol Dynamic {
	func change(opacity: Float, for view: UIView)
	func change(height: CGFloat, for view: UIView)
}

extension Dynamic where Self: UIView {
	
	func change(opacity: Float, for view: UIView) {
		UIView.animate(withDuration: 0.1) {
			view.layer.opacity = opacity
		}
	}
	
	func change(height: CGFloat, for view: UIView) {
		view.snp.updateConstraints { make in
			make.height.equalTo(height)
		}
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut) {
			view.layoutIfNeeded()
		}
	}
}

protocol DynamicDelegate: AnyObject {
	func dynamicViewDidChangedHeight(_ dynamicTimeView: Dynamic)
}
