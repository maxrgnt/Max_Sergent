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
        
        struct Overview {
            static let padding = objectPadding
            static let height = UI.Sizing.height - statusBar.height
            static let width = UI.Sizing.width
            static let pictureDiameter = height/2 - padding*2
            static let pictureRadius = pictureDiameter/2
            static let nameHeight = height/2 - padding
            static let nameWidth = width - padding
        }
        
    }
    
}

extension UI {
    
    struct Fonts {
        
        static let arvo = "Arvo"
        static let arvoBold = "Arvo-Bold"
        
        struct Overview {
            static let name = UIFont(name: arvo, size: Sizing.Overview.nameHeight/2)
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
