//
//  ResultModel.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 30.09.24.
//


struct Result: Codable {
    
	let time: Int
	let mode: GameMode
	let difficulty: Difficulty?
	let gameResult: GameResult
}


enum GameMode: String, Codable {
	case singlePlayer = "Single"
    case twoPlayer = "Multi"
}


enum Difficulty: String, CaseIterable, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}
