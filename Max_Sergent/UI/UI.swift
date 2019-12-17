//
//  UI.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/9/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

struct UI {
        
    struct Sizing {
        
        static let height = UIScreen.main.bounds.height
        static let width = UIScreen.main.bounds.width
        static let keyWindow = UIApplication.shared.windows[0]
        static let statusBar = keyWindow.windowScene!.statusBarManager!.statusBarFrame
        static let objectPadding = statusBar.height/2
        static let widthObjectPadding = width-statusBar.height
        
        struct Ratio {
            static let minimizedHeaderHeight: CGFloat = 0.1
            static let expandedHeaderHeight: CGFloat = 0.4
            static let scrollHeight: CGFloat = 1-minimizedHeaderHeight
        }
        
        struct Header {
            static let padding = objectPadding
            static let expandedHeight = (UI.Sizing.height - statusBar.height) * Ratio.expandedHeaderHeight
            static let minimizedHeight = (UI.Sizing.height - statusBar.height) * Ratio.minimizedHeaderHeight
            static let width = UI.Sizing.width
            static let pictureDiameter = (expandedHeight-padding)/2
            static let pictureRadius = pictureDiameter/2
            static let pictureTopPadding = padding/2
            static let expandedNameHeight = (expandedHeight-padding)/2
            static let minimizedNameHeight = (minimizedHeight-padding)
            static let nameWidth = width - padding
            static let nameBottomPadding = -padding/2
        }
        
        struct Scroll {
            static let padding = objectPadding
            static let height = (UI.Sizing.height - statusBar.height) * Ratio.scrollHeight
            static let width = UI.Sizing.width
        }
        
        struct Overview {
            static let padding = objectPadding
            static let height = Scroll.height
            static let width = UI.Sizing.width
            static let objectiveHeight = height*(0.3)
            static let objectiveWidth = width-padding
            static let projectHeight = objectiveHeight/4
            static let projectWidth = width-padding
            static let barHeight = projectHeight/5
            static let statHeight = barHeight*2
            static let statWidth = width-padding
        }
        
    }
    
}

extension UI {
    
    struct Fonts {
        
        static let arvo = "Arvo"
        static let arvoBold = "Arvo-Bold"
        static let openSans = "OpenSans-Regular"
        static let openSansBold = "OpenSans-Bold"
        static let openSansLight = "OpenSans-Light"
        
        struct Header {
            static let name = UIFont(name: arvo, size: Sizing.Header.expandedNameHeight/2)
        }
        
        struct Overview {
            static let objective = UIFont(name: openSans, size: Sizing.Overview.objectiveHeight/2)
            static let project = UIFont(name: openSansBold, size: Sizing.Overview.objectiveHeight/3)
            static let stat = UIFont(name: openSans, size: Sizing.Overview.statHeight*(2/3))
        }
        
    }
    
}

extension UI {
    
    struct Colors {
        
        /* Alter color scheme here  */
        static let headerBackground = UIColor.black
        static let overviewBackground = UIColor.darkGray
        static let primaryFontColor = UIColor.white
        static let secondaryFontColor = UIColor.lightGray
        /****************************/
        
        struct Header {
            static let background = headerBackground
            static let name = primaryFontColor
        }
        
        struct Overview {
            static let background = overviewBackground
            static let objective = primaryFontColor
            static let project = primaryFontColor
            static let stat = secondaryFontColor
        }
        
    }
    
}
