//
//  OverviewTrack.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/12/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class OverviewTrack: UIView {
    
    //MARK: Definitions
    // Constraints
    var x:   NSLayoutConstraint!
    // Objects
    let track = CAShapeLayer()
    let fill = CAShapeLayer()
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = UI_NEW.Colors.Overview.background
        objectSettings()
        constraints()
    }
    
    func objectSettings() {
        let trackPath = UIBezierPath(arcCenter: UI_NEW.Sizing.OverviewTrack.center,
                                        radius: UI_NEW.Sizing.OverviewTrack.radius,
                                        startAngle: -CGFloat.pi/2,
                                        endAngle: 2*CGFloat.pi,
                                        clockwise: true)
        for path in [track, fill] {
            path.path = trackPath.cgPath
            path.strokeColor = UI_NEW.Colors.OverviewStats.track.cgColor
            path.fillColor = UI_NEW.Colors.OverviewStats.trackBackground.cgColor
            path.lineWidth = UI_NEW.Sizing.OverviewTrack.lineWidth
            path.lineCap = .round
            layer.addSublayer(path)
        }
        fill.strokeColor = UI_NEW.Colors.OverviewStats.fill.cgColor
        fill.strokeEnd = 0
    }

    func animateFill(to newValue: CGFloat) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = newValue
        basicAnimation.duration = 2.0
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        fill.add(basicAnimation, forKey: "What type of dog is this?")
    }
    
}
