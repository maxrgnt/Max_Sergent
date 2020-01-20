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
        static let icons = ["bea","umich","ga","alculate"]
        static let headers = ["Bureau of Economic Analysis", "University of Michigan", "General Assembly","Alculate"]
        static let distinctions = [".exp",".edu",".edu",".proj"]
        static let content = ["Improved profits by 1,000% while slashing costs by 99%. Truly an exceptional feat. Hire me and I may do the same for you.","Read every textbook backwards while translating to Czech. Retained 99.99% of content. Alternatively, when tasked with coloring inside the lines I deviated less than 69% of the time.","Took control of the classroom on Day 1. The bootcamp instructor was eating out of my hand by the end of class as he ended up doing my project for me while I graded all other projects. I am Python. Matlab is trash. My roommate is a deviant.","Who loves drinking but hates spending money? Me too. Alculate let's you have your cake and eat it too. Drink it too? Cheers."]
        static let clusters = [
            (title: "2019", boxes: [(icon: icons[3], distinction: distinctions[3], header: headers[3], content: content[3]),
                                    (icon: icons[2], distinction: distinctions[2], header: headers[2], content: content[2])]),
            (title: "2018", boxes: [(icon: icons[0], distinction: distinctions[0], header: headers[0], content: content[0])]),
            (title: "2016", boxes: [(icon: icons[1], distinction: distinctions[1], header: headers[1], content: content[1])]),
        ]
    }
    
    struct Pie {
        static let header = "Daily breakdown:"
        static let asOf = "as of:"
        static let originDate = "Jan\n01\n2019"
    }
    
    struct Concepts {
        static let header = "iOS Concepts:"
    }
    
    struct Menu {
        static let pages = ["Overview","Timeline","Details"]
    }
    
}
