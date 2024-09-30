//
//  LeaderboardViewController.swift
//  TicTacToe
//
//  Created by Churkin Vitaly on 30.09.2024.
//

import UIKit

final class LeaderboardViewController: UIViewController {

    // MARK: - Outlets

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Leaderboard"
        label.font = UIFont.systemFont(ofSize: Constants.titleLabelFontSize, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "No game history with turn on time"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.noResultsLabelFontSize, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let leaderboardIconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Leaderboard Icon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let emptyStateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setups

    private func setupView() {
        view.backgroundColor = Constants.mainBackgroundColor
    }

    private func setupHierarchy() {
        [noResultsLabel, leaderboardIconImage].forEach(emptyStateStackView.addArrangedSubview)
        [emptyStateStackView].forEach(view.addSubview)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            noResultsLabel.widthAnchor.constraint(
                equalToConstant: Constants.labelWidthSize
            ),
            leaderboardIconImage.heightAnchor.constraint(
                equalToConstant: Constants.imageHeightSize
            ),
            leaderboardIconImage.widthAnchor.constraint(
                equalTo: emptyStateStackView.widthAnchor
            ),
            emptyStateStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.stackViewTopMargin
            ),
            emptyStateStackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            emptyStateStackView.widthAnchor.constraint(
                equalToConstant: Constants.stackViewWidthSize
            ),
        ])
    }

    private func setupNavigationBar() {
        navigationItem.titleView = titleLabel

        let backButtonImage = UIImage(named: "Back-Icon")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: backButtonImage,
            style: .plain,
            target: self,
            action: nil
        )
    }
}

extension LeaderboardViewController {
    private struct Constants {
        // Fixed sizes
        static let titleLabelFontSize: CGFloat = 24
        static let noResultsLabelFontSize: CGFloat = 20

        // Getting screen dimensions
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height

        // Relative sizes
        static let labelWidthSize: CGFloat = screenWidth * (145 / 390)
        static let imageHeightSize: CGFloat = screenHeight * (228 / 844)
        static let stackViewWidthSize: CGFloat = screenWidth * (177 / 390)
        static let stackViewSpacing: CGFloat = screenHeight * (40 / 844)
        static let stackViewTopMargin: CGFloat = screenHeight * (220 / 844)

        // Colors
        static let mainBackgroundColor = UIColor(red: 245/255, green: 247/255, blue: 254/255, alpha: 1)
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: LeaderboardViewController())
}
