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
    var titleCenterY :   NSLayoutConstraint!
    var titleHeight  :   NSLayoutConstraint!
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
        
        closure()
    }
    
    func calcTitleHeight() -> CGFloat {
        let labelText =  (title.text ?? Constants.placeholder)!
        let titleFrame = title.frameForLabel(text: labelText,
                                             font: title.font!,
                                             numberOfLines: title.numberOfLines,
                                             width: Sizing.Overview.boxPaddedWidth)
        return titleFrame.height
    }
    
    func resize() {
        titleHeight.constant = calcTitleHeight()
        layoutIfNeeded()
    }
    
}
