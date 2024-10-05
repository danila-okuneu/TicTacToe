//
//  GameVC.swift
//  TicTacToe
//
//  Evgeniy
//

import UIKit
import SnapKit

protocol GameResultable: AnyObject {
    func finishGame(with resultGame: GameResult)
}

class GameViewController: UIViewController {

    var gameMode: GameMode?
    var difficultyLevel: DifficultyLevel?
    var resetGame: (() -> Void)?
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "1.50"
        label.textAlignment = .center
        label.textColor = UIColor.app(.black)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let gameHeaderInfo: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currentStepView: CurrentPlayerIndicator = createCurrentStep()
    
    // MARK: - UI Elements
    private lazy var gameBoardView: GameBoard = createGameBoard()
        
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHeaderInfo()
        setupNavigationBar()
        initialGameBoard()
        initialCurrentStepView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let resetGame = resetGame else {
                print("resetGame nil")
                return
        }
        resetGame()
    }
}

extension GameViewController {
    private func initialGameBoard() {
        view.addSubview(gameBoardView)
        
        NSLayoutConstraint.activate([
            gameBoardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 328),
            gameBoardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            gameBoardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
            gameBoardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -217)
        ])
        gameBoardView.delegatePI = currentStepView
        resetGame = gameBoardView.reset
    }
    
    private func initialCurrentStepView() {
        view.addSubview(currentStepView)
        currentStepView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentStepView.topAnchor.constraint(equalTo: gameHeaderInfo.bottomAnchor, constant: 30),
            currentStepView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentStepView.widthAnchor.constraint(equalToConstant: 221),
        ])
    }
    
    private func setupHeaderInfo() {
        let cardOnePlyaer  = PlayerCard(image: Skins.getSelected().x, text: "You")
        let cardTwoPlayer = PlayerCard(image: Skins.getSelected().o, text: "Player Two")
        
        view.addSubview(gameHeaderInfo)
        gameHeaderInfo.addSubview(cardOnePlyaer)
        gameHeaderInfo.addSubview(timerLabel)
        gameHeaderInfo.addSubview(cardTwoPlayer)
        
        NSLayoutConstraint.activate([
            gameHeaderInfo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 112),
            gameHeaderInfo.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 30),
            gameHeaderInfo.trailingAnchor.constraint(greaterThanOrEqualTo: self.view.trailingAnchor, constant: -30),
            gameHeaderInfo.heightAnchor.constraint(equalToConstant: 103),
            gameHeaderInfo.widthAnchor.constraint(equalToConstant: 330),
        ])
        
        NSLayoutConstraint.activate([
            cardOnePlyaer.topAnchor.constraint(equalTo: gameHeaderInfo.topAnchor),
            cardOnePlyaer.leadingAnchor.constraint(equalTo: gameHeaderInfo.leadingAnchor),
            cardTwoPlayer.bottomAnchor.constraint(equalTo: gameHeaderInfo.bottomAnchor),
            
            timerLabel.centerXAnchor.constraint(equalTo: gameHeaderInfo.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: gameHeaderInfo.centerYAnchor),
            
            cardTwoPlayer.topAnchor.constraint(equalTo: gameHeaderInfo.topAnchor),
            cardTwoPlayer.trailingAnchor.constraint(equalTo: gameHeaderInfo.trailingAnchor),
            cardTwoPlayer.bottomAnchor.constraint(equalTo: gameHeaderInfo.bottomAnchor),
        ])
    }
    
    private func createCurrentStep() -> CurrentPlayerIndicator {
        let viewIndicatorStep = CurrentPlayerIndicator()
        return viewIndicatorStep
    }
    
    private func createGameBoard() -> GameBoard {
        let gameBoard = GameBoard(Skins.getSelected().x, Skins.getSelected().o, delegateVC: self)
        gameBoard.translatesAutoresizingMaskIntoConstraints = false
        gameBoard.layer.cornerRadius = 30
        gameBoard.backgroundColor = .white
        gameBoard.layer.shadowColor = UIColor.black.cgColor
        gameBoard.layer.shadowOffset = CGSize(width: 4, height: 4)
        gameBoard.layer.shadowOpacity = 0.3
        gameBoard.layer.shadowRadius = 30
        return gameBoard
    }
}

// Навигация
extension GameViewController {
    
    // MARK: - Navigation Bar
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButtonIcon"), style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// Навигация в конце игры через протокол
extension GameViewController: GameResultable {
    func finishGame(with resultGame: GameResult) {
        let resultViewController = ResultViewController()
        resultViewController.gameResult = resultGame
        navigationController?.pushViewController(resultViewController, animated: true)
    }
}

