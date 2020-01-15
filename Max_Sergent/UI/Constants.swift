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
    
    static let watermark = "max\nrgnt"
    
    struct Header {
        static let photo = "profile.jpg"
        static let name = "Max\nSergent"
        static let gradientStart: NSNumber = 0.0
        static let gradientEnd: NSNumber = 0.85
    }
    
    struct Overview {
        static let cellReuseId = "OverviewCell"
        static let titles = ["Objective", "Contact"]
        static let objective = "Join an organization that understands the value of continued learning, intentional design, and selfless collaboration using skills acquired through the design and development of perrsonal iOS applications."
        static let contactIcons = ["location","email","linkedin"]
        static let contactText = ["Washington, D.C.","maxrgnt@umich.edu","www.linkedin.com/in/max-sergent"]
        
        static let clusters = [
            (title: "Objective", boxes: [(icon: "", content: objective)]),
            (title: "Contact", boxes: [(icon: contactIcons[0], content: contactText[0]),
                                       (icon: contactIcons[1], content: contactText[1]),
                                       (icon: contactIcons[2], content: contactText[2])]),
        ]
    }
    
    struct Menu {
        static let pages = ["Overview","Timeline","Details"]
    }
    
}
