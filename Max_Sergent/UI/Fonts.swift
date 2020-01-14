//
//  Fonts.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

struct Fonts {
    
    static let arvo              = "Arvo"
    static let arvoBold          = "Arvo-Bold"
    static let openSans          = "OpenSans-Regular"
    static let openSansBold      = "OpenSans-Bold"
    static let openSansSemiBold  = "OpenSans-SemiBold"
    static let openSansLight     = "OpenSans-Light"

    struct Size {
        static let title:         CGFloat = 34.0
        static let primaryText:   CGFloat = 17.0
        static let secondaryText: CGFloat = 15.0
        static let tertiaryText:  CGFloat = 13.0
        static let button:        CGFloat = 17.0
        static let actionBar:     CGFloat = 10.0
    }
    
    struct Header {
        static let name = UIFont(name: arvoBold, size: Size.title)
        static let smallName = UIFont(name: arvo, size: Size.title)
    }
    
    struct Scroll {
        
    }
    
    struct Overview {
        static let boxTitle = UIFont(name: openSansSemiBold, size: Size.primaryText)
        static let boxContent = UIFont(name: openSans, size: Size.secondaryText)
    }
    
    struct Footer {
        
    }
    
    struct Menu {
        static let selected = UIFont(name: openSansBold, size: Size.secondaryText)
        static let normal   = UIFont(name: openSans,     size: Size.secondaryText)
    }
    
}
