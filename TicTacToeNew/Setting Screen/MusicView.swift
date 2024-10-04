//
//  MusicView.swift
//  TicTacToeNew
//
//  Created by Danila Okuneu on 4.10.24.
//

import UIKit
import SnapKit

final class MusicView: UIView, Dynamic {
	
	weak var delegate: DynamicDelegate?
	var isOptionsVisible = false {
		didSet {
			
		change(height: isOptionsVisible ? songsStackView.bounds.height + 80 : 60, for: self)
		 change(opacity: isOptionsVisible ? 1 : 0, for: songsStackView)
		 
		 layoutIfNeeded()
		 delegate?.dynamicViewDidChangedHeight(self)
		}
	}
	
	private let label: UILabel = {
		let label = UILabel()
		label.text = "Select song"
		label.font = .systemFont(ofSize: 18, weight: .semibold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let optionsButton: UIButton = {
		let button = UIButton()
		button.showsMenuAsPrimaryAction = true
		button.changesSelectionAsPrimaryAction = true
		button.setTitle(Saves.selectedSong, for: .normal)
		button.setTitleColor(UIColor.app(.activeButton), for: .normal)
		button.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 244/255, alpha: 1)
		button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
		button.layer.cornerRadius = 15
		return button	}()
	
	private let songsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 10
		stackView.layer.opacity = 0
		stackView.distribution = .fillEqually
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	
	// MARK: - Initializers
	init() {
		super.init(frame: .zero)
		

		setupView()
		optionsButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Layout
	private func setupView() {
		backgroundColor = UIColor.app(.lightPurple)
		layer.cornerRadius = 30
		clipsToBounds = true
		
		addViews()
		makeConstraints()
		setupStackView()
	}
	
	private func addViews() {
		addSubview(songsStackView)
		addSubview(label)
		addSubview(optionsButton)
		
	}
	
	private func makeConstraints() {
		snp.makeConstraints { make in
			make.height.equalTo(60)
		}
		
		label.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(20)
			make.left.equalToSuperview().offset(10)
			make.height.equalTo(20)
		}
		
		optionsButton.snp.makeConstraints { make in
			make.right.equalToSuperview().offset(-15)
			make.height.equalTo(30)
			make.width.equalTo(80)
			make.top.equalToSuperview().offset(15)
		}
		
		songsStackView.snp.makeConstraints { make in
			make.bottom.equalToSuperview().inset(15)
			make.centerX.equalToSuperview()
			make.width.equalToSuperview().offset(-30)
			make.height.equalTo(Songs.list.count * 40 - 10)
		}
	}
	
	private func setupStackView() {
		
		for song in Songs.list {
			
			
			let button = UIButton()
			button.setTitle(song, for: .normal)
			button.backgroundColor = UIColor.app(.lightBlue)
			button.layer.cornerRadius = 15
			button.setTitleColor(UIColor.app(.darkPurple), for: .normal)
			button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
			button.addTarget(self, action: #selector(selectSong), for: .touchUpInside)
			button.translatesAutoresizingMaskIntoConstraints = false
			songsStackView.addArrangedSubview(button)
		}
	}
	
	
	@objc private func buttonTapped() {
		isOptionsVisible.toggle()

	}
	
	
	@objc private func selectSong(_ sender: UIButton) {
		Saves.selectedSong = sender.titleLabel?.text ?? "Song 1"
		optionsButton.setTitle(Saves.selectedSong, for: .normal)
		isOptionsVisible = false
		UserDefaults.standard.set(Saves.selectedSong, forKey: "selectedSong")
	}
}


struct Songs {
	
	static let list: [String] = ["Song 1", "Song 2", "Song 3"]
	
}
