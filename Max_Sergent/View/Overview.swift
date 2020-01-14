//
//  Overview.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/14/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Overview: UIView {
    
    //MARK: Definitions
    // Delegates
    // Constraints
    var box1Height: NSLayoutConstraint!
    var box1TitleHeight: NSLayoutConstraint!
    var objectiveHeight: NSLayoutConstraint!
    // Objects
    var box1 = UIView()
    var box1Title = UILabel()
    var objective = UILabel()
    
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Settings
    func setup(closure: () -> Void) {
        addSubview(box1)
        box1.backgroundColor = Colors.Overview.box
        box1.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: Sizing.Overview.boxRadius)

        addSubview(box1Title)
        box1Title.numberOfLines   = 1
        box1Title.textAlignment   = .left
        box1Title.backgroundColor = .clear
        box1Title.lineBreakMode   = .byWordWrapping
        box1Title.font            = Fonts.Overview.boxTitle
        box1Title.text            = Constants.Overview.box1Title
        box1Title.textColor       = Colors.Overview.boxTitle
        
        box1.addSubview(objective)
        objective.numberOfLines   = 0
        objective.textAlignment   = .left
        objective.backgroundColor = .clear
        objective.lineBreakMode   = .byWordWrapping
        objective.font            = Fonts.Overview.objective
        objective.text            = Constants.Overview.objective
        objective.textColor       = Colors.Overview.objectiveText
        
        closure()
    }
    
    func resetObjectiveHeight() {
        let frame = objective.frameForLabel(text: objective.text!,
                                            font: objective.font!,
                                            numberOfLines: objective.numberOfLines,
                                            width: Sizing.Overview.boxPaddedWidth)
        Sizing.Overview.objectiveHeight = frame.height
        objectiveHeight.constant        = frame.height
        box1Height.constant       = Sizing.Overview.box1Height
        let titleFrame = objective.frameForLabel(text: box1Title.text!,
                                                 font: box1Title.font!,
                                                 numberOfLines: box1Title.numberOfLines,
                                                 width: Sizing.Overview.boxPaddedWidth)
        box1TitleHeight.constant = titleFrame.height
        layoutIfNeeded()
    }
    
}
