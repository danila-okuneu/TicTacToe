//
//  LeaderboardViewController.swift
//  TicTacToe
//
//  Created by Churkin Vitaly on 30.09.2024.
//

import UIKit

final class LeaderboardViewController: UIViewController {

    // MARK: - Properties

    private var leaderboards: [LeaderboardModel]?
    private var durations: [String]?

    // MARK: - Outlets

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Leaderboard"
        label.font = UIFont.systemFont(ofSize: Constants.titleLabelFontSize, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "No game history with turn on time"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.noResultsLabelFontSize, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var leaderboardIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Leaderboard Icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var emptyStateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(noResultsLabel)
        stackView.addArrangedSubview(leaderboardIconImage)
        return stackView
    }()

    private lazy var resultsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .app(.lightPurple)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LeaderboardTableViewCell.self, forCellReuseIdentifier: LeaderboardTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        fetchLeaderboardData()
    }

    // MARK: - Setups

    private func setupView() {
        view.backgroundColor = .app(.lightPurple)
    }

    private func setupNavigationBar() {
        navigationItem.titleView = titleLabel
        let backButtonImage = UIImage(named: "Back-Icon")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: backButtonImage, style: .plain, target: self, action: nil
        )
    }


    private func setupTableView() {
        view.addSubview(resultsTableView)
        setupTableViewLayout()
    }

    private func setupTableViewLayout() {
        NSLayoutConstraint.activate([
            resultsTableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.tableViewTopMargin
            ),
            resultsTableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.tableViewHorizonalMargin
            ),
            resultsTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.tableViewHorizonalMargin
            ),
            resultsTableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }

    private func setupEmptyState() {
        view.addSubview(emptyStateStackView)
        setupEmptyStateLayout()
    }

    private func setupEmptyStateLayout() {
        NSLayoutConstraint.activate([
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
}

// MARK: - Data Fetching

private extension LeaderboardViewController {
    func fetchLeaderboardData() {
        // TODO: здесь будет получение данных из хранилища
        //durations = ["45:30", "15:45", "30:20", "125:10", "50:15"]
        updateUIVisibility()
    }

    func updateUIVisibility() {
        if let durations, !durations.isEmpty {
            setupTableView()
            sortAndUpdateLeaderboards()
        } else {
            setupEmptyState()
        }
    }

    func sortAndUpdateLeaderboards() {
        leaderboards = durations?
            .sorted { timeToSeconds($0) < timeToSeconds($1) }
            .enumerated()
            .map { index, duration in
                LeaderboardModel(position: index + 1, duration: duration, isBest: index == 0)
            }
        resultsTableView.reloadData()
    }

    func timeToSeconds(_ time: String) -> Int {
        let components = time.split(separator: ":").compactMap { Int($0) }
        guard components.count == 2 else { return 0 }
        return components[0] * 60 + components[1]
    }
}

// MARK: - TableView DataSource

extension LeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboards?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LeaderboardTableViewCell.identifier,
            for: indexPath
        ) as? LeaderboardTableViewCell else {
            return UITableViewCell()
        }
        let leaderboard = leaderboards?[indexPath.row]
        cell.leaderboard = leaderboard
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: TableView Delegate

extension LeaderboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableViewHeightForRowAt
    }
}

// MARK: - Constants

extension LeaderboardViewController {
    private struct Constants {
        // Fixed sizes
        static let titleLabelFontSize: CGFloat = 24
        static let noResultsLabelFontSize: CGFloat = 20

        // Getting screen dimensions
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height

        // Relative sizes
        static let stackViewTopMargin: CGFloat = screenHeight * (169 / 844)
        static let stackViewWidthSize: CGFloat = screenWidth * (177 / 390)
        static let stackViewSpacing: CGFloat = screenHeight * (40 / 844)
        static let tableViewTopMargin: CGFloat = screenHeight * (40 / 844)
        static let tableViewHorizonalMargin: CGFloat = screenWidth * (21 / 390)
        static let tableViewHeightForRowAt: CGFloat = screenHeight * (77 / 844)
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: LeaderboardViewController())
}
