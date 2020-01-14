//
//  Overview2.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/14/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Overview2: UIView {
    
    //MARK: Definitions
    // Delegates
    // Constraints
    // Objects
    var table = OverviewTable()
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Settings
    func setup(closure: () -> Void) {
        
        addSubview(table)
        table.setup()
        
        closure()
    }
    
}
