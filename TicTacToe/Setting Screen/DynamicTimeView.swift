//
//  DynamicTimeView.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 1.10.24.
//

import UIKit
import SnapKit

final class DynamicTimeView: UIView {
	
	weak var delegate: DynamicTimeViewDelegate?
	private var heightConstraint: Constraint?
	
	
	// MARK: - UI Components
	private let timeToggleView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.app(.lightPurple)
		view.layer.cornerRadius = 30
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let timeSwitch: UISwitch = {
		let toggle = UISwitch()
		toggle.onTintColor = UIColor.app(.activeButton)
		toggle.isOn = Saves.isTimeMode
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
	
	private let timeView: UIView = {
		let view = UIView()
		view.layer.opacity = Saves.isTimeMode ? 1 : 0
		view.backgroundColor = UIColor.app(.lightPurple)
		view.layer.cornerRadius = 30
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private let timeLabel: UILabel = {
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
		button.clipsToBounds = true
		button.setTitleColor(UIColor.app(.activeButton), for: .normal)
		button.setTitle("2:00", for: .normal)
		button.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 244/255, alpha: 1)
		button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
		button.layer.cornerRadius = 15
		return button
	}()

	
	// MARK: - Initializer
	
	init() {
		super.init(frame: .zero)
		
		forwardButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
		timeSwitch.addTarget(self, action: #selector(switchTime), for: .valueChanged)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Layout
	
	private func setupViews() {
		
		addSubview(timeView)
		addSubview(timeToggleView)
		
		timeToggleView.addSubview(titleLabel)
		timeToggleView.addSubview(timeSwitch)
		
		timeView.addSubview(timeLabel)
		timeView.addSubview(playTime)
		timeView.addSubview(forwardButton)
		
		makeConstraints()
	}
	
	
	private func makeConstraints() {
		
		
		snp.makeConstraints { make in
			self.heightConstraint = make.height.equalTo(Saves.isTimeMode ? 140 : 60).constraint
		}

		timeToggleView.snp.makeConstraints { make in
			make.height.equalTo(60)
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		timeView.snp.makeConstraints { make in
			make.height.equalTo(60)
			make.bottom.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
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
		
		timeLabel.snp.makeConstraints { make in
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
			make.height.equalTo(30)
			make.width.equalTo(50)
			
		}
	}
	
	@objc private func buttonTapped(_ sender: UIButton) {
		
		sender.layer.opacity = 0.7
		UIView.animate(withDuration: 0.2, delay: 0.1) {
			sender.layer.opacity = 1
		}
		
		
	}
	
	
	@objc private func switchTime() {
		Saves.isTimeMode.toggle()
		
		self.heightConstraint?.update(offset: Saves.isTimeMode ? 140 : 60)
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut) {
			   self.layoutIfNeeded()
			   self.timeView.layer.opacity = Saves.isTimeMode ? 1 : 0
		   }
		
		delegate?.timeViewDidChangedHeight(self)
	}
}



protocol DynamicTimeViewDelegate: AnyObject {
	func timeViewDidChangedHeight(_ dynamicTimeView: DynamicTimeView)
}
