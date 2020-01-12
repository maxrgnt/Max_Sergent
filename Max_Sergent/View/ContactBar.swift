//
//  ContactBar.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/12/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class ContactBar: UIView {
    
    //MARK: Definitions
    // Constraints
    var x:   NSLayoutConstraint!
    // Objects
    let emailIcon = UIImageView()
    let emailText = UILabel()
    let locationIcon = UIImageView()
    let locationText = UILabel()
    
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
        let icons = [Constants_NEW.Overview.emailIcon, Constants_NEW.Overview.locationIcon]
        for (i, icon) in [emailIcon, locationIcon].enumerated() {
            addSubview(icon)
            icon.image = UIImage(named: icons[i])
            icon.clipsToBounds = true
            icon.layer.masksToBounds = true
            icon.contentMode = .scaleAspectFill
        }
        
        let text = [Constants_NEW.Overview.emailText, Constants_NEW.Overview.locationText]
        for (i, label) in [emailText, locationText].enumerated() {
            addSubview(label)
            label.numberOfLines = 1
            label.textAlignment = .left
            label.backgroundColor = .clear
            label.font = UI_NEW.Fonts.Overview.contactText
            label.text = text[i]
            label.textColor = UI_NEW.Colors.Overview.locationText
        }
        
    }
    
}
