//
//  WorkSection.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/23/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import UIKit

class WorkSection: UIView {

    // Objects
    let company = UILabel()
    
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
        addSubview(company)
        company.alpha          = 1.0
        company.textAlignment  = .left
        company.textColor      = UI.Colors.Experience.company
        company.font           = UI.Fonts.Experience.company
        company.text           = Constants.Experience.company
        //company.minimumScaleFactor = 0.1
        company.numberOfLines = 0
        company.lineBreakMode = .byClipping
        //company.adjustsFontSizeToFitWidth = true
        //company.backgroundColor = .blue
    }
    
    //MARK: Constraints
    func constraints() {
        companyConstraints()
    }
    
}
