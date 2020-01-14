//
//  OverviewSection.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/14/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import UIKit

class OverviewSection: UIView {

    //MARK: Definitions
    // Delegates
    // Constraints
    var titleTop   :   NSLayoutConstraint!
    var titleHeight:   NSLayoutConstraint!
    // Objects
    var title   = UILabel()
    
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
        title.font            = Fonts.Overview.title
        title.textColor       = Colors.Overview.boxTitle
        
        closure()
    }
    
    func calcTitleHeight() -> CGFloat {
        let titleFrame = title.frameForLabel(text: title.text!,
                                             font: title.font!,
                                             numberOfLines: title.numberOfLines,
                                             width: Sizing.Overview.boxPaddedWidth)
        return titleFrame.height
    }
    
    func resize(forSection section: Int) {
        titleTop.constant = (section == 0) ? Sizing.padding/2 : 0.0
        titleHeight.constant = (section == 0) ? calcTitleHeight() + Sizing.padding/2 : calcTitleHeight()
        layoutIfNeeded()
    }
    
}
