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
        static let gradientEnd: NSNumber = 0.90
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
    
    struct Timeline {
        static let refreshTitle = "2020"
        static let cellReuseId = "TimelineCell"
        static let icons = ["bea","umich","ga"]
        static let headers = ["Bureau of Economic Analysis", "University of Michigan", "General Assembly"]
        static let content = ["Test test test test test test test test test test test test test test test test test test test test test test test test test test.","Improved profits by 1,000% while slashing costs by 99%. Truly an exceptional feat. Hire me and I may do the same for you.","Read every textbook backwards while translating to Czech. Retained 99.99% of content. Alternatively, when tasked with coloring inside the lines I deviated less than 69% of the time."]
        static let clusters = [
            (title: "2019", boxes: [(icon: icons[0], header: headers[0], content: content[0]),
                                    (icon: icons[1], header: headers[1], content: content[1])]),
            (title: "2018", boxes: [(icon: icons[0], header: headers[0], content: content[0]),
                                    (icon: icons[1], header: headers[1], content: content[1]),
                                    (icon: icons[2], header: headers[2], content: content[2]),
                                    (icon: icons[2], header: headers[2], content: content[2])]),
            (title: "2017", boxes: [(icon: icons[0], header: headers[0], content: content[0]),
                                    (icon: icons[2], header: headers[2], content: content[2]),
                                    (icon: icons[2], header: headers[2], content: content[2])]),
        ]
    }
    
    struct Menu {
        static let pages = ["Overview","Timeline","Details"]
    }
    
}
