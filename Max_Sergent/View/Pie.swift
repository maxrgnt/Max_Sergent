//
//  Pie.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/19/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Pie: UIView {
    
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
                
        let pieces: [CGFloat] = [0.2,0.1,0.1,0.1,0.1,0.1,0.1,0.2]
        let colors: [UIColor] = [.red, .green, .blue, .yellow, .brown, .purple, .gray, .cyan]
        let gap: CGFloat = 0.01
        let circleWithGaps = 2*CGFloat.pi*(1.0-(gap*CGFloat(pieces.count)))
        
        var oldEndAngle: CGFloat = -CGFloat.pi/2
        for (i, piece) in pieces.enumerated() {
            let track = CAShapeLayer()
            let endAngle = circleWithGaps*piece
            let path = UIBezierPath(arcCenter: Sizing.Pie.center,
                                    radius: Sizing.Pie.circleRadius,
                                    startAngle: oldEndAngle,
                                    endAngle: oldEndAngle+endAngle,
                                    clockwise: true).cgPath
            track.path = path
            track.strokeColor = colors[i].cgColor
            //track.lineCap = .round
            track.strokeEnd = 1
            track.lineWidth = Sizing.Pie.lineWidth
            track.fillColor = UIColor.clear.cgColor
            layer.addSublayer(track)
            oldEndAngle += endAngle + (2*CGFloat.pi*gap)
        }
        
        closure()
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let size = self.bounds.size

        context.translateBy (x: size.width / 2, y: size.height / 2)
        context.scaleBy (x: 1, y: -1)

        let pieces: [CGFloat] = [0.2,0.1,0.1,0.1,0.1,0.1,0.1,0.2]
        let keys: [String] = ["Coding","Reading","Running","Coffee","Outside","Travel","Gaming","Bikeshare"]
        let gap: CGFloat = 0.01
        let circleWithGaps = 2*CGFloat.pi*(1.0-(gap*CGFloat(pieces.count)))
        var oldEndAngle: CGFloat = CGFloat.pi/2

        for (i, piece) in pieces.enumerated() {
            let width = circleWithGaps*piece
            let angle = oldEndAngle - width/2
            let clockwise = (angle < 0 && angle >= -CGFloat.pi) ? false : true
            centreArcPerpendicular(text: keys[i],
                                   context: context,
                                   radius: Sizing.Pie.textRadius,
                                   angle: angle,
                                   colour: Colors.Pie.legend,
                                   font: Fonts.Pie.legend!,
                                   clockwise: clockwise)
            oldEndAngle -= width + (2*CGFloat.pi*gap)
        }

        
//        centreArcPerpendicular(text: "Hello round world",
//                               context: context,
//                               radius: Sizing.Pie.textRadius,
//                               angle: CGFloat.pi,
//                               colour: Colors.Pie.legend,
//                               font: Fonts.Pie.legend!,
//                               clockwise: true)
//
//        centreArcPerpendicular(text: "Anticlockwise",
//                               context: context,
//                               radius: 100,
//                               angle: CGFloat(-Double.pi/2),
//                               colour: UIColor.red,
//                               font: UIFont.systemFont(ofSize: 16),
//                               clockwise: false)
        
//        centre(text: "Hello flat world",
//               context: context,
//               radius: 0,
//               angle: 0 ,
//               colour: UIColor.yellow,
//               font: UIFont.systemFont(ofSize: 16),
//               slantAngle: CGFloat(Double.pi/4))
    }
    
}
