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
    static let watermarkHeight = (height * Ratio.watermark) - padding
    static let verticalLabelOffset: CGFloat = -5.0
    
    struct Ratio {
        static let expandedHeader:  CGFloat = 0.42
        static let minimizedHeader: CGFloat = 0.10
        static let watermark:       CGFloat = 1-expandedHeader-footer
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
        static let padding = Header.nameBottom
        static let height = Sizing.height - Header.expandedHeight - Footer.height - padding
        static let boxWidth = paddedWidth
        static let boxRadius: CGFloat = min(0.047 * min(width, height), 39.0)
        static let boxPaddedWidth = boxWidth - padding
    }
    
    struct Timeline {
        static let lineWidth = Sizing.paddedWidth/50
        static let nodeDiameter = lineWidth*3
        static let nodeRadius = nodeDiameter/2
        static let leadingCell = nodeRadius + Sizing.padding - lineWidth/2
        static let iconDiameter: CGFloat = 34.0
        static let boxWidth = paddedWidth - lineWidth - Sizing.padding
        static let boxRadius: CGFloat = min(0.047 * min(width, height), 39.0)
        static let contentWidth = boxWidth - iconDiameter - Sizing.padding*(3/2)
        static let boxLeading = Sizing.padding/2
        static let distinctionHeight = Fonts.Timeline.boxDistinction!.pointSize + Sizing.padding/2
        static let extraForFirstRow = Sizing.padding/2
        
        struct vert {
            static let boxTop = Sizing.padding/2
            static let iconTop = Sizing.padding/2
            static let distinctionTop = Sizing.padding/4
            static let contentTop = distinctionTop
            static let contentBottom = boxTop*1.5
        }
    }
    
    struct Details {
        
    }
    
    struct Pie {
        static let diameter = Sizing.paddedWidth
        static let circleRadius = diameter/2 - lineWidth/2 - lineWidth
        static let textRadius = diameter/2 - lineWidth/2
        static let center = CGPoint(x: diameter/2, y: diameter/2)
        static let lineWidth = diameter/10
        static let lineGap = 10.0
    }
    
    struct Concepts {
        
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
