//
//  SkinModel.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 29.09.24.
//

import UIKit


struct Skins {
    
    
	static var selectedPair = 1 

    static func get(pair: Int) -> (x: UIImage,o: UIImage) {   

        guard let x = UIImage(named: "xSkin\(pair)") else { return Skins.get(pair: 1) }
        guard let o = UIImage(named: "oSkin\(pair)") else { return Skins.get(pair: 1) }

        return (x, o)
    }
	
	static func getSelected() -> (x: UIImage, o: UIImage) {
		return Skins.get(pair: Skins.selectedPair)
	}
	
	
	static func load() {
		
		let defaults = UserDefaults.standard
		Skins.selectedPair = defaults.value(forKey: "selectedPair") as! Int
	}
}
