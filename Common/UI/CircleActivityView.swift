//
//  CircleActivityView.swift
//  Meetings
//
//  Created by Sergio Lechini on 23.08.2021.
//  Copyright © 2021 PicSplash. All rights reserved.
//

import UIKit

/// Протокол для работы с CircleActivityView
protocol CircleActivityViewType: UIView {
    func startAnimating()
    func stopAnimating()
}

final class CircleActivityView: UIView {

    // MARK: Properties
    let colors: [UIColor]
    let lineWidth: CGFloat

    private lazy var shapeLayer: CircleProgressShapeLayer = {
        return CircleProgressShapeLayer(strokeColor: colors.first ?? .black, lineWidth: lineWidth)
    }()

    // MARK: - Initialization
    init(frame: CGRect, colors: [UIColor], lineWidth: CGFloat) {
        self.colors = colors
        self.lineWidth = lineWidth

        super.init(frame: frame)

        self.backgroundColor = .clear
    }

    convenience init(colors: [UIColor], lineWidth: CGFloat) {
        self.init(frame: .zero, colors: colors, lineWidth: lineWidth)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.frame.width / 2

        let path = UIBezierPath(ovalIn:
            CGRect(
                x: 0,
                y: 0,
                width: self.bounds.width,
                height: self.bounds.width
            )
        )

        shapeLayer.path = path.cgPath
    }
}

// MARK: Animations
private extension CircleActivityView {
    func animateStroke() {

        let startAnimation = CircleStrokeAnimation(
            type: .start,
            beginTime: 0.5,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 1.5
        )

        let endAnimation = CircleStrokeAnimation(
            type: .end,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 1.5
        )

        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 2
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [startAnimation, endAnimation]

        shapeLayer.add(strokeAnimationGroup, forKey: nil)

        let colorAnimation = CircleStrokeColorAnimation(
            colors: colors.map { $0.cgColor },
            duration: strokeAnimationGroup.duration * Double(colors.count)
        )

        shapeLayer.add(colorAnimation, forKey: nil)

        self.layer.addSublayer(shapeLayer)
    }

    func animateRotation() {
        let rotationAnimation = CircleRotationAnimation(
            direction: .z,
            fromValue: 0,
            toValue: CGFloat.pi * 2,
            duration: 2,
            repeatCount: .greatestFiniteMagnitude
        )

        self.layer.add(rotationAnimation, forKey: nil)
    }
}

// MARK: CircleActivityViewType
extension CircleActivityView: CircleActivityViewType {
    func startAnimating() {
        animateStroke()
        animateRotation()
    }

    func stopAnimating() {
        shapeLayer.removeFromSuperlayer()
        layer.removeAllAnimations()
    }
}

// MARK: CircleProgressShapeLayer
/// Класс CAShapeLayer линии анимации
final class CircleProgressShapeLayer: CAShapeLayer {

    public init(strokeColor: UIColor, lineWidth: CGFloat) {
        super.init()

        self.strokeColor = strokeColor.cgColor
        self.lineWidth = lineWidth
        self.fillColor = UIColor.clear.cgColor
        self.lineCap = .square
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: CircleStrokeAnimation
/// Класс CABasicAnimation для stroke анимации индикатора
final class CircleStrokeAnimation: CABasicAnimation {

    override init() {
        super.init()
    }

    init(type: StrokeType,
         beginTime: Double = 0.0,
         fromValue: CGFloat,
         toValue: CGFloat,
         duration: Double) {

        super.init()

        self.keyPath = type == .start ? "strokeStart" : "strokeEnd"

        self.beginTime = beginTime
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration
        self.timingFunction = .init(name: .easeInEaseOut)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    enum StrokeType {
        case start
        case end
    }
}

// MARK: CircleRotationAnimation
/// Класс CABasicAnimation для анимации вращения индикатора
final class CircleRotationAnimation: CABasicAnimation {

    /// Ось вращения
    enum Direction: String {
        case x, y, z
    }

    override init() {
        super.init()
    }

    public init(
        direction: Direction,
        fromValue: CGFloat,
        toValue: CGFloat,
        duration: Double,
        repeatCount: Float
    ) {

        super.init()

        self.keyPath = "transform.rotation.\(direction.rawValue)"

        self.fromValue = fromValue
        self.toValue = toValue

        self.duration = duration

        self.repeatCount = repeatCount
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: CircleStrokeColorAnimation
/// Класс CABasicAnimation для анимации цвета индикатора
final class CircleStrokeColorAnimation: CAKeyframeAnimation {

    override init() {
        super.init()
    }

    init(colors: [CGColor], duration: Double) {

        super.init()

        self.keyPath = "strokeColor"
        self.values = colors
        self.duration = duration
        self.repeatCount = .greatestFiniteMagnitude
        self.timingFunction = .init(name: .easeInEaseOut)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
