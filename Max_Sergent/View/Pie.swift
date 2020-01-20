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
                
        backgroundColor = Colors.Pie.boxBackground
        roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: Sizing.Pie.boxRadius)
        
        let pieces: [CGFloat] = [0.2,0.1,0.1,0.1,0.1,0.1,0.1,0.2]
        let colors: [UIColor] = [.red, .green, .blue, .yellow, .brown, .purple, .lightGray, .cyan]
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
            //layer.insertSublayer(track, at: 0)
            layer.addSublayer(track)
            oldEndAngle += endAngle + (2*CGFloat.pi*gap)
        }
        
        closure()
    }
        
}
