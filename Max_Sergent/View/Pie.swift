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
        
        backgroundColor = .gray
        
        let pieces: [CGFloat] = [0.2,0.7,0.1]
        let colors: [UIColor] = [.red, .green, .blue]
        
        var oldEndAngle: CGFloat = -CGFloat.pi/2
        for (i, piece) in pieces.enumerated() {
            let track = CAShapeLayer()
            let endAngle = 2*CGFloat.pi*piece
            let path = UIBezierPath(arcCenter: Sizing.Pie.center,
                                    radius: Sizing.Pie.radius,
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
            oldEndAngle += endAngle
        }
        
        closure()
    }
    
}
