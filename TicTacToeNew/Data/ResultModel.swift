//
//  ResultModel.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 30.09.24.
//


struct Result: Codable {
    
    let time: String
	let mode: GameMode
	let difficulty: Difficulty?
	let gameResult: GameResult
}


enum GameMode: Codable {
    case singlePlayer
    case twoPlayer
}


enum Difficulty: String, CaseIterable, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}
