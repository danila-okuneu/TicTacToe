//
//  Extensions.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 29.09.24.
//


import UIKit

extension UIColor {
	
	enum AppColor {
		case purple
		case darkPurple
		case lightPurple
		
		var color: UIColor {
			switch self {
			case .purple:
				return UIColor(red: 213/255, green: 193/255, blue: 246/255, alpha: 1)
			case .darkPurple:
				return UIColor(red: 132/255, green: 128/255, blue: 212/255, alpha: 1)
			case .lightPurple:
				return UIColor(red: 246/255, green: 247/255, blue: 255/255, alpha: 1)
			}
		}
	}
	
	static func app(_ color: AppColor) -> UIColor {
		return color.color
		
	}
}



