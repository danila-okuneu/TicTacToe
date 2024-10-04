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
        
        let lowercaseX = UIImage(named: "xSkin\(pair)")
        let lowercaseO = UIImage(named: "oSkin\(pair)")
        
        let uppercaseX = UIImage(named: "XSkin\(pair)")
        let uppercaseO = UIImage(named: "OSkin\(pair)")
        
        let x = lowercaseX ?? uppercaseX ?? Skins.get(pair: 1).x
        let o = lowercaseO ?? uppercaseO ?? Skins.get(pair: 1).o
        
        return (x, o)
    }

    static func getSelected() -> (x: UIImage, o: UIImage) {
        return Skins.get(pair: Skins.selectedPair)
    }


    static func load() {
        let defaults = UserDefaults.standard
        Skins.selectedPair = defaults.value(forKey: "selectedPair") as? Int ?? 1
    }
}
