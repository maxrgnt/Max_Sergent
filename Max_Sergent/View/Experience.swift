//
//  Experience.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/21/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Experience: UIView {
    
    //MARK: Definitions
    // Constraints
    var headerTop:   NSLayoutConstraint!
    // Objects
    let header = UILabel()
    let table = ExperienceTable()
    
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
        addSubview(header)
        header.numberOfLines = 1
        header.textAlignment = .left
        header.backgroundColor = .clear
        header.minimumScaleFactor = 0.1
        header.lineBreakMode = .byClipping
        header.adjustsFontSizeToFitWidth = true
        header.font = UI.Fonts.Experience.header
        header.text = Constants.Experience.header
        header.textColor = UI.Colors.Experience.header
        
        addSubview(table)
        table.setup()
    }
    
    func constraints() {
        headerConstraints()
        tableConstraints()
    }
    
}
