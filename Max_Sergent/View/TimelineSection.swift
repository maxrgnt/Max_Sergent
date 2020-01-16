//
//  TimelineSection.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/15/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import UIKit

class TimelineSection: UIView {

    //MARK: Definitions
    // Delegates
    // Constraints
    var titleCenterY :   NSLayoutConstraint!
    var titleHeight  :   NSLayoutConstraint!
    // Objects
    var line  = UILabel()
    var node  = UILabel()
    var title = UILabel()
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    //MARK: Settings
    func setup(closure: () -> Void) {
                
        backgroundColor = Colors.Timeline.background
        
        addSubview(title)
        title.numberOfLines   = 1
        title.textAlignment   = .left
        title.backgroundColor = .clear
        title.lineBreakMode   = .byWordWrapping
        title.font            = Fonts.Timeline.title
        title.textColor       = Colors.Timeline.title
        
        addSubview(line)
        line.backgroundColor = Colors.Timeline.line
        
        addSubview(node)
        node.backgroundColor = Colors.Timeline.node
        node.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: Sizing.Timeline.nodeRadius)
        
        closure()
    }
    
    func calcTitleHeight() -> CGFloat {
        let titleFrame = title.frameForLabel(text: title.text!,
                                             font: title.font!,
                                             numberOfLines: title.numberOfLines,
                                             width: Sizing.paddedWidth)
        return titleFrame.height
    }
    
    func resize() {
        titleHeight.constant = calcTitleHeight()
        layoutIfNeeded()
    }
    
}
