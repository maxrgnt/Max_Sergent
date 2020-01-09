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
            static let expandedHeaderHeight: CGFloat = 0.42
            static let menuHeight: CGFloat = 0.07
            static let scrollHeight: CGFloat = 1-minimizedHeaderHeight-menuHeight
        }
        
        struct Header {
            //static let expandedHeight = (UI.Sizing.height - statusBar.height) * Ratio.expandedHeaderHeight
            static let expandedHeight = (Sizing.height) * Ratio.expandedHeaderHeight
            //static let minimizedHeight = (UI.Sizing.height - statusBar.height) * Ratio.minimizedHeaderHeight
            static let minimizedHeight = (Sizing.height) * Ratio.minimizedHeaderHeight
            static let heightDiff = Sizing.Header.expandedHeight-Sizing.Header.minimizedHeight
            static let width = Sizing.width
            static let pictureHeight = expandedHeight
            static let gradientHeight = expandedHeight - statusBar.height
            static let expandedNameHeight = (expandedHeight-padding)/2
            static let minimizedNameHeight = (minimizedHeight-padding)
            static let nameWidth = widthObjectPadding
            static let menuHeight = (Sizing.height) * Ratio.menuHeight
            static let menuWidth = widthObjectPadding
        }
        
        struct Scroll {
            static let height = Sizing.height - Header.minimizedHeight - statusBar.height
            static let width = Sizing.width
        }
        
        struct Overview {
            static let height = Sizing.height - Header.expandedHeight
            static let width = Sizing.width
            static let objectiveHeight = height * 0.5
            static let objectiveWidth = widthObjectPadding
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
        /****************************/
        
        struct Header {
            static let background = headerBackground
            static let name = primaryFontColor
        }
    }
    
}
