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
    
    private var winningLineView: LineWinnerView?
    
    var resetGame: (() -> Void)?
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "1.50"
        label.textAlignment = .center
        label.textColor = UIColor.app(.black)
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize, weight: .semibold)
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
            gameBoardView.heightAnchor.constraint(equalToConstant: Constants.gameBoardHeightt),
            gameBoardView.widthAnchor.constraint(equalToConstant: Constants.gameBoardWidth),
            gameBoardView.topAnchor.constraint(equalTo: gameHeaderInfo.bottomAnchor, constant: Constants.gameBoardTopMargin),
            gameBoardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.gameBoardLeadingMargin),
            gameBoardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.gameBoardTrailingMargin),
            gameBoardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.gameBoardBottomMargin),
        ])
        gameBoardView.delegatePI = currentStepView
        resetGame = gameBoardView.reset
    }
    
    private func initialCurrentStepView() {
        view.addSubview(currentStepView)
        currentStepView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentStepView.topAnchor.constraint(equalTo: gameHeaderInfo.bottomAnchor, constant: Constants.CurrentPlayerIndicatorTopMargin),
            currentStepView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentStepView.widthAnchor.constraint(equalToConstant: Constants.CurrentPlayerIndicatorWidth),
            currentStepView.heightAnchor.constraint(equalToConstant: Constants.CurrentPlayerIndicatorHeight)
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
            gameHeaderInfo.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.headerInfoTopMargin),
            gameHeaderInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.headerInfoLeadingMargin),
            gameHeaderInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.headerInfoTrailngMargin),
            gameHeaderInfo.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.headerInfoBottomMargin),
            
            gameHeaderInfo.heightAnchor.constraint(equalToConstant: Constants.headerInfoHeight),
            gameHeaderInfo.widthAnchor.constraint(equalToConstant: Constants.headerInfoWidth),
        ])
        
        NSLayoutConstraint.activate([
            cardOnePlyaer.topAnchor.constraint(equalTo: gameHeaderInfo.topAnchor),
            cardOnePlyaer.leadingAnchor.constraint(equalTo: gameHeaderInfo.leadingAnchor),
            cardOnePlyaer.bottomAnchor.constraint(equalTo: gameHeaderInfo.bottomAnchor),
            cardOnePlyaer.heightAnchor.constraint(equalToConstant: Constants.playerCardContainerHeight),
            cardOnePlyaer.widthAnchor.constraint(equalToConstant: Constants.playerCardContainerWidth),
            

            timerLabel.centerXAnchor.constraint(equalTo: gameHeaderInfo.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: gameHeaderInfo.centerYAnchor),

            cardTwoPlayer.topAnchor.constraint(equalTo: gameHeaderInfo.topAnchor),
            cardTwoPlayer.trailingAnchor.constraint(equalTo: gameHeaderInfo.trailingAnchor),
            cardTwoPlayer.bottomAnchor.constraint(equalTo: gameHeaderInfo.bottomAnchor),
            cardTwoPlayer.heightAnchor.constraint(equalToConstant: Constants.playerCardContainerHeight),
            cardTwoPlayer.widthAnchor.constraint(equalToConstant: Constants.playerCardContainerWidth),
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

extension GameViewController {
    private struct Constants {
        // Fixed sizes
        static let labelFontSize = screenWidth * (20 / 390)
        // Getting screen dimensions
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height
        static let stackViewSpacing: CGFloat = screenHeight * (20 / 844)
        
        static let gameBoardHeightt = screenHeight * (299 / 844)
        static let gameBoardWidth = screenWidth * (302 / 390)
        static let gameBoardTopMargin = screenHeight * (113 / 844) // до хеадернфо
        static let gameBoardBottomMargin = screenHeight * (217 / 844)
        static let gameBoardLeadingMargin = screenWidth * (44 / 390)
        static let gameBoardTrailingMargin = screenWidth * (44 / 390)
        
        static let CurrentPlayerIndicatorTopMargin = screenHeight * (30 / 844)
        static let CurrentPlayerIndicatorWidth = screenWidth * (221 / 390)
        static let CurrentPlayerIndicatorHeight = screenHeight * (53 / 844)
        
        
        static let headerInfoHeight = screenHeight * (103 / 844)
        static let headerInfoWidth = screenWidth * (330 / 390)
        static let headerInfoLeadingMargin = screenWidth * (30 / 390)
        static let headerInfoTrailngMargin = screenWidth * (30 / 390)
        static let headerInfoBottomMargin = screenHeight * (629 / 844)
        static let headerInfoTopMargin = screenHeight * (112 / 844)
        static let playerCardContainerWidth = screenWidth * (103 / 390)
        static let playerCardContainerHeight = screenHeight * (103 / 844)
        
    }
}

