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
        static let contactIcons = ["location","email","linkedin"]
    }
    
    struct Timeline {
        static let refreshTitle = "2020"
        static let cellReuseId = "TimelineCell"
        static let icons = ["bea","umich","ga","alculate"]
        static let headers = ["Bureau of Economic Analysis", "University of Michigan", "General Assembly","Alculate"]
        static let distinctions = [".exp",".edu",".edu",".proj"]
    }
    
    struct Pie {
        static let header = "How I spend my days:"
        static let asOf = "as of:"
        static let originDate = "Jan\n01\n2019"
    }
    
    struct Concepts {
        static let cellReuseId = "ConceptsCell"
        static let objectsPerRow: CGFloat = 3.0
        static let header = "iOS Concepts in this App:"
    }
    
    struct Menu {
        static let pages = ["Overview","Timeline","Details"]
    }
    
}
