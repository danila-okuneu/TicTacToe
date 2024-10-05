//
//  LineWininer.swift
//  TicTacToeNew
//
//  Created by Evgeniy on 05.10.2024.
//

import UIKit

class LineWinnerView: UIView {
    var winningPattern: Set<Int> = [] {
        didSet {
            setNeedsDisplay() // Перерисовываем вью при изменении winningPattern
        }
    }
    
    private let step: CGFloat = 10
    private var lineColor: UIColor = UIColor.app(.darkPurple)
    private var lineWidth: CGFloat = 12
    private var shapeLayer: CAShapeLayer? // Добавим слой для анимации
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear // Устанавливаем прозрачный фон
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear // Устанавливаем прозрачный фон
    }
    
    override func draw(_ rect: CGRect) {
        // Проверяем, есть ли выигрышный паттерн
        shapeLayer?.removeFromSuperlayer()
        guard !winningPattern.isEmpty,
              let start = positionForCell(index: winningPattern.min()!, in: rect.size),
              let end = positionForCell(index: winningPattern.max()!, in: rect.size) else {
            return
        }
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        let newShapeLayer = CAShapeLayer()
            newShapeLayer.path = path.cgPath
            newShapeLayer.strokeColor = lineColor.cgColor
            newShapeLayer.lineWidth = lineWidth
            newShapeLayer.lineCap = .round
            newShapeLayer.strokeEnd = 0 // Начальное значение для анимации
        
        layer.addSublayer(newShapeLayer)
            shapeLayer = newShapeLayer // Сохраняем ссылку на новый слой
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.toValue = 1
                animation.duration = 0.5 // Длительность анимации
                animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                newShapeLayer.add(animation, forKey: "line")
                newShapeLayer.strokeEnd = 1 // Обновляем значение strokeEnd после анимации
    }
    
    // Метод для получения позиции центра ячейки по индексу
    private func positionForCell(index: Int, in size: CGSize) -> CGPoint? {
        let row = index / 3
        let column = index % 3
        
        let cellWidth = size.width / 3
        let cellHeight = size.height / 3
        
        // Рассчитываем позицию с учетом шага
        let xPosition = (CGFloat(column) * cellWidth) + (cellWidth / 2) + (column == 0 ? step : (column == 2 ? -step : 0))
        let yPosition = (CGFloat(row) * cellHeight) + (cellHeight / 2) + (row == 0 ? step : (row == 2 ? -step : 0))

        return CGPoint(x: xPosition, y: yPosition)
    }
    
    // Дополнительные методы для настройки цвета и толщины линии
    func setLineColor(_ color: UIColor) {
        self.lineColor = color
        setNeedsDisplay()
    }
    
    func setLineWidth(_ width: CGFloat) {
        self.lineWidth = width
        setNeedsDisplay()
    }
}
