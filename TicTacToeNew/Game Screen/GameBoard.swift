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

    var difficultyLevel: DifficultyLevel?    
    private var winningLineView: LineWinnerView?
    
    private var gameState: [Player?] = Array(repeating: nil, count: 9)
    private let winningCombinations: [Set<Int>] = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6],
    ]

    // делегат для передачи результата игры и перехода на другой экран
    weak var delegateGameVC: GameResultable?
    weak var delegatePI: PlayerIndicatorDelegate?

    private var playerImages: [UIImage] = [UIImage(), UIImage()]
    private var gameButtons: [UIButton] = []
    private var currentPlayer: Player = .cross // Начинаем с крестика
    private let gameMode: GameMode?

    // MARK: - Enum for Players

    init(_ imagePlayerOne: UIImage, _ imagePlayerTwo: UIImage, delegateVC: GameResultable, gameMode: GameMode?) {
        self.gameMode = gameMode
        super.init(frame: .zero)
        playerImages[0] = imagePlayerOne
        playerImages[1] = imagePlayerTwo
        delegateGameVC = delegateVC
        setupGameButtons()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

        if let imageView = sender.subviews.compactMap({ $0 as? UIImageView }).first {
            imageView.image = currentPlayer == .cross ? playerImages[0] : playerImages[1]

            checkGameState()
            handleNextPlayerTurn(sender)
        }
    }

    // MARK: - Game Logic

    // Проверяет текущее состояние игры для определения победителя или ничьей.
    private func checkGameState() {
        if let winner = determineWinner() {
            finishGame(with: winner)
        } else if gameState.allSatisfy({ $0 != nil }) {
            finishGame(with: nil)
        }
    }

    // Обрабатывает ход текущего игрока и переключает ход на следующего игрока (или бота).
    private func handleNextPlayerTurn(_ sender: UIButton) {
        if gameMode == .singlePlayer {
            sender.isUserInteractionEnabled = false
            currentPlayer = .cross
            botTurn()
        } else {
            currentPlayer = currentPlayer == .cross ? .nought : .cross
            delegatePI?.updateIndicator(for: currentPlayer)
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

        if let winner = winner {
            result = winner == .cross ? .win : .lose
        } else {
            result = .draw
        }
        delegateGameVC?.finishGame(with: result)

        // Разблокируем все кнопки после завершения игры
        gameButtons.forEach { $0.isUserInteractionEnabled = true }
    }

    // MARK: - Public Methods

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

// MARK: - Bot Logic

extension GameBoard {
    // Метод, выполняющий ход бота
    private func botTurn() {
        guard gameMode == .singlePlayer else { return }

        var index: Int?

        switch difficultyLevel {
        case .easy:
            index = makeRandomMove()
        case .standart:
            index = bestMoveWithBlocking()
        case .hard:
            index = bestMove()
        case .none:
            return
        }

        if let index = index {
            gameState[index] = .nought
            if let imageView = gameButtons[index].subviews.compactMap({ $0 as? UIImageView }).first {
                imageView.image = playerImages[1]
            }
            checkGameState()
        }
    }

    // Метод, который позволяет боту сделать случайный ход
    private func makeRandomMove() -> Int? {
        let availableMoves = gameState.indices.filter { gameState[$0] == nil }
        return availableMoves.randomElement()
    }

    // Метод, который позволяет боту блокировать ходы игрока и делать случайный ход, если такой возможности нет
    private func bestMoveWithBlocking() -> Int? {
        for index in 0..<gameState.count {
            if gameState[index] == nil {
                gameState[index] = .cross

                if determineWinner() == .cross {
                    gameState[index] = nil
                    return index
                }
                gameState[index] = nil
            }
        }
        return makeRandomMove()
    }

    // Метод, который использует алгоритм минимакс для нахождения наилучшего хода
    private func bestMove() -> Int? {
        var bestScore = Int.min // Инициализируем наихудший балл для бота
        var move: Int?

        // Проходим по всем доступным ходам
        for index in 0..<gameState.count {
            if gameState[index] == nil {
                gameState[index] = .nought // Бот делает ход

                // Получаем оценку хода с помощью алгоритма минимакс
                let score = minimax(for: .cross, depth: 0) // Просчитываем ответный ход игрока
                gameState[index] = nil // Откатываем ход

                // Выбираем ход с наилучшим результатом
                if score > bestScore {
                    bestScore = score // Обновляем наилучший балл
                    move = index // Запоминаем индекс наилучшего хода
                }
            }
        }

        return move // Возвращаем индекс наилучшего хода
    }

    // Алгоритм минимакс для вычисления наилучшего результата для текущего игрока
    private func minimax(for player: Player, depth: Int) -> Int {
        if let winner = determineWinner() {
            // Если есть победитель, возвращаем соответствующее значение
            return winner == .nought ? 10 - depth : depth - 10
        }

        // Если ничья, возвращаем 0
        if gameState.allSatisfy({ $0 != nil }) {
            return 0
        }

        var bestScore = (player == .nought) ? Int.min : Int.max

        // Проходим по всем доступным ходам
        for index in 0..<gameState.count {
            if gameState[index] == nil {
                gameState[index] = player // Делаем ход

                // Вызываем минимакс для вычисления ответа противника
                let score = minimax(for: (player == .nought) ? .cross : .nought, depth: depth + 1)
                gameState[index] = nil // Откатываем ход

                // Обновляем лучший балл в зависимости от текущего игрока
                bestScore = (player == .nought) ? max(score, bestScore) : min(score, bestScore)
            }
        }

        return bestScore // Возвращаем лучший балл
    }
}
