//
//  SkinsCardView.swift
//  TicTacToe
//
//  Created by Danila Okuneu on 29.09.24.
//

import UIKit
import SnapKit

final class SkinsCardView: UIView {
    
	var pair: Int
    weak var delegate: SkinsCardViewDelegate?
    
	var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
				self.updateButton()
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
        button.layer.shadowColor = UIColor.app(.activeButton).cgColor
        button.layer.shadowRadius = 5
        button.setTitle("Select", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(UIColor.app(.black), for: .normal)
        button.backgroundColor = UIColor.app(.unactiveButton)
        button.layer.cornerRadius = 23
        return button
    }()
    
    
    // MARK: - Initializers
    init(skinPair: Int) {
		pair = skinPair
		isSelected = skinPair == Skins.selectedPair
		super.init(frame: .zero)
		
		
       
        
		updateButton()
		clipsToBounds = false
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
	
	private func updateButton() {
		self.selectButton.backgroundColor = self.isSelected ? UIColor.app(.activeButton) : UIColor.app(.unactiveButton)
		self.selectButton.setTitleColor(self.isSelected ? .white : UIColor.app(.black), for: .normal)
		self.layer.shadowOpacity = isSelected ? 0.15 : 0
		self.layer.shadowRadius = isSelected ? 10 : 5
		
		self.selectButton.setTitle(self.isSelected ? "Picked" : "Choose", for: .normal)	
	}
    
    
    func toggleButton() {
        
        delegate?.didSelectSkin(self)
    }
    
    
    // MARK: - Targets
    
    @objc private func buttonTapped() {
        toggleButton()
		isSelected = true
		Skins.selectedPair = pair
		UserDefaults.standard.set(pair, forKey: "selectedPair")
    }
    
    
    
}


protocol SkinsCardViewDelegate: AnyObject {
    func didSelectSkin(_ view: SkinsCardView)
}
