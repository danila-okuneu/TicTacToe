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
        label.text = "Player One win!"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let resultImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "Win-Icon")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let playAgainButton: UIButton = createButton(
        title: "Play again",
        titleColor: UIColor(red: 245/255, green: 247/255, blue: 254/255, alpha: 1),
        backgroundColor: UIColor(red: 131/255, green: 128/255, blue: 206/255, alpha: 1),
        borderColor: UIColor(red: 131/255, green: 128/255, blue: 206/255, alpha: 1)
    )

    private let backButton: UIButton = createButton(
        title: "Back",
        titleColor: UIColor(red: 131/255, green: 128/255, blue: 206/255, alpha: 1),
        backgroundColor: UIColor(red: 245/255, green: 247/255, blue: 254/255, alpha: 1),
        borderColor: UIColor(red: 131/255, green: 128/255, blue: 206/255, alpha: 1)
    )

    private let resultStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
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
        view.backgroundColor = UIColor(red: 245/255, green: 247/255, blue: 254/255, alpha: 1)
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
            resultImage.heightAnchor.constraint(equalToConstant: 228),
            resultImage.widthAnchor.constraint(equalToConstant: 228),

            playAgainButton.heightAnchor.constraint(equalToConstant: 72),
            playAgainButton.widthAnchor.constraint(equalTo: buttonStackView.widthAnchor),

            backButton.heightAnchor.constraint(equalToConstant: 72),
            backButton.widthAnchor.constraint(equalTo: buttonStackView.widthAnchor),

            resultStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 160),
            resultStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
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

    private func handlePlayAgain() {
        print("Tapped Play Again")
    }

    private func handleBack() {
        print("Tapped Back")
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.layer.borderWidth = 2
        button.layer.borderColor = borderColor.cgColor
        button.layer.cornerRadius = 30
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

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ResultViewController())
}
