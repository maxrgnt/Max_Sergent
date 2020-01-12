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
    var x:   NSLayoutConstraint!
    // Objects
    let objective = UILabel()
    let contactBar = ContactBar()
    let tracker = Tracker()
    
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
    }
    
    func objectSettings() {
        addSubview(objective)
        objective.numberOfLines = 7
        objective.textAlignment = .left
        objective.backgroundColor = .clear
        objective.minimumScaleFactor = 0.1
        objective.lineBreakMode = .byClipping
        objective.adjustsFontSizeToFitWidth = true
        objective.font = UI_NEW.Fonts.Overview.objective
        objective.text = Constants_NEW.Overview.objective
        objective.textColor = UI_NEW.Colors.Overview.objective
        addSubview(contactBar)
        contactBar.setup()
        addSubview(tracker)
        tracker.setup()
    }
 
    func scaleInversely(with scalar: CGFloat) {
        (scalar < 0.0) ? hide(with: scalar) : nil
    }
    
    func hide(with scalar: CGFloat) {
        alpha = scalar+1.0
    }
}
