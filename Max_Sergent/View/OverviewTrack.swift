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
    var dayStatTop:   NSLayoutConstraint!
    var dayUnitTop:   NSLayoutConstraint!
    var dayStatHeight:   NSLayoutConstraint!
    var dayUnitHeight:   NSLayoutConstraint!
    // Objects
    let track = CAShapeLayer()
    let fill = CAShapeLayer()
    let dayStat = UILabel()
    let dayUnit = UILabel()
    
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
        
        let statHeight = frameForLabel(text: dayStat.text!, font: dayStat.font!).height
        let unitHeight = frameForLabel(text: dayStat.text!, font: dayStat.font!).height
        dayStatHeight.constant = statHeight
        dayUnitHeight.constant = unitHeight
        let innerCircle = UI_NEW.Sizing.OverviewTrack.radius-UI_NEW.Sizing.OverviewTrack.lineWidth
        dayStatTop.constant = (innerCircle*2-(statHeight+unitHeight)/2)/2
        dayUnitTop.constant = -unitHeight/3
        layoutIfNeeded()
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
            path.lineCap = .round
            path.strokeEnd = 1
            layer.addSublayer(path)
        }
        fill.strokeColor = UI_NEW.Colors.OverviewStats.fill.cgColor
        fill.strokeEnd = 0
        
        track.lineWidth = UI_NEW.Sizing.OverviewTrack.lineWidth
        fill.lineWidth = UI_NEW.Sizing.OverviewTrack.lineWidth
        
        track.fillColor = UIColor.clear.cgColor
        fill.fillColor = UIColor.clear.cgColor
        
        let fonts = [UI_NEW.Fonts.OverviewStats.dayStat, UI_NEW.Fonts.OverviewStats.dayUnit]
        let text = ["100", "days"]
        for (i, label) in [dayStat, dayUnit].enumerated() {
            addSubview(label)
            label.textAlignment = .center
            label.textColor = UI_NEW.Colors.OverviewStats.days
            label.font = fonts[i]
            label.text = text[i]
        }
        dayUnit.alpha = 0.7
        
    }

    func animateFill(to newValue: CGFloat) {
        fill.strokeEnd = 0
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let ratio = newValue / (CGFloat.pi*2)
        let amountOfPie = newValue / CGFloat.pi
        print(newValue, ratio, amountOfPie)
        basicAnimation.toValue = ratio
        basicAnimation.duration = Double(amountOfPie)
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        fill.add(basicAnimation, forKey: "What type of dog is this?")
    }
    
    func frameForLabel(text:String, font:UIFont) -> (width: CGFloat, height: CGFloat) {
        // Setting max variable for readability in next line
        let max = CGFloat.greatestFiniteMagnitude
        // Create temp label to calculate size to fit
        // Can't just size to fit each label because we want them spaced horizontally a certain way.
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: max, height: max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        // Return the width and height of label to center vertically in menu and space evenly horizontally
        return (width: label.frame.width, height: label.frame.height)
    }
    
}
