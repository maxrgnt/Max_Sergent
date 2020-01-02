//
//  School.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/2/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class School: UIView {
    
    //MARK: Definitions
    // Objects
    let table = SchoolTable()
    
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
