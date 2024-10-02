//
//  GameVC.swift
//  TicTacToe
//
//  Evgeniy
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - UI Elements
    private let gameBoardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 30
        return view
    }()
    
    private var stackView: UIStackView!
    
    private var gameButtons: [UIButton] = []
    
    private var currentPlayer: Player = .cross // Начинаем с крестика

    // MARK: - Enum for Players
    private enum Player {
        case cross
        case nought
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupGameBoard()
        setupGameButtons()
        setupHeaderView()
		setupNavigationBar()
    }

    
    
}

// Работа с полем игры
extension GameViewController {
    
    // Добавляем поле в иерархию маин вью и ставим ограничения
    private func setupGameBoard() {
        view.addSubview(gameBoardView)

        gameBoardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(328)
            make.left.equalToSuperview().offset(48.5)
            make.right.equalToSuperview().offset(-39.5)
            make.bottom.equalToSuperview().offset(-217)
        }
    }
    
    // Инициализируем кнопки и добавляем в поле игры
    private func setupGameButtons() {
        // Создаем основной стек для кнопок
        stackView = UIStackView()
        stackView.axis = .vertical // Стек будет вертикальным
        stackView.spacing = 20 // Отступ между рядами кнопок
        stackView.distribution = .fillEqually // Кнопки будут равномерно распределены
        gameBoardView.addSubview(stackView) // Добавляем стек на игровое поле

        // Устанавливаем границы для стека
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(gameBoardView).inset(20) // Устанавливаем внутренние отступы
        }

        // Создаем 3 строки с 3 кнопками в каждой
        for _ in 0..<3 {
            let rowStackView = createRowStackView() // Создаем горизонтальный стек для кнопок в строке
            
            // Добавляем кнопки в ряд
            for _ in 0..<3 {
                let button = createGameButton() // Создаем кнопку
                rowStackView.addArrangedSubview(button) // Добавляем кнопку в строку
            }

            stackView.addArrangedSubview(rowStackView) // Добавляем строку в основной стек
        }
    }

    // Функция для создания горизонтального стека для кнопок
    private func createRowStackView() -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal // Стек будет горизонтальным
        rowStackView.spacing = 20 // Отступ между кнопками
        rowStackView.distribution = .fillEqually // Кнопки будут равномерно распределены
        return rowStackView // Возвращаем созданный стек
    }

    // Функция для создания кнопки игры
    private func createGameButton() -> UIButton {
        let button = UIButton(type: .system) // Создаем кнопку типа системной
        button.layer.cornerRadius = 20 // Закругляем углы кнопки
        button.backgroundColor = UIColor(red: 230/255, green: 233/255, blue: 249/255, alpha: 1) // Устанавливаем цвет фона

        // Создаем UIImageView для изображения внутри кнопки
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // Сохраняем пропорции изображения
        imageView.layer.cornerRadius = 4 // Закругляем углы изображения
        imageView.layer.masksToBounds = true // Применяем закругление
        button.addSubview(imageView) // Добавляем изображение в кнопку

        // Устанавливаем ограничения для imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false // Отключаем авторазметку
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: button.topAnchor, constant: 10), // Отступ сверху
            imageView.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 10), // Отступ слева
            imageView.rightAnchor.constraint(equalTo: button.rightAnchor, constant: -10), // Отступ справа
            imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -10) // Отступ снизу
        ])

        // Добавляем действие при нажатии на кнопку
        button.addTarget(self, action: #selector(gameButtonTapped(_:)), for: .touchUpInside)

        // Устанавливаем размеры кнопки
        button.widthAnchor.constraint(equalToConstant: 74).isActive = true // Ширина кнопки
        button.heightAnchor.constraint(equalToConstant: 73).isActive = true // Высота кнопки

        gameButtons.append(button) // Добавляем кнопку в массив кнопок
        return button // Возвращаем созданную кнопку
    }



    @objc private func gameButtonTapped(_ sender: UIButton) {
        // Индекс нажатой кнопки
        guard let index = gameButtons.firstIndex(of: sender) else { return }

        // Проверка не занята ли она
        if let imageView = sender.subviews.compactMap({ $0 as? UIImageView }).first, imageView.image == nil {
            // символ в зависимости кто игрок
            if currentPlayer == .cross {
                imageView.image = UIImage(named: "Xskin1")
                currentPlayer = .nought // Меняем игрока на нолик
            } else {
                imageView.image = UIImage(named: "oSkin1")
                currentPlayer = .cross // Меняем игрока на крестик
            }

            imageView.layer.cornerRadius = 4
            imageView.layer.masksToBounds = true
            
            print("Button \(index) tapped") // принты чтобы проверить на время что нажимаються и отрабатывают кнопки
        }
    }

}

// Работа с Header View
extension GameViewController {
    
    func setupHeaderView() {
        // Создаем боковые вьюшки
        let sideItem1 = CustomSideButton(imageName: "oSkin1", labelText: "oSkin1")
        let sideItem2 = CustomSideButton(imageName: "oSkin1", labelText: "oSkin1")
        
        // Создаем центральную вьюшку с лейблом
        let centerView = UIView()
        
        
        let centerLabel = UILabel()
        centerLabel.text = "19.2"
        centerLabel.textAlignment = .center
        centerLabel.textColor = UIColor(named: "BasicBlack") ?? .black
        centerLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        centerView.addSubview(centerLabel)
        
        centerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        // Устанавливаем размеры центральной вьюшки
        centerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(103)
        }
        
        // Создаем горизонтальный стек
        let horizontalStackView = UIStackView(arrangedSubviews: [sideItem1, centerView, sideItem2])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 30
        horizontalStackView.distribution = .equalCentering
        
        view.addSubview(horizontalStackView)
        
        // Устанавливаем констрейнты для горизонтального стека
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(112)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(103)
        }
        
        // Устанавливаем размеры для боковых вьюшек
        sideItem1.snp.makeConstraints { make in
            make.width.equalTo(83)
            make.height.equalTo(83)
            
        }
        
        sideItem2.snp.makeConstraints { make in
            make.width.equalTo(83)
            make.height.equalTo(83)
        }
    }
	
	// MARK: - Navigation Bar
	private func setupNavigationBar() {
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButtonIcon"), style: .plain, target: self, action: #selector(backButtonTapped))
	}
	
	@objc private func backButtonTapped() {
		self.navigationController?.popViewController(animated: true)
	}
}








