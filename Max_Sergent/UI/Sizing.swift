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

    init() {
        print("Setting Sizing")
    }
    
    // 667.0    iPhone 6 / iPhone 7 / iPhone 8
    //
    
    static var height      = UIScreen.main.bounds.height
    static var offsetForShorterScreens: CGFloat = 0.0 {
        didSet {
            Header.expandedHeight      = (Sizing.height * Ratio.expandedHeader) + offsetForShorterScreens
            Header.minimizedHeight     = (Sizing.height * Ratio.minimizedHeader) + offsetForShorterScreens
            Header.heightAdjustment    = Header.expandedHeight - Header.minimizedHeight
            Header.nameHeight          = Header.expandedHeight/2
        }
    }
    static let width       = UIScreen.main.bounds.width
    static let keyWindow   = UIApplication.shared.windows[0]
    static let statusBar   = keyWindow.windowScene!.statusBarManager!.statusBarFrame
    static var padding     = statusBar.height/2 {
        didSet {
            Header.padding = padding
            Overview.padding = padding
            Timeline.padding = padding
            Details.padding = padding
            Pie.padding = padding
            Concepts.padding = padding
            Footer.padding = padding
            Menu.padding = padding
            paddedWidth = width - padding*2
        }
    }
    static var paddedWidth = width-statusBar.height
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
        static var padding = Sizing.padding
        static var expandedHeight      = Sizing.height * Ratio.expandedHeader + offsetForShorterScreens
        static var minimizedHeight     = Sizing.height * Ratio.minimizedHeader + offsetForShorterScreens
        static var heightAdjustment    = expandedHeight - minimizedHeight
        static var nameHeight          = expandedHeight/2 {
            didSet {
                Scroll.limit = nameHeight + nameBottom
                minimizedHeight = nameHeight + padding*2 + padding
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
        static var padding = Header.nameBottom
        static let height = Sizing.height - Header.expandedHeight - Footer.height - padding
        static let boxWidth = paddedWidth
        static let boxRadius: CGFloat = min(0.047 * min(width, height), 39.0)
        static let boxPaddedWidth = boxWidth - padding
    }
    
    struct Timeline {
        static var padding = Sizing.padding
        static let lineWidth = Sizing.paddedWidth/50
        static let nodeDiameter = lineWidth*3
        static let nodeRadius = nodeDiameter/2
        static let leadingCell = nodeRadius + padding - lineWidth/2
        static let iconDiameter: CGFloat = 34.0
        static let boxWidth = paddedWidth - lineWidth - padding
        static let boxRadius: CGFloat = min(0.047 * min(width, height), 39.0)
        static let contentWidth = boxWidth - iconDiameter - padding*(3/2)
        static let boxLeading = padding/2
        static let distinctionHeight = Fonts.Timeline.boxDistinction!.pointSize + padding/2
        static let extraForFirstRow = padding/2
        
        struct vert {
            static let boxTop = padding/2
            static let iconTop = padding/2
            static let distinctionTop = padding/4
            static let contentTop = distinctionTop
            static let contentBottom = boxTop*1.5
        }
    }
    
    struct Details {
        static var padding = Sizing.padding
    }
    
    struct Pie {
        static var padding = Sizing.padding
        static let boxRadius: CGFloat = min(0.047 * paddedWidth, 39.0)
        static let diameter = Sizing.paddedWidth - padding
        static let circleRadius = diameter/2 - lineWidth/2 - lineWidth
        static let textRadius = diameter/2 - lineWidth/2
        static let center = CGPoint(x: paddedWidth/2, y: paddedWidth/2)
        static let lineWidth = diameter/10
        static let lineGap = 10.0
    }
    
    struct Concepts {
        static var padding = Sizing.padding
        static let cellWidth: CGFloat = (paddedWidth-padding*3)/Constants.Concepts.objectsPerRow
        static var cellHeight: CGFloat = cellWidth + padding*(3/2) + titleHeight // label margin
        static let contentWidth = cellWidth - padding/2
        static let boxRadius: CGFloat = min(0.047 * paddedWidth, 39.0)
        static var titleHeight: CGFloat = Fonts.Concepts.title!.pointSize * 2 {
            didSet {
                cellHeight = cellWidth + titleHeight + padding*(3/2)
            }
        }
    }
    
    struct Footer {
        static var padding = Sizing.padding
        static let height = Sizing.height * Ratio.footer - padding
        static let radius: CGFloat = 0.047 * width// min(width, height) // 0.188
    }
    
    struct Menu {
        static var padding = Sizing.padding
        static let iconDiameter = Footer.height * (2/3) - padding
        static let textHeight = Footer.height * (1/3)
        static let textWidth = (paddedWidth-(padding*3))/3
        static let scrollOffset = Sizing.Footer.height + padding
    }
    
}
