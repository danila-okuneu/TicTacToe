//
//  Untitled.swift
//  TicTacToe
//
//  Vladimir
//

import UIKit
import SnapKit

class RulesViewController: UITableViewController {
	
    let rules: [String] = ["Draw a grid with three rows and three columns, creating nine squares in total.", "Players take turns placing their marker (X or O) in an empty square.\nTo make a move, a player selects a number corresponding to the square where they want to place their marker.", "Player X starts by choosing a square (e.g., square 5).\nPlayer O follows by choosing an empty square (e.g., square 1).\nContinue alternating turns until the game ends.", "The first player to align three of their markers horizontally, vertically, or diagonally wins.\nExamples of Winning Combinations:\nHorizontal: Squares 1, 2, 3 or 4, 5, 6 or 7, 8, 9\nVertical: Squares 1, 4, 7 or 2, 5, 8 or 3, 6, 9\nDiagonal: Squares 1, 5, 9 or 3, 5, 7"]
        
	override func viewDidLoad() {
		super.viewDidLoad()
        tableView.register(RulesCell.self, forCellReuseIdentifier: RulesCell.identifier)
	}

	
}

extension RulesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rules.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RulesCell.identifier, for: indexPath) as? RulesCell else {
            fatalError()
        }
        cell.configure(with: rules[indexPath.row])
        return cell
    }
}

final class RulesCell: UITableViewCell {
    static let identifier = "RulesCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupRulesLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let rulesLabel = UILabel()
    public func configure(with text: String) {
        rulesLabel.text = text
    }
}

private extension RulesCell {
    func setupRulesLabel() {
        rulesLabel.numberOfLines = 0
        contentView.addSubview(rulesLabel)
        rulesLabel.translatesAutoresizingMaskIntoConstraints = false
        rulesLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        rulesLabel.backgroundColor = .systemGray6
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: RulesViewController())
}
