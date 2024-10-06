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
        case unactiveButton
        case activeButton
        case black
        case lightBlue
		case pink

        var color: UIColor {
            switch self {
            case .purple:
                return UIColor(red: 213/255, green: 193/255, blue: 246/255, alpha: 1)
            case .darkPurple:
                return UIColor(red: 132/255, green: 128/255, blue: 212/255, alpha: 1)
            case .lightPurple:
                return UIColor(red: 245/255, green: 247/255, blue: 255/255, alpha: 1)
            case .unactiveButton:
                return UIColor(red: 229/255, green: 233/255, blue: 249/255, alpha: 1)
            case .activeButton:
                return UIColor(red: 132/255, green: 128/255, blue: 212/255, alpha: 1)
            case .black:
                return UIColor(red: 35/255, green: 41/255, blue: 70/255, alpha: 1)
            case .lightBlue:
                return UIColor(red: 230/255, green: 233/255, blue: 249/255, alpha: 1)
			case .pink:
				return UIColor(red: 238/255, green: 141/255, blue: 209/255, alpha: 1)
            }
        }
    }
    
    static func app(_ color: AppColor) -> UIColor {
        return color.color
        
    }
}
