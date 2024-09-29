//
//  SkinsCardView.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 29.09.24.
//

import UIKit
import SnapKit

final class SkinsCardView: UIView {
	
	weak var delegate: SkinsCardViewDelegate?
	
	var isSelected: Bool = false {
		didSet {
			UIView.animate(withDuration: 0.2) {
				self.selectButton.backgroundColor = self.isSelected ? UIColor.app(.activeButton) : UIColor.app(.unactiveButton)
				self.selectButton.setTitleColor(self.isSelected ? .white : UIColor.app(.black), for: .normal)
				self.selectButton.setTitle(self.isSelected ? "Picked" : "Choose", for: .normal)
			}
		}
	}
	
	// MARK: - UI Components
	private let xSkinView = UIImageView()
	private let oSkinView = UIImageView()
	
	private let hStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = 10
		stack.distribution = .fillEqually
		return stack
	}()

	private let selectButton: UIButton = {
		let button = UIButton()
		button.setTitle("Select", for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
		button.setTitleColor(UIColor.app(.black), for: .normal)
		button.backgroundColor = UIColor.app(.unactiveButton)
		button.layer.cornerRadius = 23
		return button
	}()
	
	
	// MARK: - Initializers
	init(skinPair: Int) {
		isSelected = false
		super.init(frame: .zero)
		
		let skins = Skins.get(pair: skinPair)
		xSkinView.image = skins.x
		oSkinView.image = skins.o
		
		setupViews()
		setupConstraints()
	
		selectButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	// MARK: - Private methods
	
	
	private func setupViews() {
		backgroundColor = .white
		layer.cornerRadius = 30
		
		xSkinView.contentMode = .scaleAspectFit
		oSkinView.contentMode = .scaleAspectFit
		addSubview(hStack)
		addSubview(selectButton)
		
		hStack.addArrangedSubview(xSkinView)
		hStack.addArrangedSubview(oSkinView)
		
	}
	
	
	func setupConstraints() {
		
		snp.makeConstraints { make in
			make.height.equalTo(snp.width)
		}
		
		
		hStack.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(20)
			make.left.equalToSuperview().inset(20)
			make.right.equalToSuperview().inset(20)
			
			make.bottom.equalTo(snp.centerY).inset(20)
		}
		
		
		selectButton.snp.makeConstraints { make in
			
			make.height.equalToSuperview().dividedBy(3.5)
			make.bottom.equalToSuperview().inset(20)
			make.left.right.equalToSuperview().inset(20)
			
		}
	}
	
	
	func toggleButton() {
		
		delegate?.didSelectSkin(self)
	}
	
	
	// MARK: - Targets
	
	@objc private func buttonTapped() {
		toggleButton()
	}
	
	
	
}


protocol SkinsCardViewDelegate: AnyObject {
	func didSelectSkin(_ view: SkinsCardView)
}
