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
    
    private let containerGameBoard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 30
        return view
    }()
    
    private var playerImages: [UIImage] = [UIImage(), UIImage()]
    private var gameButtons: [UIButton] = []
    private var currentPlayer: Player = .cross // Начинаем с крестика
    
    // MARK: - Enum for Players
    
    init(_ imagePlayerOne: UIImage, _ imagePlayerTwo: UIImage, delegateVC: GameResultable) {
        super.init(frame: .zero)
        addSubview(containerGameBoard)
        playerImages[0] = imagePlayerOne
        playerImages[1] = imagePlayerTwo
        delegateGameVC = delegateVC
        setupGameButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(containerGameBoard)
        setupGameButtons()
    }
    
    private func setupGameButtons() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        containerGameBoard.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(containerGameBoard).inset(20)
        }
     
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
        rowStackView.spacing = 20
        rowStackView.distribution = .fillEqually
        return rowStackView
    }
    
    private func createGameButton() -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.app(.lightBlue)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        button.addSubview(imageView)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: button.topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 10),
            imageView.rightAnchor.constraint(equalTo: button.rightAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 53),
            imageView.widthAnchor.constraint(equalToConstant: 54)
        ])
        
        button.addTarget(self, action: #selector(gameButtonTapped(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 74).isActive = true
        button.heightAnchor.constraint(equalToConstant: 73).isActive = true
        
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
               
           } else {
               result = .draw
           }
           delegateGameVC?.finishGame(with: result)
       }

    
    // Метод который мы присваевыем замыканию во вью контроллере
    func reset() {
        gameState = Array(repeating: .none, count: 9)
        currentPlayer = .cross
        delegatePI?.updateIndicator(for: currentPlayer)
        for button in gameButtons {
            if let imageView = button.subviews.compactMap({ $0 as? UIImageView }).first {
                imageView.image = nil
            }
        }
    }
}
