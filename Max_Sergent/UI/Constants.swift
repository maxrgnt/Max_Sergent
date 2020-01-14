//
//  Constants.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Header {
        static let photo = "profile.jpg"
        static let name = "Max\nSergent"
        static let gradientStart: NSNumber = 0.0
        static let gradientEnd: NSNumber = 0.85
    }
    
    struct Overview {
        static let titles = ["Objective", "Contact"]
        static let objective = "Join an organization that understands the value of continued learning, intentional design, and selfless collaboration using skills acquired through the design and development of perrsonal iOS applications."
        static let contactIcons = ["email","location"]
        static let contactText = ["maxrgnt@umich.edu","Washington, D.C."]
    }
    
    struct Menu {
        static let pages = ["Overview","Timeline","Details"]
    }
    
}
