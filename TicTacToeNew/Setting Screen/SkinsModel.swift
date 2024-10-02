//
//  SkinModel.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 29.09.24.
//

import UIKit


struct Skins {
    
    
	static var selectedPair = 1
    
//    static func get(pair: Int) -> (x: UIImage, o: UIImage) { // на время теста экрана
//       
//        let x = UIImage(named: "xSkin5")
//        let o = UIImage(named: "oSkin5")
//
//        return (x!, o!)
//    }

    static func get(pair: Int) -> (x: UIImage,o: UIImage) {   

        guard let x = UIImage(named: "xSkin\(pair)") else { return Skins.get(pair: 1) }
        guard let o = UIImage(named: "oSkin\(pair)") else { return Skins.get(pair: 1) }

        return (x, o)
    }
}
