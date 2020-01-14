//
//  Sizing.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

struct Sizing {
    
    static let height      = UIScreen.main.bounds.height
    static let width       = UIScreen.main.bounds.width
    static let keyWindow   = UIApplication.shared.windows[0]
    static let statusBar   = keyWindow.windowScene!.statusBarManager!.statusBarFrame
    static let padding     = statusBar.height/2
    static let paddedWidth = width-statusBar.height
    
    struct Ratio {
        static let expandedHeader:  CGFloat = 0.42
        static let minimizedHeader: CGFloat = 0.10
        static var scroll:          CGFloat = 1-minimizedHeader {
            didSet {
                Scroll.height = Sizing.height * scroll
            }
        }
        static let footer:          CGFloat = 0.10
    }
    
    struct Header {
        static let expandedHeight      = Sizing.height * Ratio.expandedHeader
        static var minimizedHeight     = Sizing.height * Ratio.minimizedHeader
        static var heightAdjustment    = expandedHeight - minimizedHeight
        static var nameHeight          = expandedHeight/2 {
            didSet {
                Scroll.limit = nameHeight + nameBottom
                minimizedHeight = nameHeight + statusBar.height + padding
                heightAdjustment = expandedHeight - minimizedHeight
                Ratio.scroll = 1 - minimizedHeight/Sizing.height
            }
        }
        static let nameBottom          = padding
    }
    
    struct Scroll {
        static var height = Sizing.height * Ratio.scroll
        static var limit = Header.nameHeight + Header.nameBottom
        static let radius: CGFloat = min(0.094 * min(width, height), 39.0)
    }
    
    struct Overview {
        static let height = Sizing.height - Header.expandedHeight - Footer.height - padding
        static var box1Height = objectiveHeight + Header.nameBottom
        static let boxWidth = paddedWidth
        static let boxRadius: CGFloat = min(0.047 * min(width, height), 39.0)
        static var objectiveHeight = height * 0.6 {
            didSet {
                box1Height = objectiveHeight + Header.nameBottom
            }
        }
        static let boxPaddedWidth = boxWidth - Header.nameBottom
    }
    
    struct Footer {
        static let height = Sizing.height * Ratio.footer - padding
        static let radius: CGFloat = 0.047 * width// min(width, height) // 0.188
    }
    
    struct Menu {
        static let iconDiameter = Footer.height * (2/3) - padding
        static let textHeight = Footer.height * (1/3)
        static let textWidth = (paddedWidth-(padding*3))/3
    }
    
}
