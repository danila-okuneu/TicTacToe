//
//  TimeView.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 29.09.24.
//

import UIKit
import SnapKit


class TimeToggleView: UIView {
	
	let timeSwitch: UISwitch = {
		let toggle = UISwitch()
		toggle.onTintColor = UIColor.app(.activeButton)
		toggle.isOn = Saves.timeMode
		return toggle
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.text = "Turn on the time"
		label.font = .systemFont(ofSize: 18, weight: .semibold)
		label.numberOfLines = 1
		label.textColor = UIColor.app(.black)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
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
		backgroundColor = UIColor.app(.unactiveButton)
		layer.cornerRadius = 30
	}
	private func addViews() {
		addSubview(titleLabel)
		addSubview(timeSwitch)
	}
	
	
	private func makeConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.left.equalToSuperview().inset(10)
			make.centerY.equalToSuperview()
			make.height.equalTo(20)
			make.width.equalToSuperview().dividedBy(2)
		}
		
		timeSwitch.snp.makeConstraints { make in
			make.right.equalToSuperview().inset(10)
			make.centerY.equalToSuperview()
			make.height.equalTo(30)
			
		}
	}
}
