//
//  Colors.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

struct Colors {
    
    /* Alter color scheme here  */
    static let primaryBackground   = UIColor.black
    static let secondaryBackground = UIColor.darkGray
    static let tertiaryBackground = UIColor.gray
    static let primaryFontColor    = UIColor.white
    static let secondaryFontColor  = UIColor.lightGray
    static let tertiaryFontColor   = UIColor.black
    
    
    static let footerEffectStyle   = UIBlurEffect.Style.dark
    /****************************/
    struct ViewController {
        static let background = primaryBackground
        static let watermark = secondaryBackground
    }
    
    struct Header {
        static let background = primaryBackground
        static let name       = primaryFontColor
        static let gradient   = primaryBackground
    }
    
    struct Scroll {
        static let background = primaryBackground
    }
    
    struct Overview {
        static let box = tertiaryBackground
        static let boxTitle = primaryFontColor
        static let boxContent = primaryFontColor
    }
    
    struct Timeline {
        static let background = secondaryBackground
        static let title = primaryFontColor
        static let node = primaryFontColor
        static let line = primaryFontColor
    }
    
    struct Footer {
        
    }
    
    struct Menu {
        static let text = primaryFontColor
    }
    
}