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
    
    static func calculateLabelHeight(for text: String,
                                     withFont font: UIFont,
                                     withWidth width: CGFloat,
                                     numberOfLines: Int) -> CGFloat {
        let max = CGFloat.greatestFiniteMagnitude
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: max))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
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
        static let concepts:      CGFloat = 12.0
        static let actionBar:     CGFloat = 10.0
    }
    
    struct Splash {
        static let title = UIFont(name: openSansSemiBold, size: Size.primaryText)
    }
    
    struct Header {
        static let name = UIFont(name: arvoBold, size: Size.title)
        static let smallName = UIFont(name: arvo, size: Size.title)
    }
    
    struct Scroll {
        
    }
    
    struct Overview {
        static let title = UIFont(name: openSansSemiBold, size: Size.primaryText)
        static let content = UIFont(name: openSans, size: Size.secondaryText)
    }
    
    struct Timeline {
        static let title = UIFont(name: openSansBold, size: Size.title)
        static let boxHeader = UIFont(name: openSansSemiBold, size: Size.primaryText)
        static let boxDistinction = UIFont(name: openSans, size: Size.actionBar)
        static let boxContent = UIFont(name: openSans, size: Size.secondaryText)
    }
    
    struct Details {
        
    }
    
    struct Pie {
        static let header = UIFont(name: openSansSemiBold, size: Size.primaryText)
        static let asOf = UIFont(name: openSansBold, size: Size.secondaryText)
        static let originDate = UIFont(name: arvoBold, size: Size.title)
        static let legend = UIFont(name: openSans, size: Size.secondaryText)
        static let percent = UIFont(name: openSansBold, size: Size.secondaryText)
    }
    
    struct Concepts {
        static let header = UIFont(name: openSansSemiBold, size: Size.primaryText)
        static let title = UIFont(name: openSans, size: Size.concepts) // this is hard coded over in SIZING
    }
    
    struct Footer {
        
    }
    
    struct Menu {
        static let selected = UIFont(name: openSansBold, size: Size.secondaryText)
        static let normal   = UIFont(name: openSans,     size: Size.secondaryText)
    }
    
}
