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
        
        addSubview(title)
        title.numberOfLines   = 1
        title.textAlignment   = .left
        title.backgroundColor = .clear
        title.lineBreakMode   = .byWordWrapping
        title.font            = Fonts.Timeline.title
        
        addSubview(line)
        addSubview(node)
        node.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: Sizing.Timeline.nodeRadius)
        
        closure()
    }
    
    func calcTitleHeight() -> CGFloat {
        let labelText =  (title.text ?? Constants.placeholder)!
        let titleFrame = title.frameForLabel(text: labelText,
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
