//
//  SettingVC.swift
//  TicTacToe
//
//  Danila
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
	
	private var selectedSkins: SkinsCardView?
	
	private let timeToggleView = TimeToggleView()
	
	private let timeView: UIView = TimeView()
	
	private lazy var skinsVStack: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 20
		stackView.distribution = .fillEqually
		return stackView
	}()
	
	private let firstSkinsView = SkinsCardView(skinPair: 1)
	private let secondSkinsView = SkinsCardView(skinPair: 2)
	private let thirdSkinsView = SkinsCardView(skinPair: 3)
	private let fourthSkinsView = SkinsCardView(skinPair: 4)
	private let fifthSkinsView = SkinsCardView(skinPair: 5)
	private let sixthSkinsView = SkinsCardView(skinPair: 6)

	
	private lazy var firstHStack = SkinsHorizontalStackView(views: firstSkinsView, secondSkinsView)
	private lazy var secondHStack = SkinsHorizontalStackView(views: thirdSkinsView, fourthSkinsView)
	private lazy var thirdHStack = SkinsHorizontalStackView(views: fifthSkinsView, sixthSkinsView)
	
	
	// MARK: - Life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.app(.lightPurple)
		
		addViews()
		makeConstraints()
		setDelegates()
		
		
		skinsVStack.dropShadow()
		timeToggleView.dropShadow()
		timeView.dropShadow()
	}
	
	
	private func addViews() {
		
		view.addSubview(skinsVStack)
		view.addSubview(timeToggleView)
		view.addSubview(timeView)
		skinsVStack.addArrangedSubview(firstHStack)
		skinsVStack.addArrangedSubview(secondHStack)
		skinsVStack.addArrangedSubview(thirdHStack)
	}

	private func makeConstraints() {
		
		skinsVStack.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
			make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(20)
			make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(20)
		}
		
		timeToggleView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
			make.centerX.equalToSuperview()
			make.height.equalTo(60)
			make.left.equalToSuperview().inset(50)
			make.right.equalToSuperview().inset(50)
		}
		
		timeView.snp.makeConstraints { make in
			make.top.equalTo(timeToggleView.snp.bottom).inset(-20)
			make.centerX.equalToSuperview()
			make.height.equalTo(60)
			make.left.equalToSuperview().inset(50)
			make.right.equalToSuperview().inset(50)

			
		}
		
		
	}
	
	
	private func setDelegates() {
		
		firstSkinsView.delegate = self
		secondSkinsView.delegate = self
		thirdSkinsView.delegate = self
		fourthSkinsView.delegate = self
		fifthSkinsView.delegate = self
		sixthSkinsView.delegate = self
	}
}


// MARK: - Extensions
extension SettingsViewController: SkinsCardViewDelegate {
	
	func didSelectSkin(_ view: SkinsCardView) {
		if let selectedSkinView = selectedSkins, selectedSkinView != view {
			selectedSkinView.isSelected = false
		}
		selectedSkins = view
		view.isSelected = true
	}
	
}
