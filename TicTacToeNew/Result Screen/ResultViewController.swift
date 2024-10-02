//
//  ResultVC.swift
//  TicTacToe
//
//  Vitaliy
//

import UIKit

final class ResultViewController: UIViewController {

    // MARK: - Properties

    public var gameResult: GameResult? {
        didSet {
            updateUI()
        }
    }

    // MARK: - Outlets

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: Constants.labelFontSize, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let resultImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let playAgainButton: UIButton = createButton(
        title: "Play again",
        titleColor: Constants.mainBackgroundColor,
        backgroundColor: Constants.accentColor,
        borderColor: Constants.accentColor
    )

    private let backButton: UIButton = createButton(
        title: "Back",
        titleColor: Constants.accentColor,
        backgroundColor: Constants.mainBackgroundColor,
        borderColor: Constants.accentColor
    )

    private let resultStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.buttonStackViewSpacing
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
        view.backgroundColor = Constants.mainBackgroundColor
        navigationItem.hidesBackButton = true
    }

    private func setupHierarchy() {
        resultStackView.addArrangedSubview(resultLabel)
        resultStackView.addArrangedSubview(resultImage)

        buttonStackView.addArrangedSubview(playAgainButton)
        buttonStackView.addArrangedSubview(backButton)

        view.addSubview(resultStackView)
        view.addSubview(buttonStackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            resultImage.heightAnchor.constraint(
                equalToConstant: Constants.resultImageSize
            ),
            resultImage.widthAnchor.constraint(
                equalToConstant: Constants.resultImageSize
            ),
            playAgainButton.heightAnchor.constraint(
                equalToConstant: Constants.buttonHeight
            ),
            playAgainButton.widthAnchor.constraint(
                equalTo: buttonStackView.widthAnchor
            ),
            backButton.heightAnchor.constraint(
                equalToConstant: Constants.buttonHeight
            ),
            backButton.widthAnchor.constraint(
                equalTo: buttonStackView.widthAnchor
            ),
            resultStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.topMargin
            ),
            resultStackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            buttonStackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -Constants.bottomMargin
            ),
            buttonStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.horizontalMargin
            ),
            buttonStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.horizontalMargin
            ),
        ])
    }

    private func setupButtonAction() {
        playAgainButton.addAction(
            UIAction { [weak self] _ in
                self?.handlePlayAgain()
            },
            for: .touchUpInside
        )
        backButton.addAction(
            UIAction { [weak self] _ in
                self?.handleBack()
            },
            for: .touchUpInside
        )
    }

    // MARK: - Action

    // Start the game again
    private func handlePlayAgain() {
        if let gameViewController = navigationController?.viewControllers.first(where: { $0 is GameViewController }) {
            navigationController?.popToViewController(gameViewController, animated: true)
        }
    }

    // Return to the game selection screen
    private func handleBack() {
        if let selectViewController = navigationController?.viewControllers.first(where: { $0 is SelectViewController }) {
            navigationController?.popToViewController(selectViewController, animated: true)
        }
    }

    // MARK: - Helper methods

    private static func createButton(
        title: String,
        titleColor: UIColor,
        backgroundColor: UIColor,
        borderColor: UIColor
    ) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonFontSize, weight: .semibold)
        button.layer.borderWidth = Constants.buttonBorderWidth
        button.layer.borderColor = borderColor.cgColor
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private func updateUI() {
        guard
            let gameResult, let resultModel = ResultModel.results[gameResult]
        else { return }
        resultLabel.text = resultModel.label
        resultImage.image = UIImage(named: resultModel.image)
    }
}

// MARK: - Constants

extension ResultViewController {
    private struct Constants {
        // Fixed sizes
        static let labelFontSize: CGFloat = 20
        static let buttonFontSize: CGFloat = 20
        static let buttonBorderWidth: CGFloat = 2

        // Getting screen dimensions
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height

        // Relative sizes
        static let resultImageSize: CGFloat = screenWidth * (228 / 390)
        static let buttonHeight: CGFloat = screenHeight * (72 / 844)
        static let stackViewSpacing: CGFloat = screenHeight * (20 / 844)
        static let buttonStackViewSpacing: CGFloat = screenHeight * (12 / 844)
        static let topMargin: CGFloat = screenHeight * (160 / 844)
        static let bottomMargin: CGFloat = screenHeight * (18 / 844)
        static let horizontalMargin: CGFloat = screenWidth * (21 / 390)
        static let buttonCornerRadius: CGFloat = screenWidth * (30 / 390)

        // Colors
        static let mainBackgroundColor = UIColor(red: 245/255, green: 247/255, blue: 254/255, alpha: 1)
        static let accentColor = UIColor(red: 131/255, green: 128/255, blue: 206/255, alpha: 1)
    }
}
