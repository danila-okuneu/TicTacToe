//
//  LeaderboardViewController.swift
//  TicTacToe
//
//  Created by Churkin Vitaly on 30.09.2024.
//

import UIKit

final class LeaderboardViewController: UIViewController {

    // MARK: - Properties

	private var leaderboards: [LeaderboardModel] = []
	

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
        label.textAlignment = .center
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
	
	private let clearButton: UIButton = {
		let button = UIButton()
		button.setTitle("Clear", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
		button.tintColor = .white
		button.backgroundColor = UIColor.app(.activeButton)
		button.layer.cornerRadius = 40
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
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
			image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped)
        )
		
		clearButton.addTarget(self, action: #selector(clearResults), for: .touchUpInside)
    }


    private func setupTableView() {
        view.addSubview(resultsTableView)
		view.addSubview(clearButton)
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
            ),
			
			clearButton.heightAnchor.constraint(equalToConstant: 80),
			clearButton.widthAnchor.constraint(equalToConstant: 160),
			clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
			clearButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
			
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
            )
        ])
    }
}

// MARK: - Data Fetching

private extension LeaderboardViewController {
    func fetchLeaderboardData() {
        // TODO: здесь будет получение данных из хранилища
		let results = Results.list
		updateUIVisibility(by: results)
    }

	func updateUIVisibility(by results: [Result]) {
		if !results.isEmpty {
            setupTableView()
            sortAndUpdateLeaderboards()
        } else {
            setupEmptyState()
        }
    }

    func sortAndUpdateLeaderboards() {
		leaderboards = Results.list
			.sorted(by: { $0.time < $1.time } )
            .enumerated()
            .map { index, result in
				LeaderboardModel(position: index + 1, isBest: index == 0, result: result)
            }
        resultsTableView.reloadData()
    }
	
	
	@objc private func backButtonTapped() {
		self.navigationController?.popViewController(animated: true)
	}

	
	@objc private func clearResults() {
		UIView.animate(withDuration: 0.3) {
			self.clearButton.layer.opacity = 0
		}
		Results.list = []
		leaderboards = []
		Results.save()
		resultsTableView.reloadData()
		updateUIVisibility(by: Results.list)
	}
}

// MARK: - TableView DataSource

extension LeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LeaderboardTableViewCell.identifier,
            for: indexPath
        ) as? LeaderboardTableViewCell else {
            return UITableViewCell()
        }
		let leaderboard = leaderboards[indexPath.row]
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

