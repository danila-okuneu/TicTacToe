//
//  ResultModel.swift
//  TicTacToe
//
//  Created by Churkin Vitaly on 29.09.2024.
//
import Foundation

enum GameResult {
    case win
    case draw
    case lose
}

struct ResultModel: Hashable {
    let label: String
    let image: String
}

extension ResultModel {
    static let results: [GameResult: ResultModel] = [
        .win: ResultModel(label: "Player One Win!", image: "Win-Icon"),
        .draw: ResultModel(label: "Draw!", image: "Draw-Icon"),
        .lose: ResultModel(label: "You Lose!", image: "Lose-Icon")
    ]
}
