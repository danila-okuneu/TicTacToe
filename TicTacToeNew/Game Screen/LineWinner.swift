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
    private var lineColor: UIColor = .blue
    private var lineWidth: CGFloat = 12
    
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
        guard !winningPattern.isEmpty,
              let start = positionForCell(index: winningPattern.min()!, in: rect.size),
              let end = positionForCell(index: winningPattern.max()!, in: rect.size) else {
            return
        }
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        // Настройка цвета и стиля
        lineColor.setStroke()
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.stroke()
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
