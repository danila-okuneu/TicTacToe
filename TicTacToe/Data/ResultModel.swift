//
//  ResultModel.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 30.09.24.
//


struct Result: Codable {
	
	let time: String
	let mode: Mode
	let difficulty: String?
	
}


enum Mode: Codable {
	case twoPlayer
	case singlePlayer
}


enum Difficulty: String {
	case easy
	case medium
	case hard
}
