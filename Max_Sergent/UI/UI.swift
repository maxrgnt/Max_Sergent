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
        
        struct Header {
            static let padding = objectPadding
            static let expandedHeight = (UI.Sizing.height - statusBar.height) * 0.4
            static let minimizedHeight = (UI.Sizing.height - statusBar.height) * 0.2
            static let width = UI.Sizing.width
            static let pictureDiameter = (expandedHeight-padding)/2
            static let pictureRadius = pictureDiameter/2
            static let nameHeight = (expandedHeight-padding)/2
            static let nameWidth = width - padding
        }
        
        struct Scroll {
            static let padding = objectPadding
            static let height = (UI.Sizing.height - statusBar.height) * 0.8
            static let width = UI.Sizing.width
        }
        
    }
    
}

extension UI {
    
    struct Fonts {
        
        static let arvo = "Arvo"
        static let arvoBold = "Arvo-Bold"
        
        struct Overview {
            static let name = UIFont(name: arvo, size: Sizing.Header.nameHeight/2)
        }
        
    }
    
}

extension UI {
    
    struct Colors {
        
        /* Alter color scheme here  */
        static let overviewBackground = UIColor.darkGray
        static let primaryFontColor = UIColor.white
        /****************************/
        
        struct Overview {
            static let background = overviewBackground
            static let name = primaryFontColor
        }
        
    }
    
}
