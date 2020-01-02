//
//  WorkSection.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/23/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import UIKit

class SchoolSection: UIView {

    // Objects
    let school = UILabel()
    
    //MARK: Initialization
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    //MARK: Setup
    func setup() {
        backgroundColor = .clear
        objectSettings()
        constraints()
    }
    
    //MARK: Object Settings
    func objectSettings() {
        addSubview(school)
        school.alpha          = 1.0
        school.textAlignment  = .left
        school.textColor      = UI.Colors.Experience.company
        school.font           = UI.Fonts.Experience.company
        school.text           = Constants.Experience.company
        //company.minimumScaleFactor = 0.1
        school.numberOfLines = 0
        school.lineBreakMode = .byClipping
        //company.adjustsFontSizeToFitWidth = true
        //company.backgroundColor = .blue
    }
    
    //MARK: Constraints
    func constraints() {
        schoolConstraints()
    }
    
}
