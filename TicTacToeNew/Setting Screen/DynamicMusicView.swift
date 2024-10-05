//
//  DynamicTimeView.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 1.10.24.
//
import UIKit
import SnapKit
final class DynamicMusicView: UIView, Dynamic, DynamicDelegate {
	
	
	func dynamicViewDidChangedHeight(_ dynamicTimeView: Dynamic) {
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
			self.layoutIfNeeded()
			self.change(height: self.musicView.bounds.height + 80, for: self)
			self.delegate?.dynamicViewDidChangedHeight(self)
		}
	}

	
	weak var delegate: DynamicDelegate?
	
	// MARK: - UI Components
	private let musicToggleView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.app(.lightPurple)
		view.layer.cornerRadius = 30
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let musicSwitch: UISwitch = {
		let toggle = UISwitch()
		toggle.onTintColor = UIColor.app(.activeButton)
		toggle.isOn = Saves.isMusicOn
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
	
	private let musicView = MusicView()
	
	
	// MARK: - Initializer
	
	init() {
		super.init(frame: .zero)
		
		clipsToBounds = true
		musicSwitch.addTarget(self, action: #selector(switchTime), for: .valueChanged)
		setupViews()
		musicView.delegate = self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Layout
	
	private func setupViews() {
		
		addSubview(musicView)
		addSubview(musicToggleView)
		
		musicToggleView.addSubview(titleLabel)
		musicToggleView.addSubview(musicSwitch)
		
		makeConstraints()
	}
	
	
	private func makeConstraints() {
		
		
		snp.makeConstraints { make in
			make.height.equalTo(Saves.isMusicOn ? 140 : 60)

		}
		musicToggleView.snp.makeConstraints { make in
			make.height.equalTo(60)
			make.top.equalToSuperview()
			make.left.equalToSuperview()
			make.right.equalToSuperview()
		}
		
		musicView.snp.makeConstraints { make in
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
		
		musicSwitch.snp.makeConstraints { make in
			make.right.equalToSuperview().inset(10)
			make.centerY.equalToSuperview()
			make.height.equalTo(30)
		}
	}
	
	@objc private func buttonTapped(_ sender: UIButton) {
		
		
		sender.layer.opacity = 0.7
		UIView.animate(withDuration: 0.2, delay: 0.1) {
			sender.layer.opacity = 1
		}
		
		
	}
	
	@objc private func switchTime() {
		Saves.isMusicOn.toggle()
		UserDefaults.standard.set(Saves.isMusicOn, forKey: "musicOn")
		musicView.isOptionsVisible = false
		change(opacity: Saves.isMusicOn ? 1 : 0, for: musicView)
		change(height: Saves.isMusicOn ? musicView.bounds.height + 80 : 60, for: self)

		delegate?.dynamicViewDidChangedHeight(self)
	}
	
}



