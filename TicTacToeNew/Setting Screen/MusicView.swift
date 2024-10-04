//
//  MusicView.swift
//  TicTacToeNew
//
//  Created by Danila Okuneu on 4.10.24.
//

import UIKit
import SnapKit

final class MusicView: UIView, Dynamic {
	
	
	private let label: UILabel = {
		let label = UILabel()
		label.text = "Select song"
		label.font = .systemFont(ofSize: 20, weight: .semibold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let optionsButton: UIButton = {
		let button = UIButton()
		let appearance = UIImage.SymbolConfiguration(hierarchicalColor: UIColor.app(.activeButton))
		button.setImage(UIImage(systemName: "chevron.down.circle.fill", withConfiguration: appearance), for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	private let songsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 10
		stackView.distribution = .fillEqually
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	
	// MARK: - Initializers
	init() {
		super.init(frame: .zero)
		
		setupView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Layout
	private func setupView() {
		backgroundColor = UIColor.app(.lightPurple)
		layer.cornerRadius = 25
		
		addViews()
		makeConstraints()
	}
	
	private func addViews() {
		addSubview(label)
	}
	
	private func makeConstraints() {
		
		label.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(10)
			make.left.equalToSuperview().offset(10)
			make.height.equalTo(20)
		}
	}
	
	
	
}


struct Songs {
	
	static let list: [String] = ["Song 1", "Song 2", "Song 3"]
	
}
