//
//  Extensions + Animations.swift
//  TicTacToeNew
//
//  Created by Evgeniy Kislitsin on 05.10.2024.
//

import UIKit

extension UIImageView {

	// Анимация масштабирования (например, при нажатии)
	static func animateImagePress(_ imageView: UIImageView, completion: (() -> Void)? = nil) {
		UIView.animate(withDuration: 0.1, // Быстрое сжатие
					   animations: {
			imageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
		}, completion: { _ in
			UIView.animate(withDuration: 0.1, // Возвращение к нормальному размеру
						   animations: {
				imageView.transform = CGAffineTransform.identity
			}, completion: { _ in
				completion?()
			})
		})
	}
	
	// Анимация плавного появления (например, когда изображение меняется)
	static func fadeInImage(_ imageView: UIImageView, duration: TimeInterval = 0.5, completion: (() -> Void)? = nil) {
		imageView.alpha = 0
		UIView.animate(withDuration: duration, animations: {
			imageView.alpha = 1
		}, completion: { _ in
			completion?()
		})
	}
	
}

extension UIButton {
	
	static func animateButtonPress(_ button: UIButton, duration: TimeInterval = 0.2, scale: CGFloat = 1.1, completion: (() -> Void)? = nil) {
		UIView.animate(withDuration: duration, animations: {
			button.transform = CGAffineTransform(scaleX: scale, y: scale)
		}, completion: { _ in
			UIView.animate(withDuration: duration, animations: {
				button.transform = CGAffineTransform.identity
			}, completion: { _ in
				completion?()
			})
		})
	}
}
