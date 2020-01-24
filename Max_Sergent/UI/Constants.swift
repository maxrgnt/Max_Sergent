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
        
    static let splashIcon  = "maxrgnt"
    static let splashTitle = "syncing"
    static let watermarkLastSync = "last update sent:"
    static let placeholder = "The quick brown foxy"
    
    static let splashSmall: CGFloat = 0.6
    static let splashNormal: CGFloat = 0.7
    static let splashLarge: CGFloat = 0.75
    
    struct Splash {
        static let firebase = "sycncing with firebase"
        static let coredata  = "syncing with coredata"
    }
    
    struct Header {
        static let gradientStart: NSNumber = 0.40
        static let gradientEnd: NSNumber   = 0.90
    }
    
    struct Overview {
        static let cellReuseId = "OverviewCell"
        static let titles = ["Objective", "Contact"]
        static let contactIcons = ["location","email","linkedin"]
    }
    
    struct Timeline {
        static let cellReuseId = "TimelineCell"
    }
    
    struct Pie {
        static let header = "How I spend my days:"
        static let asOf = "as of:"
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
