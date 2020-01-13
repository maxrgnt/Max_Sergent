//
//  Overview_NEW.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/10/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Overview_NEW: UIView {
    
    //MARK: Definitions
    // Constraints
    var objectiveHeight:   NSLayoutConstraint!
    // Objects
    let objective = UILabel()
    let contactBar = ContactBar()
//    let stats = OverviewStats()
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = UI.Colors.Overview.background
        objectSettings()
        constraints()
        
        print(frameForLabel(text: objective.text!, font: objective.font!).height)
        objectiveHeight.constant = frameForLabel(text: objective.text!, font: objective.font!).height
        layoutIfNeeded()
    }
    
    func objectSettings() {
        addSubview(objective)
        objective.numberOfLines = 0
        objective.textAlignment = .left
        objective.backgroundColor = .clear
//        objective.minimumScaleFactor = 0.1
        objective.lineBreakMode = .byWordWrapping
//        objective.adjustsFontSizeToFitWidth = true
        objective.font = UI_NEW.Fonts.Overview.objective
        objective.text = Constants_NEW.Overview.objective
        objective.textColor = UI_NEW.Colors.Overview.objective
        addSubview(contactBar)
        contactBar.setup()
//        addSubview(stats)
//        stats.setup()
    }
 
    func scaleInversely(with scalar: CGFloat) {
        (scalar < 0.0) ? hide(with: scalar) : nil
    }
    
    func hide(with scalar: CGFloat) {
        alpha = scalar+1.0
    }
    
    func frameForLabel(text:String, font:UIFont) -> (width: CGFloat, height: CGFloat) {
        // Setting max variable for readability in next line
        let max = CGFloat.greatestFiniteMagnitude
        // Create temp label to calculate size to fit
        // Can't just size to fit each label because we want them spaced horizontally a certain way.
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UI_NEW.Sizing.widthObjectPadding, height: max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        // Return the width and height of label to center vertically in menu and space evenly horizontally
        return (width: label.frame.width, height: label.frame.height)
    }
}
