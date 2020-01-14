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
    var title1Height: NSLayoutConstraint!
    var objectiveHeight: NSLayoutConstraint!
    var box2Height: NSLayoutConstraint!
    var title2Height: NSLayoutConstraint!
    // Objects
    var box1 = UIView()
    var title1 = UILabel()
    var objective = UILabel()
    var box2 = UIView()
    var title2 = UILabel()
    lazy var boxes = [box1, box2]
    lazy var titles = [title1, title2]
    
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
        
        for box in boxes {
            addSubview(box)
            box.backgroundColor = Colors.Overview.box
            box.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: Sizing.Overview.boxRadius)
        }

        for (i, title) in titles.enumerated() {
            addSubview(title)
            title.numberOfLines   = 1
            title.textAlignment   = .left
            title.backgroundColor = .clear
            title.lineBreakMode   = .byWordWrapping
            title.font            = Fonts.Overview.boxTitle
            title.text            = Constants.Overview.titles[i]
            title.textColor       = Colors.Overview.boxTitle
        }
        
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
        let titleFrame = objective.frameForLabel(text: title1.text!,
                                                 font: title1.font!,
                                                 numberOfLines: title1.numberOfLines,
                                                 width: Sizing.Overview.boxPaddedWidth)
        title1Height.constant = titleFrame.height
        layoutIfNeeded()
    }
    
}
