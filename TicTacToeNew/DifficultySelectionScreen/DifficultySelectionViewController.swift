//
//  DifficultySelectionViewController.swift
//  TicTacToeNew
//
//  Created by Churkin Vitaly on 05.10.2024.
//

import UIKit

final class DifficultySelectionViewController: UIViewController {

    // MARK: - Properties

    private let gameMode: GameMode = .singlePlayer

    // MARK: - Outlets

    private let selectLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Game"
        label.textColor = .app(.black)
        label.font = UIFont.systemFont(
            ofSize: Constants.selectLabelFontSize,
            weight: .bold
        )
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let easyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Easy", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.buttonLabelFontSize,
            weight: .semibold
        )
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .app(.lightBlue)
        button.layer.cornerRadius = Constants.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let standardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Standard", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.buttonLabelFontSize,
            weight: .semibold
        )
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .app(.lightBlue)
        button.layer.cornerRadius = Constants.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let hardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hard", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(
            ofSize: Constants.buttonLabelFontSize,
            weight: .semibold
        )
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .app(.lightBlue)
        button.layer.cornerRadius = Constants.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.stackViewSpacing
        stackView.backgroundColor = .white

        stackView.layer.cornerRadius = Constants.cornerRadius
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOpacity = 0.150
        stackView.layer.shadowOffset = CGSize(width: 4, height: 4)
        stackView.layer.shadowRadius = 10

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        setupButtonAction()
    }

    // MARK: - Setups

    private func setupView() {
        view.backgroundColor = .app(.lightBlue)
    }

    private func setupHierarchy() {
        [selectLabel, hardButton, standardButton, easyButton]
            .forEach { stackView.addArrangedSubview($0) }
        view.addSubview(stackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            stackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            stackView.heightAnchor.constraint(
                equalToConstant: Constants.stackViewHeight
            ),
            stackView.widthAnchor.constraint(
                equalToConstant: Constants.stackViewWidth
            ),
            selectLabel.topAnchor.constraint(
                equalTo: stackView.topAnchor,
                constant: Constants.verticalPadding
            ),
            hardButton.heightAnchor.constraint(
                equalToConstant: Constants.buttonHeight
            ),
            hardButton.leadingAnchor.constraint(
                equalTo: stackView.leadingAnchor,
                constant: Constants.horizontalPadding
            ),
            hardButton.trailingAnchor.constraint(
                equalTo: stackView.trailingAnchor,
                constant: -Constants.horizontalPadding
            ),
            standardButton.heightAnchor.constraint(
                equalToConstant: Constants.buttonHeight
            ),
            standardButton.leadingAnchor.constraint(
                equalTo: stackView.leadingAnchor,
                constant: Constants.horizontalPadding
            ),
            standardButton.trailingAnchor.constraint(
                equalTo: stackView.trailingAnchor,
                constant: -Constants.horizontalPadding
            ),
            easyButton.heightAnchor.constraint(
                equalToConstant: Constants.buttonHeight
            ),
            easyButton.leadingAnchor.constraint(
                equalTo: stackView.leadingAnchor,
                constant: Constants.horizontalPadding
            ),
            easyButton.trailingAnchor.constraint(
                equalTo: stackView.trailingAnchor,
                constant: -Constants.horizontalPadding
            ),
        ])
    }

    private func setupButtonAction() {
        easyButton.addAction(
            UIAction { [weak self] _ in
                self?.handleButtonTapped(difficultyLevel: .easy)
            },
            for: .touchUpInside
        )
        standardButton.addAction(
            UIAction { [weak self] _ in
                self?.handleButtonTapped(difficultyLevel: .standart)
            },
            for: .touchUpInside
        )
        hardButton.addAction(
            UIAction { [weak self] _ in
                self?.handleButtonTapped(difficultyLevel: .hard)
            },
            for: .touchUpInside
        )
    }

    // MARK: - Actions

    private func handleButtonTapped(difficultyLevel: DifficultyLevel) {
        let gameViewController = GameViewController()
        gameViewController.gameMode = gameMode
        gameViewController.difficultyLevel = difficultyLevel
        navigationController?.pushViewController(gameViewController, animated: true)
    }
}

// MARK: - Constants

extension DifficultySelectionViewController {
    private struct Constants {
        // Fixed sizes
        static let selectLabelFontSize: CGFloat = 24
        static let buttonLabelFontSize: CGFloat = 20

        // Getting screen dimensions
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height

        // Relative sizes
        static let buttonHeight: CGFloat = screenHeight * (64 / 844)
        static let cornerRadius: CGFloat = screenWidth * (30 / 390)
        static let stackViewSpacing: CGFloat = screenHeight * (20 / 844)
        static let stackViewHeight: CGFloat = screenHeight * (336 / 844)
        static let stackViewWidth: CGFloat = screenWidth * (285 / 390)
        static let verticalPadding: CGFloat = screenHeight * (20 / 844)
        static let horizontalPadding: CGFloat = screenWidth * (20 / 390)
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: DifficultySelectionViewController())
}
