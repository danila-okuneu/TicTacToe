//
//  RulesCell.swift
//  TicTacToe
//
//  Created by Lion on 29.09.2024.
//

import UIKit
import SnapKit

final class RulesCell: UITableViewCell {
    static let identifier = "RulesCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupIndexBackGround()
        setupLabelBackGround()
		backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let indexBackGround = UIView()
    private let labelBackGround = UIView()
    private let label = UILabel()
    private let indexLabel = UILabel()
    public func configure(with text: String, index: String) {
        label.text = text
        indexLabel.text = index
    }
}

private extension RulesCell {
    func setupIndexBackGround() {
        contentView.addSubview(indexBackGround)
        indexBackGround.addSubview(indexLabel)
        indexBackGround.layer.cornerRadius = 22.5
		indexBackGround.backgroundColor = UIColor.app(.purple) // .basicLightBlue тут появилась ошибка на вермя поставлено чтобы проверить проект
        indexBackGround.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(21)
            $0.top.equalToSuperview()
            $0.size.equalTo(45)
        }
        indexLabel.font = .systemFont(ofSize: 20, weight: .regular)
        indexLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    func setupLabelBackGround() {
        contentView.addSubview(labelBackGround)
        labelBackGround.layer.cornerRadius = 30
        labelBackGround.addSubview(label)
		labelBackGround.backgroundColor = UIColor.app(.lightBlue) //.basicLightBlue тут ошибка на вермя поставлено чтобы проверить проект
        labelBackGround.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(21)
            $0.leading.equalTo(indexBackGround.snp.trailing).offset(20)
        }
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
    }
}
