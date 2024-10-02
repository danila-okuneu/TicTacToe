//
//  CustomButtons.swift
//  TicTacToeNew
//
//  Created by Evgeniy on 02.10.2024.
//

import UIKit
import SnapKit

final class CustomSideButton: UIView {
    
    private let imageView = UIImageView()
    private let label = UILabel()
    
    // Инициализатор
	init(image: UIImage, labelText: String) {
        super.init(frame: .zero)
        setupView()
		setContent(image: image, labelText: labelText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Настройка внешнего вида
    private func setupView() {
        // Настройки самой view
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor(red: 230/255, green: 233/255, blue: 249/255, alpha: 1)
        
        // Добавляем imageView и label в вертикальный стек
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        
        addSubview(stackView)
        
        // Настройка констрейнтов
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(54)
            make.height.equalTo(53)
        }
        
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        // Дополнительные настройки для label
        label.textAlignment = .center
        label.textColor = UIColor(named: "Basic-Black")
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    // Метод для задания контента
	private func setContent(image: UIImage, labelText: String) {
		imageView.image = image
        label.text = labelText
    }
}
