//
//  DynamicTimeView.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 1.10.24.
//
import UIKit
import SnapKit
final class DynamicTimeView: UIView, Dynamic {
	
	
	weak var delegate: DynamicDelegate?
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
	
	
	private let forwardButton: UIButton = {
		let button = UIButton()
		button.clipsToBounds = true
		button.showsMenuAsPrimaryAction = true
		button.changesSelectionAsPrimaryAction = true
		
		button.setTitleColor(UIColor.app(.activeButton), for: .normal)
		button.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 244/255, alpha: 1)
		button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
		button.layer.cornerRadius = 15
		return button
	}()
	
	// MARK: - Initializer
	
	init() {
		super.init(frame: .zero)
		
		timeSwitch.addTarget(self, action: #selector(switchTime), for: .valueChanged)
		setupViews()
		setupMenuButton()
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
		timeView.addSubview(forwardButton)
		
		makeConstraints()
	}
	
	
	private func makeConstraints() {
		
		
		snp.makeConstraints { make in
			make.height.equalTo(Saves.isTimeMode ? 140 : 60)
			
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
			make.right.equalToSuperview().inset(15)
			make.centerY.equalToSuperview()
			make.height.equalTo(30)
		}
		
		timeLabel.snp.makeConstraints { make in
			make.left.equalToSuperview().inset(10)
			make.centerY.equalToSuperview()
			make.height.equalTo(20)
			make.width.equalToSuperview().dividedBy(2)
		}
		
		
		forwardButton.snp.makeConstraints { make in
			make.right.equalToSuperview().inset(15)
			make.centerY.equalToSuperview()
			make.height.equalTo(30)
			make.width.equalTo(80)
			
		}
	}
	
	// MARK: - Methods
	
	private func setupMenuButton() {
		
		var actions: [UIMenuElement] = []
		let actionClosure = { (action: UIAction) in
			Saves.selectedTime = Int(action.title) ?? 60
			print(Saves.selectedTime)
			self.forwardButton.setTitle("\(action.title) sec", for: .normal)
			Saves.set(Saves.selectedTime, for: "selectedTime")

		}
		for time in [60, 90, 120] {
			
			let action = UIAction(title: "\(time)", state: time == Saves.selectedTime ? .on : .off, handler: actionClosure)
			actions.append(action)
		}
		
		forwardButton.menu = UIMenu(options: .displayInline, children: actions)
		forwardButton.setTitle("\(Saves.selectedTime) sec", for: .normal)
	}
	


		
		
		

	// MARK: - Button targets
	@objc private func switchTime() {
		Saves.isTimeMode.toggle()
		UserDefaults.standard.set(Saves.isTimeMode, forKey: "timeMode")
		change(opacity: Saves.isTimeMode ? 1 : 0, for: timeView)
		change(height: Saves.isTimeMode ? timeView.bounds.height + 80 : 60, for: self)

		delegate?.dynamicViewDidChangedHeight(self)
	}
	
}


// MARK: - Dynamic protocols
protocol Dynamic {
	func change(opacity: Float, for view: UIView)
	func change(height: CGFloat, for view: UIView)
}

extension Dynamic where Self: UIView {
	
	func change(opacity: Float, for view: UIView) {
		UIView.animate(withDuration: 0.1) {
			view.layer.opacity = opacity
		}
	}
	
	func change(height: CGFloat, for view: UIView) {
		view.snp.updateConstraints { make in
			make.height.equalTo(height)
		}
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut) {
			view.layoutIfNeeded()
		}
	}
}

protocol DynamicDelegate: AnyObject {
	func dynamicViewDidChangedHeight(_ dynamicTimeView: Dynamic)
}
