//
//  LuckyWheel.swift
//  LuckyWheel
//
//  Created by Ahmed Nasser on 12/25/18.
//  Copyright © 2018 Ahmed Nasser. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
@objc public protocol  LuckyWheelDelegate: NSObjectProtocol {
    func wheelDidChangeValue(_ newValue: Int)
    @objc optional func lastAnimation() ->CABasicAnimation
    @objc optional func landingPostion() ->LandingPostion
}
@objc public protocol LuckyWheelDataSource: NSObjectProtocol {
    func numberOfSections() ->Int
    func itemsForSections() -> [WheelItem]
}
@objc public enum LandingPostion:Int {
    case top = 270
    case left = 180
    case right = 360
    case bottom = 90
}
open class LuckyWheel :UIControl{
    @IBOutlet public  var delegate: LuckyWheelDelegate?
    @IBOutlet public  var dataSource :LuckyWheelDataSource? {
        didSet{
            drawWheel()
        }
    }
    public var infinteRotation = false
    public var animateLanding = false
    var container = UIView ()
    var labelsView = LuckyWheelText()
    var isAnimating = true
    var currentSector: Int = 0
    var selectedSection: CALayer?
    var angles =  [CGFloat]()
    var selectdSection: Int = 0
    var minAlphavalue: CGFloat = 0.6
    var maxAlphavalue: CGFloat = 1.0
    var angleSize :CGFloat = 0.0
    var rotationValue: CGFloat = 0
    var wheelRadius: CGFloat = 0
    var animationDelayInSeconds: Double = 4
    override public init(frame: CGRect) {
        super.init(frame: frame)
        wheelRadius = self.frame.size.width / 4
        self.isOpaque = false
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func setTarget(section:Int){
        assert(section <= (dataSource?.numberOfSections())!, "selected Section is out of bounds")
        self.selectdSection = section
    }
    func drawWheel() {
        assert((dataSource?.numberOfSections())! <= (dataSource?.itemsForSections().count)!, "number of sections must be equal as items")
        let numberOfSections = (dataSource?.numberOfSections())!
        container = UIView(frame: self.frame)
        angleSize = CGFloat(360.0 / Double((dataSource?.numberOfSections())!))
        var start:CGFloat  = 0.0
        var end = angleSize
        container.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        wheelRadius = frame.size.width / 2
        for i in 0..<numberOfSections {
            drawPath(start, and: end, with: dataSource?.itemsForSections()[i].itemColor, andName: "\((numberOfSections - i))", andIndex: i)
            start += angleSize
            end += angleSize
            start = CGFloat(fmodf(Float(start), 360.0))
            end = CGFloat(fmodf(Float(end), 360.0))
        }
        addSubview(container)
        labelsView = LuckyWheelText(frame: CGRect(x: 0, y: -wheelRadius / 2, width: bounds.width, height: bounds.height + wheelRadius ))
        labelsView.setAngles(angles, withRadius: Float(wheelRadius), items: (dataSource?.itemsForSections())!)
        addSubview(labelsView)
        
        if numberOfSections > 2 {
            let landingPostion = delegate?.landingPostion?() ?? .bottom
            let initialRotationAngle: CGFloat = (numberOfSections >= 4) ? CGFloat(landingPostion.rawValue) - angleSize : angleSize - 45
            rotationValue = (numberOfSections >= 4) ? torad(initialRotationAngle +  angleSize / 2 ) : torad(initialRotationAngle)
            let t: CGAffineTransform = container.transform.rotated(by: rotationValue)
            container.transform = t
            let angle = torad(initialRotationAngle +  angleSize)
            labelsView.transform = labelsView.transform.rotated(by:angle )
        }
    }
    func drawPath(_ start: CGFloat, and end: CGFloat, with color: UIColor?, andName name: String?, andIndex index: Int) {
        let path = UIBezierPath()
        let center = CGPoint(x: frame.size.width / 2, y: 0)
        path.move(to: center)
        path.addArc(withCenter: CGPoint(x: frame.size.width / 2, y: 0), radius: wheelRadius, startAngle: torad(start), endAngle: torad(end), clockwise: true)
        angles.append(torad(end))
        //segment
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = color?.cgColor
        layer.name = name
        container.layer.addSublayer(layer)
    }
    func torad(_ f: CGFloat) -> CGFloat {
        return f * .pi / 180.0
    }
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isUserInteractionEnabled = false
        rotate()
    }
    func rotate() {
        manualRotation(aCircleTime: 0)
        if !infinteRotation {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + animationDelayInSeconds , execute: {
                self.stop()
            })
        }
    }
    public func manualRotation(aCircleTime: Double) {
        let animation = infinteRotation ? 0.5 : aCircleTime
        UIView.animate(withDuration: animation/2, delay: 0.0, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: { finished in
            UIView.animate(withDuration: animation/2, delay: 0.0, options: .curveLinear, animations: {
                self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2))
            }, completion: { finished in
                if self.isAnimating {
                    self.manualRotation( aCircleTime: animation + 0.5)
                }
            })
        })
    }
    @objc public func stop() {
        self.isUserInteractionEnabled = false
        selectdSection = selectdSection + 1
        if isAnimating {
            self.isAnimating = false
            let zKeyPath = "layer.presentationLayer.transform.rotation.z"
            let currentRotation = (self.value(forKeyPath: zKeyPath) as? NSNumber)?.floatValue ?? 0.0
            let toArrow =  ( angleSize * CGFloat(selectdSection ) - angleSize)
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = currentRotation
            rotationAnimation.toValue = torad(toArrow) +  2 * .pi
            rotationAnimation.duration = 2
            rotationAnimation.fillMode = CAMediaTimingFillMode.forwards
            rotationAnimation.isRemovedOnCompletion = false
            layer.add(rotationAnimation, forKey: nil)
            rotationAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            let aniamtedSection = selectdSection - 1
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                self.getSelectedSector(aniamtedSection)
            })
        }
    }
    func getSelectedSector(_ section: Int) {
        selectedSection = getSectorByValue(section)
        selectedSection!.opacity = Float(maxAlphavalue)
        animateSelectedSector()
        delegate!.wheelDidChangeValue(section)
    }
    func getSectorByValue(_ value: Int) -> CALayer? {
        var res: CALayer?
        let views = container.layer.sublayers
        for im: CALayer in views ?? [] {
            if (im.name == "\(value)") {
                res = im
                break
            }
        }
        return res
    }
    func animateSelectedSector() {
        if  let lastAnimation = delegate?.lastAnimation?() {
            selectedSection!.add(lastAnimation, forKey: "lastAnimation")
        }else{
            if animateLanding {
                let flash = CABasicAnimation(keyPath: "opacity")
                flash.fromValue = minAlphavalue
                flash.toValue = maxAlphavalue
                flash.duration = 0.2
                flash.autoreverses = true
                flash.repeatCount = 2
                selectedSection!.add(flash, forKey: "flashAnimation")
            }
        }
        
    }
}

