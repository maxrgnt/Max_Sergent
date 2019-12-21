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
            static let nameWidth = width - padding*2
            static let nameBottomPadding = -padding/2
        }
        
        struct Scroll {
            static let padding = objectPadding
            static let height = (UI.Sizing.height - statusBar.height) * Ratio.scrollHeight
            static let width = UI.Sizing.width
            static let contentWidth = width * 4
            static let limit = width-Header.pictureDiameter
        }
        
        struct Overview {
            static let padding = objectPadding
            static let height = Scroll.height
            static let width = UI.Sizing.width
            static let topPadding = padding/2

            static let objectiveHeight = height*(0.28)
            static let originDateHeight = height*(0.04)
            static let projectHeight = height*(0.04)
            static let barHeight = height*(0.016)
            static let statHeight = barHeight*2

            static let paddedWidth = width-(padding*2)
            static var objectiveWidth = paddedWidth
            static var originDateWidth = paddedWidth
            static var projectWidth = paddedWidth
            static var barWidth = paddedWidth
            static var statWidth = paddedWidth
            
            static let barRadius = barHeight/2
        }
        
        struct Experience {
            static let padding = objectPadding
            static let height = Scroll.height
            static let width = UI.Sizing.width
            static let topPadding = padding/2

            static let headerHeight = height*(0.04)
            
            static let paddedWidth = width-(padding*2)
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
            static let originDateMain = UIFont(name: openSansBold, size: Sizing.Overview.originDateHeight*(3/4))
            static let originDateSuper = UIFont(name: openSansBold, size: Sizing.Overview.originDateHeight*(3/4)/2)
            static let project = UIFont(name: openSans, size: Sizing.Overview.projectHeight*(3/4))
            static let stat = UIFont(name: openSans, size: Sizing.Overview.statHeight*(2/3))
        }
        
        struct Experience {
            static let header = UIFont(name: openSansBold, size: Sizing.Overview.originDateHeight*(3/4))
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
        static let tertiaryFontColor = UIColor.black
        /****************************/
        
        struct Header {
            static let background = headerBackground
            static let name = primaryFontColor
        }
        
        struct Overview {
            static let background = overviewBackground
            static let objective = secondaryFontColor
            static let originDate = secondaryFontColor
            static let project = secondaryFontColor
            static let stat = secondaryFontColor
        }
     
        struct Experience {
            static let header = secondaryFontColor
        }
        
    }
    
}
