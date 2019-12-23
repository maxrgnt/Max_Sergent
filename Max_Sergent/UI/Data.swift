//
//  Data.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/23/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct Data {
    
    static let experience: [String : [(position: String, work: String)]] =
        ["BEA":
            [(position: "Analyst", work: "Learn SQL"),
             (position: "Economist", work: "Fix hub")],
        "Toggle":
            [(position: "Co-Founder", work: "Learn iOS")]
        ]
    static let positions = [["AAaaaaa","BBbbbbbb"],["CCccccc","DDdddddd"]]
    
}
