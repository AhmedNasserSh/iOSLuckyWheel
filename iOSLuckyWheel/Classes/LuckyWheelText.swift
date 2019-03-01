//
//  LuckyWheelWheelText.swift
//  LuckyWheel
//
//  Created by Ahmed Nasser on 12/26/18.
//  Copyright © 2018 Ahmed Nasser. All rights reserved.
//

import UIKit

class LuckyWheelText: UIView {
    var angles: [CGFloat] = []
    var wheelRadius: Float = 0.0
    var items = [WheelItem]()
    func setAngles(_ angles: [CGFloat], withRadius wheelRadius: Float,items:[WheelItem]) {
        self.angles = angles
        self.wheelRadius = wheelRadius
        self.items = items
        setNeedsDisplay()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = true
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        let size: CGSize = bounds.size
        context?.translateBy(x: size.width / 2, y: size.height / 2 )
        context?.scaleBy(x: 1, y: -1)
        let g = CircularTextLayer()
        var i = 0
        g.lineLength = angles[0]
        for angle: CGFloat in angles {
            let a = Float(angle )            
            g.centreArcPerpendicular(text: items[i].title ?? "", context: context!, radius: CGFloat(wheelRadius - 20), angle: CGFloat(a),colour:  items[i].titleColor ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), font: UIFont.systemFont(ofSize: 14), clockwise: false)

            i += 1
        }

    }
    
}
