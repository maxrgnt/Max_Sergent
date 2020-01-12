//
//  UI_NEW.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/8/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

struct UI_NEW {
        
    struct Sizing {
        
        static let height = UIScreen.main.bounds.height
        static let width = UIScreen.main.bounds.width
        static let keyWindow = UIApplication.shared.windows[0]
        static let statusBar = keyWindow.windowScene!.statusBarManager!.statusBarFrame
        static let padding = statusBar.height/2
        static let widthObjectPadding = width-statusBar.height
        
        struct Ratio {
            static let minimizedHeaderHeight: CGFloat = 0.1
            static let expandedHeaderHeight: CGFloat = 0.35
            static let menuHeight: CGFloat = 0.07
            // Scroll height behind footer, do we want this?
            static let scrollHeight: CGFloat = 1-minimizedHeaderHeight-menuHeight
        }
        
        struct Header {
            //static let expandedHeight = (UI.Sizing.height - statusBar.height) * Ratio.expandedHeaderHeight
            static let expandedHeight = (Sizing.height) * Ratio.expandedHeaderHeight
            //static let minimizedHeight = (UI.Sizing.height - statusBar.height) * Ratio.minimizedHeaderHeight
            static let minimizedHeight = (Sizing.height) * Ratio.minimizedHeaderHeight + statusBar.height
            static let heightDiff = expandedHeight-minimizedHeight
            static let width = Sizing.width
            static let pictureHeight = expandedHeight
            static let gradientHeight = expandedHeight - statusBar.height
            static let expandedNameHeight = (expandedHeight-padding)/2
            static let minimizedNameHeight = (minimizedHeight-padding-statusBar.height)
            static let nameDiff = expandedNameHeight-minimizedNameHeight
            static let nameWidth = widthObjectPadding
            static let nameBottom = -padding/2
            static let menuHeight = (Sizing.height) * Ratio.menuHeight
            static let menuWidth = widthObjectPadding
        }
        
        struct Scroll {
            static let height = Sizing.height - Header.minimizedHeight - Footer.height
            static let width = Sizing.width
        }
        
        struct Overview {
            static let height = Sizing.height - Header.expandedHeight - Footer.height
            static let width = Sizing.width
            static let objectiveHeight = height * 0.4
            static let objectiveWidth = widthObjectPadding
            static let contactBarHeight = ContactBar.height
            static let contactBarWidth = ContactBar.width
        }
        
        struct ContactBar {
            static let padding = Sizing.padding/2
            static let height = iconDiameter + padding
            static let width = widthObjectPadding
            static let iconDiameter = Overview.height*0.05
            static let textWidth = (width-iconDiameter*2-padding*2)/2
        }
        
        struct Tracker {
            static let width = widthObjectPadding
            static let height = Overview.height-Overview.objectiveHeight-ContactBar.height
            static let headerWidth = widthObjectPadding
            static let headerHeight = Overview.height*0.05
        }
        
        struct Footer {
            static let height = menuHeight + statusBar.height
            static let width = Sizing.width
            static let menuHeight = (Sizing.height) * Ratio.menuHeight
            static let menuWidth = widthObjectPadding
        }
        
    }
}

extension UI_NEW {
    
    struct Fonts {
        
        struct Size {
            static let H1 = Sizing.height * (0.105)
            static let H2 = Sizing.height * (0.085)
            static let H3 = Sizing.height * (0.065)
            static let H4 = Sizing.height * (0.045)
            static let H5 = Sizing.height * (0.025)
            static let H6 = Sizing.height * (0.020)
            static let H7 = Sizing.height * (0.015)
        }
        
        static let arvo = "Arvo"
        static let arvoBold = "Arvo-Bold"
        static let openSans = "OpenSans-Regular"
        static let openSansBold = "OpenSans-Bold"
        static let openSansLight = "OpenSans-Light"
        
        struct Header {
            static let name = UIFont(name: arvo, size: Size.H1)
        }
        
        struct Overview {
            static let objective = UIFont(name: openSans, size: Size.H3)
            static let contactText = UIFont(name: openSans, size: Size.H7)
        }
        
        struct Tracker {
            static let header = UIFont(name: openSansBold, size: Size.H6)
        }
        
        struct Menu {
            static let selected = UIFont(name: openSansBold, size: Size.H6)
            static let normal   = UIFont(name: openSans,     size: Size.H6)
        }
    }
}

extension UI_NEW {
    
    struct Colors {
        
        /* Alter color scheme here  */
        static let headerBackground = UIColor.black
        static let overviewBackground = UIColor.darkGray
        static let primaryFontColor = UIColor.white
        static let secondaryFontColor = UIColor.lightGray
        static let tertiaryFontColor = UIColor.black
        
        static let footerEffectStyle = UIBlurEffect.Style.light
        /****************************/
        
        struct Header {
            static let background = headerBackground
            static let name = primaryFontColor
        }
        
        struct Overview {
            static let objective = primaryFontColor
            static let emailText = primaryFontColor
            static let locationText = primaryFontColor
        }
        
        struct Tracker {
            static let header = primaryFontColor
        }
    }
    
}
