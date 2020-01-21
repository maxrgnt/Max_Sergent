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

        var days:     [CGFloat] = []
        var vals:     [String]  = []
        var colors:   [UIColor] = []
        var keys:     [String]  = []
        var totalDays: CGFloat  = 0.0
        
        Data.pie.forEach { object in
            let day = CGFloat(object[Constants.Data_Key.days] as! Int64)
            totalDays += day
        }
        
        Data.pie.forEach { object in
            let day = CGFloat(object[Constants.Data_Key.days] as! Int64)
            days.append(day/totalDays)
            vals.append(String(describing: Int(day)))
            let color = UIColor(hexFromString: object[Constants.Data_Key.color] as! String, alpha: 1.0)
            colors.append(color)
            let key = object[Constants.Data_Key.piece] as! String
            keys.append(key)
        }
        
        let gap: CGFloat = 0.01
        let circleWithGaps = 2*CGFloat.pi*(1.0-(gap*CGFloat(days.count)))
        var oldEndAngle: CGFloat = CGFloat.pi/2

        for (i, piece) in days.enumerated() {
            let width = circleWithGaps*piece
            let angle = oldEndAngle - width/2
            let clockwise = (angle < 0.0 /*CGFloat.pi/6*/ && angle >= -CGFloat.pi) ? false : true
            centreArcPerpendicular(text: keys[i],
                                   context: context,
                                   radius: Sizing.Pie.textRadius,
                                   angle: angle,
                                   colour: Colors.Pie.legend,
                                   font: Fonts.Pie.legend!,
                                   clockwise: clockwise)
            oldEndAngle -= width + (2*CGFloat.pi*gap)
        }
        
        oldEndAngle = CGFloat.pi/2
        for (i, piece) in days.enumerated() {
            let width = circleWithGaps*piece
            let angle = oldEndAngle - width/2
            let clockwise = (angle < 0.0 /*CGFloat.pi/6*/ && angle >= -CGFloat.pi) ? false : true
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
