//
//  PieText.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/20/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class PieText: UIView {
    
    //MARK: Definitions
    // Delegates
    // Constraints
    // Objects
    
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(closure: () -> Void) {
        backgroundColor = .clear
        
        closure()
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let size = self.bounds.size

        context.translateBy (x: size.width / 2, y: size.height / 2)
        context.scaleBy (x: 1, y: -1)

        let pieces: [CGFloat] = [0.2,0.1,0.1,0.1,0.1,0.1,0.1,0.2]
        let keys: [String] = ["Coding","Reading","Running","Coffee","Outside","Travel","Gaming","Bikeshare"]
        let vals: [String] = ["20%","10%","10%","10%","10%","10%","10%","20%"]
        let gap: CGFloat = 0.01
        let circleWithGaps = 2*CGFloat.pi*(1.0-(gap*CGFloat(pieces.count)))
        var oldEndAngle: CGFloat = CGFloat.pi/2

        for (i, piece) in pieces.enumerated() {
            let width = circleWithGaps*piece
            let angle = oldEndAngle - width/2
            let clockwise = (angle < CGFloat.pi/4 && angle >= -CGFloat.pi) ? false : true
            centreArcPerpendicular(text: keys[i],
                                   context: context,
                                   radius: Sizing.Pie.textRadius,
                                   angle: angle,
                                   colour: Colors.Pie.legend,
                                   font: Fonts.Pie.legend!,
                                   clockwise: clockwise)
            oldEndAngle -= width + (2*CGFloat.pi*gap)
        }
        
        for (i, piece) in pieces.enumerated() {
            let width = circleWithGaps*piece
            let angle = oldEndAngle - width/2
            print(angle, -CGFloat.pi*(1.75), -3*CGFloat.pi, vals[i])
            let clockwise = (angle < -CGFloat.pi*(1.75) && angle >= -3*CGFloat.pi) ? false : true
            centreArcPerpendicular(text: vals[i],
                                   context: context,
                                   radius: Sizing.Pie.circleRadius,
                                   angle: angle,
                                   colour: Colors.Pie.percent,
                                   font: Fonts.Pie.percent!,
                                   clockwise: clockwise)
            oldEndAngle -= width + (2*CGFloat.pi*gap)
        }
    }
    
}
