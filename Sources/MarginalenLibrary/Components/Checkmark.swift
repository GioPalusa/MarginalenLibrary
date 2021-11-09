//
//  Checkmark.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2019-04-02.
//  Copyright © 2019 Marginalen Bank. All rights reserved.
//

import Foundation
import UIKit

open class Checkmark: UIButton {
    public enum CheckmarkType {
        case checkbox
        case animatedView
    }

    var onValueChange: (Bool) -> Void = { _ in }

    fileprivate var type: CheckmarkType = .checkbox
    fileprivate var lineWidth: CGFloat = 2.0
    fileprivate var lineColor: CGColor? = UIColor.MarginalenColors.seafoamBlue.cgColor
    fileprivate var loadingLineColor: CGColor = UIColor.MarginalenColors.bluishGrey.cgColor
    fileprivate var useCircle: Bool = true
    fileprivate var circleLineColor: CGColor = UIColor.MarginalenColors.seafoamBlue.cgColor
    fileprivate var circleLineWidth: CGFloat = 4.0
    fileprivate var duration: CGFloat = 1
    fileprivate var damping: CGFloat = 10
    fileprivate var originalRect: CGRect = .zero
    fileprivate var background: CGColor? = UIColor.clear.cgColor
    fileprivate var animatedCheckmark = true
    fileprivate var springAnimatedCheckmark = false
    fileprivate var delayStart: Double = 0

    open override var isSelected: Bool {
        didSet {
            if isSelected {
                setCheckbox()
            } else {
                clear()
            }
        }
    }

    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        originalRect = rect

        if type == .checkbox {
            checkboxDesign()
            if isSelected {
                setCheckbox()
            } else {
                clear()
            }
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        originalRect = frame
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }

    @objc private func buttonClicked(_ sender: UIButton) {
        isSelected = !isSelected
        onValueChange(isSelected)
    }

    fileprivate func springAnimation() -> CASpringAnimation {
        // checkmark animation
        let spring = CASpringAnimation(keyPath: "lineWidth")
        spring.damping = damping
        spring.toValue = lineWidth
        spring.duration = spring.settlingDuration
        spring.repeatCount = 0
        spring.fillMode = .both
        spring.isRemovedOnCompletion = false
        return spring
    }

    fileprivate func bezierAnimation(path: CGPath?) -> CAAnimation {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path
        animation.repeatCount = 0
        animation.duration = 1.5
        return animation
    }

    fileprivate func createX(rect: CGRect) {
        if useCircle {
            createCircle(rect: rect)
        }

        let plusShapeLeft = CAShapeLayer()
        plusShapeLeft.position = CGPoint(x: 0, y: 0)
        plusShapeLeft.lineWidth = 0
        plusShapeLeft.strokeColor = lineColor
        let pathLeft = UIBezierPath()
        pathLeft.move(to: CGPoint(x: rect.midX - 10, y: rect.midY - 10))
        pathLeft.addLine(to: CGPoint(x: rect.midX + 10, y: rect.midY + 10))
        plusShapeLeft.path = pathLeft.cgPath
        plusShapeLeft.add(springAnimation(), forKey: nil)

        let plusShapeRight = CAShapeLayer()
        plusShapeRight.position = CGPoint(x: 0, y: 0)
        plusShapeRight.lineWidth = 0
        plusShapeRight.strokeColor = lineColor
        let pathRight = UIBezierPath()
        pathRight.move(to: CGPoint(x: rect.midX + 10, y: rect.midY - 10))
        pathRight.addLine(to: CGPoint(x: rect.midX - 10, y: rect.midY + 10))
        plusShapeRight.path = pathRight.cgPath
        plusShapeRight.add(springAnimation(), forKey: nil)

        layer.addSublayer(plusShapeRight)
        layer.addSublayer(plusShapeLeft)
    }

    private lazy var checkShape: CAShapeLayer = {
        let checkShape = CAShapeLayer()
        checkShape.lineWidth = lineWidth
        checkShape.fillColor = UIColor.clear.cgColor
        checkShape.strokeColor = lineColor
        checkShape.strokeStart = 0.63
        checkShape.strokeEnd = 0
        checkShape.isGeometryFlipped = true
        checkShape.setAffineTransform(CGAffineTransform(rotationAngle: 3.85))
        return checkShape
    }()

    fileprivate func createCheckmark(rect: CGRect) {
        if useCircle {
            createCircle(rect: originalRect)
        }

        // create checkmark
        checkShape.position = CGPoint(x: rect.midX + (rect.size.width * 0.25), y: rect.midY - (rect.size.height * 0.19))
        checkShape.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: rect.size.width / 2, height: rect.size.height / 2)).cgPath

        if springAnimatedCheckmark {
            checkShape.add(springAnimation(), forKey: nil)
        }

        if animatedCheckmark {
            let start = CABasicAnimation(keyPath: "strokeStart")
            start.toValue = 0.63
            start.beginTime = delayStart
            start.speed = 1.0
            let end = CABasicAnimation(keyPath: "strokeEnd")
            end.toValue = 1.0

            let group = CAAnimationGroup()
            group.animations = [end, start]
            group.duration = CFTimeInterval(duration / 1.5)
            group.autoreverses = false
            // group.repeatCount = .infinity
            group.fillMode = .both
            group.isRemovedOnCompletion = false
            checkShape.add(group, forKey: nil)
        }

        // add shapes to layer
        layer.addSublayer(checkShape)
    }

    fileprivate func createStroke(rect: CGRect) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position = CGPoint(x: rect.midX, y: rect.midY)
        rectShape.cornerRadius = bounds.width / 2
        rectShape.path = UIBezierPath(ovalIn: rect).cgPath
        rectShape.lineWidth = lineWidth
        rectShape.strokeColor = loadingLineColor
        rectShape.fillColor = UIColor.clear.cgColor
        rectShape.strokeStart = 0
        rectShape.strokeEnd = 0

        let start = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 1.0
        start.beginTime = CFTimeInterval(duration / 2.0)
        start.speed = 2.0
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1.0

        let group = CAAnimationGroup()
        group.animations = [end, start]
        group.duration = CFTimeInterval(duration)
        group.autoreverses = false
        group.repeatCount = .infinity
        group.timingFunction = nil
        group.fillMode = .both
        group.isRemovedOnCompletion = false
        rectShape.add(group, forKey: nil)

        // add shapes to layer
        layer.addSublayer(rectShape)
    }

    fileprivate func createCircle(rect: CGRect) {
        // Create Circle
        let rectShape = CAShapeLayer()
        rectShape.bounds = rect
        rectShape.position = CGPoint(x: rect.midX, y: rect.midY)
        rectShape.cornerRadius = rect.width / 2
        rectShape.path = UIBezierPath(ovalIn: rect).cgPath
        rectShape.lineWidth = circleLineWidth
        rectShape.strokeColor = circleLineColor
        rectShape.fillColor = background
        rectShape.strokeStart = 0
        rectShape.strokeEnd = 0

        let easeOut = CAMediaTimingFunction(name: .easeOut)

        let start = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1.0

        let group = CAAnimationGroup()
        group.animations = [end, start]
        group.duration = CFTimeInterval(duration)
        group.autoreverses = false
        group.repeatCount = 0
        group.timingFunction = easeOut
        group.fillMode = .both
        group.isRemovedOnCompletion = false
        rectShape.add(group, forKey: nil)

        // add shapes to layer
        layer.addSublayer(rectShape)
    }

    open func set(color: CGColor, width: CGFloat, damping: CGFloat, duration: CGFloat) {
        setColor(color: color)
        setLineWidth(width: width)
        setDamping(damp: damping)
        setDuration(speed: duration)
    }

    open func set(circle: Bool, background: CGColor, lineWidth: CGFloat, damping: CGFloat, duration: CGFloat) {
        setBackground(color: background)
        setUseCircle(bool: circle)
        setLineWidth(width: lineWidth)
        setDamping(damp: damping)
        setDuration(speed: duration)
    }

    /// Standard setter for big completion pages
    open func setBigCheckmark() {
        setBackground(color: UIColor.MarginalenColors.veryLightPink.cgColor)
        setColor(color: UIColor.MarginalenColors.greenyBlue.cgColor)
        setCircleLineWidth(width: 0)
        setLineWidth(width: 8)
        setCheckboxType(type: .animatedView)
        start()
    }

    /// Standard setter for checkboxes
    open func setCheckbox() {
        setUseCircle(bool: false)
        setColor(color: UIColor.MarginalenColors.greenyBlue.cgColor)
        setDuration(speed: 0.4)
        setLineWidth(width: 3)
        start()
    }

    /// If `setUseCircle` has been set to `false` this won't be called
    /// If you want to use background and show no circle - set `setCircleLineWidth` to `0` instead
    ///
    /// - Parameter color: defaults to clear
    open func setBackground(color: CGColor?) {
        background = color
    }

    /// Sets if a circle should be drawn around the checkmark
    ///
    /// - Parameter bool: defaults to `true`
    open func setUseCircle(bool: Bool) {
        useCircle = bool
    }

    /// Draws check mark line animation
    ///
    /// - Parameter animates: default is `true`
    open func setAnimatedCheckmark(animates: Bool) {
        animatedCheckmark = animates
    }

    /// Spring animates checkmark
    ///
    /// - Parameter animates: default is `false`
    open func setSpringAnimatedCheckmark(animates: Bool) {
        springAnimatedCheckmark = animates
    }

    /// Sets line color of both circle and content
    ///
    /// - Parameter color: defaults to Green
    open func setColor(color: CGColor?) {
        lineColor = color
    }

    /// Set a value to delay the start of an animation
    ///
    /// - Parameter delay: defaults to `0`
    open func setDelayedAnimationStart(delay: Double) {
        delayStart = delay
    }

    /// Sets line width of circle and content
    ///
    /// - Parameter width: defaults to `4`
    open func setLineWidth(width: CGFloat) {
        lineWidth = width
    }

    /// Sets the color of the loading line
    ///
    /// - Parameter color: defaults to darkGray
    open func setLoadingLineColor(color: CGColor) {
        loadingLineColor = color
    }

    /// Sets the color of the circle around the context
    ///
    /// - Parameter color: defaults to `green`
    open func setCircleLineColor(color: CGColor) {
        circleLineColor = color
    }

    /// Sets the width of the circle line
    ///
    /// - Parameter width: defaults to `4`
    open func setCircleLineWidth(width: CGFloat) {
        circleLineWidth = width
    }

    /// Sets duration of animation
    ///
    /// - Parameter speed: defaults to `0.8`
    open func setDuration(speed: CGFloat) {
        duration = speed
    }

    /// Sets animation damping if damping is used
    ///
    /// - Parameter damp: defaults to `10`
    open func setDamping(damp: CGFloat) {
        damping = damp
    }

    /// Start animation of checkmark
    open func start() {
        clear()
        createCheckmark(rect: originalRect)
    }

    /// Start drawing an X
    open func startX() {
        clear()
        createX(rect: originalRect)
    }

    /// Start drawing a loader
    open func startLoading() {
        clear()
        createStroke(rect: originalRect)
    }

    /// Clear the checkmark from its View
    open func clearCheckmark() {
        clear()
    }

    open func setCheckboxType(type: CheckmarkType) {
        self.type = type
    }

    fileprivate func clear() {
        if let layer = self.layer.sublayers {
            for i in layer where i is CAShapeLayer {
                i.removeFromSuperlayer()
            }
        }
    }
}
