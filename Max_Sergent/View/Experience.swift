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
    // Objects
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
        addSubview(table)
        table.setup()
    }
    
    func constraints() {
        tableConstraints()
    }
    
}
