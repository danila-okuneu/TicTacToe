//
//  GameBoard.swift
//  TicTacToeNew
//
//  Created by Evgeniy on 02.10.2024.
//
//

import UIKit
import SnapKit

class GameBoard: UIView {
    
    private var winningLineView: LineWinnerView?
    
    private var gameState: [Player?] = Array(repeating: nil, count: 9)
    private let winningCombinations: [Set<Int>] = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6],
    ]
        
    // делегат для передачи результата игры и перехода на другой экран
    weak var delegateGameVC: GameResultable?
    weak var delegatePI: PlayerIndicatorDelegate?
    
    private var playerImages: [UIImage] = [UIImage(), UIImage()]
    private var gameButtons: [UIButton] = []
    private var currentPlayer: Player = .cross // Начинаем с крестика
    
    // MARK: - Enum for Players
    
    init(_ imagePlayerOne: UIImage, _ imagePlayerTwo: UIImage, delegateVC: GameResultable) {
        super.init(frame: .zero)
        playerImages[0] = imagePlayerOne
        playerImages[1] = imagePlayerTwo
        delegateGameVC = delegateVC
        setupGameButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGameButtons()
    }
    
    private func setupGameButtons() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.verticalSpacing
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalSpacing), // Верхний отступ
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalSpacing), // Левый отступ
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalSpacing), // Правый отступ
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalSpacing) // Нижний отступ
        ])
     
        for _ in 0..<3 {
            let rowStackView = createRowStackView()
            
            for _ in 0..<3 {
                let button = createGameButton()
                rowStackView.addArrangedSubview(button)
            }
            
            stackView.addArrangedSubview(rowStackView)
        }
    }
    
    private func createRowStackView() -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.spacing = Constants.horizontalSpacing
        rowStackView.distribution = .fillEqually
        return rowStackView
    }
    
    private func createGameButton() -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.app(.lightBlue)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: button.topAnchor, constant: Constants.verticalMargin),
            imageView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: Constants.horizontalMargin),
            imageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -Constants.horizontalMargin),
            imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -Constants.verticalMargin),
            
            
        ])
        
        button.addTarget(self, action: #selector(gameButtonTapped(_:)), for: .touchUpInside)
        
        gameButtons.append(button)
        return button
    }
    
    @objc private func gameButtonTapped(_ sender: UIButton) {
        guard let index = gameButtons.firstIndex(of: sender), gameState[index] == nil else { return }
        
        gameState[index] = currentPlayer
        
        if let imageView = sender.subviews.compactMap({ $0 as? UIImageView }).first, imageView.image == nil {
            if currentPlayer == .cross {
                imageView.image = playerImages[0]
            } else {
                imageView.image = playerImages[1]
            }
            
            imageView.layer.cornerRadius = 4
            imageView.layer.masksToBounds = true
            
            if let winner = determineWinner() {
                finishGame(with: winner)
            } else if gameState.allSatisfy({ $0 != nil }) {
                finishGame(with: nil)
            } else {
                currentPlayer = currentPlayer == .cross ? .nought : .cross
                delegatePI?.updateIndicator(for: currentPlayer)
            }
            print("Button \(index) tapped") // принты чтобы проверить на время что нажимаються и отрабатывают кнопки
        }
    }
    
    /// - Returns: Игрок, выигравший игру, или nil, если победитель не найден.
    private func determineWinner() -> Player? {
        // Проходим по всем выигрышным комбинациям
        for combination in winningCombinations {
            // Получаем игроков из текущей комбинации
            let players = combination.compactMap { gameState[$0] }
            
            // Проверяем, что в комбинации три одинаковых игрока
            if players.count == 3, Set(players).count == 1 {
                // Если только один игрок, возвращаем его как победителя
                return players.first
            }
        }
        // Если победитель не найден, возвращаем nil
        return nil
    }
    
    /// Завершает игру и отображает экран с результатом.
    /// - Parameter winner: Игрок, который выиграл игру, или nil, если игра закончилась вничью.
    /// - Parameter winner: Игрок, который выиграл игру, или nil, если игра закончилась вничью.
    private func finishGame(with winner: Player?) {
        let result: GameResult
        
        // Определяем результат игры на основе наличия победителя
        if let winner = winner {
            result = winner == .cross ? .win : .lose
            
            if let winningCombination = winningCombinations.first(where: { combination in
                let players = combination.compactMap { gameState[$0] }
                return players.count == 3 && Set(players).count == 1 && players.first == winner
            }) {
                // Отобразите линию победителя
                showWinningLine(for: winningCombination)
                winningLineView?.isHidden = false
            }
        } else {
            result = .draw
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.delegateGameVC?.finishGame(with: result)
        }
    }

    
    // Метод который мы присваевыем замыканию во вью контроллере
    func reset() {
        if let winningLineView = winningLineView {
                winningLineView.winningPattern = [] // Очистка линии
                winningLineView.isHidden = true // Скрыть WinningLineView
        }
        gameState = Array(repeating: .none, count: 9)
        currentPlayer = .cross
        delegatePI?.updateIndicator(for: currentPlayer)
        for button in gameButtons {
            if let imageView = button.subviews.compactMap({ $0 as? UIImageView }).first {
                imageView.image = nil
            }
        }
    }
    
    private func showWinningLine(for combination: Set<Int>) {
        winningLineView?.removeFromSuperview()
            winningLineView = LineWinnerView()
            winningLineView?.winningPattern = combination

            guard let winningLineView = winningLineView else { return }
            addSubview(winningLineView)

            winningLineView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                winningLineView.topAnchor.constraint(equalTo: topAnchor),
                winningLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
                winningLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
                winningLineView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

}

extension GameBoard {
    private struct Constants {
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height
       
        static let horizontalSpacing = screenWidth * (20 / 390)
        static let verticalSpacing = screenHeight * (20 / 844)
        
        static let horizontalMargin = screenWidth * (10 / 390)
        static let verticalMargin = screenHeight * (10 / 844)
    }
}
