//
//  TimeView.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 29.09.24.
//

import UIKit
import SnapKit


class TimeView: UIView {
	

	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.text = "Time for game"
		label.font = .systemFont(ofSize: 18, weight: .semibold)
		label.numberOfLines = 1
		label.textColor = UIColor.app(.black)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let playTime: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.text = "2:00"
		label.font = .systemFont(ofSize: 18, weight: .semibold)
		label.numberOfLines = 1
		label.textColor = UIColor.app(.black)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	
	private let forwardButton: UIButton = {
		let button = UIButton()
		
		let configuration = UIImage.SymbolConfiguration(hierarchicalColor: UIColor.app(.activeButton))
		
		
		button.setBackgroundImage(UIImage(systemName: "chevron.forward.circle.fill", withConfiguration: configuration), for: .normal)
		
		return button
	}()

	
	// MARK: - Initializers
	init() {
		super.init(frame: .zero)
		
		
		
		setupView()
		addViews()
		makeConstraints()
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Layout
	
	private func setupView() {
		backgroundColor = .white
		layer.cornerRadius = 30
	}
	private func addViews() {
		addSubview(titleLabel)
		addSubview(playTime)
		addSubview(forwardButton)
	}
	
	private func makeConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.left.equalToSuperview().inset(10)
			make.centerY.equalToSuperview()
			make.height.equalTo(20)
			make.width.equalToSuperview().dividedBy(2)
		}
		
		playTime.snp.makeConstraints { make in
			make.left.equalTo(titleLabel.snp.right).inset(10)
			make.height.equalTo(20)
			make.centerY.equalToSuperview()
		}
		
		forwardButton.snp.makeConstraints { make in
			make.right.equalToSuperview().inset(10)
			make.centerY.equalToSuperview()
			make.height.width.equalTo(40)
			
		}
	}
}
