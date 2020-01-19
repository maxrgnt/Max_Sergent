//
//  Constraints.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

//MARK: ViewController
extension ViewController {
    
    func constraints() {
        watermark.translatesAutoresizingMaskIntoConstraints                                                             = false
        watermark.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                   = true
        watermark.topAnchor.constraint(equalTo: header.bottomAnchor).isActive                                           = true
        watermark.widthAnchor.constraint(equalToConstant: Sizing.width).isActive                                        = true
        watermark.heightAnchor.constraint(equalToConstant: Sizing.watermarkHeight).isActive                               = true
        
        header.height = header.heightAnchor.constraint(equalToConstant: Sizing.Header.expandedHeight)
        header.translatesAutoresizingMaskIntoConstraints                                                                = false
        header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                      = true
        header.topAnchor.constraint(equalTo: self.view.topAnchor).isActive                                              = true
        header.widthAnchor.constraint(equalToConstant: Sizing.width).isActive                                           = true
        header.height.isActive                                                                                          = true
        
        scroll.translatesAutoresizingMaskIntoConstraints                                                                = false
        scroll.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                      = true
        scroll.topAnchor.constraint(equalTo: header.bottomAnchor).isActive                                              = true
        scroll.widthAnchor.constraint(equalToConstant: Sizing.width).isActive                                           = true
        scroll.heightAnchor.constraint(equalToConstant: Sizing.Scroll.height).isActive                                  = true
        
        footer.translatesAutoresizingMaskIntoConstraints                                                                = false
        footer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                      = true
        footer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Sizing.padding).isActive             = true
        footer.widthAnchor.constraint(equalToConstant: Sizing.paddedWidth).isActive                                     = true
        footer.heightAnchor.constraint(equalToConstant: Sizing.Footer.height).isActive                                  = true
    }
    
}

//MARK: Header
extension Header {
    
    func constraints() {
        nameHeight = name.heightAnchor.constraint(equalToConstant: Sizing.Header.nameHeight)
        nameBottom = name.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Sizing.Header.nameBottom)
        name.translatesAutoresizingMaskIntoConstraints                                                                  = false
        name.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                  = true
        nameBottom.isActive                                                                                             = true
        name.widthAnchor.constraint(equalToConstant: Sizing.paddedWidth).isActive                                       = true
        nameHeight.isActive                                                                                             = true
        
        photo.translatesAutoresizingMaskIntoConstraints                                                                 = false
        photo.topAnchor.constraint(equalTo: topAnchor).isActive                                                         = true
        photo.leadingAnchor.constraint(equalTo: leadingAnchor).isActive                                                 = true
        photo.bottomAnchor.constraint(equalTo: bottomAnchor).isActive                                                   = true
        photo.trailingAnchor.constraint(equalTo: trailingAnchor).isActive                                               = true
    }
    
}

//MARK: Scroll
extension Scroll {
    
    func constraints() {
        page1.translatesAutoresizingMaskIntoConstraints                                                                 = false
        page1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                 = true
        page1.topAnchor.constraint(equalTo: topAnchor).isActive                                                         = true
        page1.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                     = true
        page1.heightAnchor.constraint(equalTo: heightAnchor).isActive                                                   = true
        
        page2.translatesAutoresizingMaskIntoConstraints                                                                 = false
        page2.leadingAnchor.constraint(equalTo: page1.trailingAnchor).isActive                                          = true
        page2.topAnchor.constraint(equalTo: topAnchor).isActive                                                         = true
        page2.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                     = true
        page2.heightAnchor.constraint(equalTo: heightAnchor).isActive                                                   = true
        
        page3.translatesAutoresizingMaskIntoConstraints                                                                 = false
        page3.leadingAnchor.constraint(equalTo: page2.trailingAnchor).isActive                                          = true
        page3.topAnchor.constraint(equalTo: topAnchor).isActive                                                         = true
        page3.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                     = true
        page3.heightAnchor.constraint(equalTo: heightAnchor).isActive                                                   = true
    }
    
}

//MARK: OverviewSection
extension OverviewSection {
    
    func constraints() {
        titleCenterY = title.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.0)
        titleHeight = title.heightAnchor.constraint(equalToConstant: 0.0)
        title.translatesAutoresizingMaskIntoConstraints                                                                 = false
        title.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                 = true
        titleCenterY.isActive                                                                                           = true
        title.widthAnchor.constraint(equalToConstant: Sizing.Overview.boxPaddedWidth).isActive                          = true
        titleHeight.isActive                                                                                            = true
    }
    
}

//MARK: OverviewCell
extension OverviewCell {
    
    func constraints() {
        let padding = Sizing.Overview.padding/2
    
        boxHeight = box.heightAnchor.constraint(equalToConstant: 0.0)
        boxTop = box.topAnchor.constraint(equalTo: topAnchor, constant: padding)
        box.translatesAutoresizingMaskIntoConstraints                                                                   = false
        box.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                   = true
        boxTop.isActive                                                                                                 = true
        box.widthAnchor.constraint(equalToConstant: Sizing.Overview.boxWidth).isActive                                  = true
        boxHeight.isActive                                                                                              = true
        
        iconHeight = icon.heightAnchor.constraint(equalToConstant: 0.0)
        iconWidth = icon.widthAnchor.constraint(equalToConstant: 0.0)
        icon.translatesAutoresizingMaskIntoConstraints                                                                  = false
        icon.leadingAnchor.constraint(equalTo: box.leadingAnchor, constant: padding).isActive                           = true
        icon.centerYAnchor.constraint(equalTo: box.centerYAnchor).isActive                                              = true
        iconWidth.isActive                                                                                              = true
        iconHeight.isActive                                                                                             = true
        
        contentHeight = content.heightAnchor.constraint(equalToConstant: 0.0)
        contentLeading = content.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: padding)
        content.translatesAutoresizingMaskIntoConstraints                                                               = false
        contentLeading.isActive                                                                                         = true
        content.centerYAnchor.constraint(equalTo: box.centerYAnchor).isActive                                           = true
        content.widthAnchor.constraint(equalToConstant: Sizing.Overview.boxPaddedWidth).isActive                        = true
        contentHeight.isActive                                                                                          = true
    }
    
}

//MARK: 

//MARK: TimelineRefresh
extension TimelineRefresh {
    
    func constraints() {
        title.translatesAutoresizingMaskIntoConstraints                                                                 = false
        title.leadingAnchor.constraint(equalTo: node.trailingAnchor, constant: Sizing.padding/2).isActive               = true
        title.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.0).isActive                                  = true
        title.widthAnchor.constraint(equalToConstant: Sizing.Overview.boxPaddedWidth).isActive                          = true
        title.heightAnchor.constraint(equalToConstant: Fonts.Timeline.title!.pointSize).isActive                        = true
        
        line.translatesAutoresizingMaskIntoConstraints                                                                  = false
        line.centerXAnchor.constraint(equalTo: node.centerXAnchor).isActive                                             = true
        line.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10.0).isActive                                    = true
        line.widthAnchor.constraint(equalToConstant: Sizing.Timeline.lineWidth).isActive                                = true
        line.topAnchor.constraint(equalTo: topAnchor).isActive                                                          = true
        
        icon.translatesAutoresizingMaskIntoConstraints                                                                  = false
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                  = true
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        icon.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45).isActive                                   = true
        icon.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.45).isActive                                  = true
        
        node.translatesAutoresizingMaskIntoConstraints                                                                  = false
        node.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizing.padding).isActive                        = true
        node.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        node.widthAnchor.constraint(equalToConstant: Sizing.Timeline.nodeDiameter).isActive                             = true
        node.heightAnchor.constraint(equalToConstant: Sizing.Timeline.nodeDiameter).isActive                            = true
    }
    
}

//MARK: TimelineSection
extension TimelineSection {
    
    func constraints() {
        titleCenterY = title.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.0)
        titleHeight = title.heightAnchor.constraint(equalToConstant: 0.0)
        title.translatesAutoresizingMaskIntoConstraints                                                                 = false
        title.leadingAnchor.constraint(equalTo: node.trailingAnchor, constant: Sizing.padding/2).isActive               = true
        titleCenterY.isActive                                                                                           = true
        title.widthAnchor.constraint(equalToConstant: Sizing.Overview.boxPaddedWidth).isActive                          = true
        titleHeight.isActive                                                                                            = true
        
        line.translatesAutoresizingMaskIntoConstraints                                                                  = false
        line.centerXAnchor.constraint(equalTo: node.centerXAnchor).isActive                                             = true
        line.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        line.widthAnchor.constraint(equalToConstant: Sizing.Timeline.lineWidth).isActive                                = true
        line.topAnchor.constraint(equalTo: topAnchor, constant: -10.0).isActive                                         = true
        line.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10.0).isActive                                    = true
        
        node.translatesAutoresizingMaskIntoConstraints                                                                  = false
        node.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizing.padding).isActive                        = true
        node.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive                                            = true
        node.widthAnchor.constraint(equalToConstant: Sizing.Timeline.nodeDiameter).isActive                             = true
        node.heightAnchor.constraint(equalToConstant: Sizing.Timeline.nodeDiameter).isActive                            = true
    }
    
}

//MARK: TimelineCell
extension TimelineCell {
    
    func constraints() {
        let padding = Sizing.Overview.padding/2
        
        line.translatesAutoresizingMaskIntoConstraints                                                                  = false
        line.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizing.Timeline.leadingCell).isActive           = true
        line.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        line.widthAnchor.constraint(equalToConstant: Sizing.Timeline.lineWidth).isActive                                = true
        line.heightAnchor.constraint(equalTo: heightAnchor).isActive                                                    = true
    
        boxHeight = box.heightAnchor.constraint(equalToConstant: 0.0)
        boxTop = box.topAnchor.constraint(equalTo: header.bottomAnchor, constant: padding)
        box.translatesAutoresizingMaskIntoConstraints                                                                   = false
        box.leadingAnchor.constraint(equalTo: line.trailingAnchor, constant: padding).isActive                          = true
        boxTop.isActive                                                                                                 = true
        box.widthAnchor.constraint(equalToConstant: Sizing.Timeline.boxWidth).isActive                                  = true
        boxHeight.isActive                                                                                              = true
    
        headerHeight = header.heightAnchor.constraint(equalToConstant: 0.0)
        header.translatesAutoresizingMaskIntoConstraints                                                                = false
        header.leadingAnchor.constraint(equalTo: icon.leadingAnchor).isActive                                           = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive                                     = true
        header.widthAnchor.constraint(equalToConstant: Sizing.Timeline.contentWidth).isActive                           = true
        headerHeight.isActive                                                                                           = true
        
        boxHeaderHeight = boxHeader.heightAnchor.constraint(equalToConstant: 0.0)
        boxHeader.translatesAutoresizingMaskIntoConstraints                                                             = false
        boxHeader.leadingAnchor.constraint(equalTo: icon.leadingAnchor).isActive                                        = true
        boxHeader.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive                                  = true
        boxHeader.widthAnchor.constraint(equalToConstant: Sizing.Timeline.contentWidth).isActive                        = true
        boxHeaderHeight.isActive                                                                                        = true
        
        iconHeight = icon.heightAnchor.constraint(equalToConstant: Sizing.Timeline.iconDiameter)
        iconWidth = icon.widthAnchor.constraint(equalToConstant: Sizing.Timeline.iconDiameter)
        icon.translatesAutoresizingMaskIntoConstraints                                                                  = false
        icon.leadingAnchor.constraint(equalTo: box.leadingAnchor, constant: padding).isActive                           = true
        icon.topAnchor.constraint(equalTo: box.topAnchor, constant: Sizing.Timeline.vert.iconTop).isActive              = true
        iconWidth.isActive                                                                                              = true
        iconHeight.isActive                                                                                             = true
        
        distinctionWidth = distinction.widthAnchor.constraint(equalToConstant: 0.0)
        distinction.translatesAutoresizingMaskIntoConstraints                                                           = false
        distinction.trailingAnchor.constraint(equalTo: box.trailingAnchor, constant: -padding).isActive                 = true
        distinction.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive                                    = true
        distinctionWidth.isActive                                                                                       = true
        distinction.heightAnchor.constraint(equalToConstant: Sizing.Timeline.distinctionHeight).isActive                = true
        
        contentHeight = content.heightAnchor.constraint(equalToConstant: 0.0)
        contentLeading = content.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: padding)
        content.translatesAutoresizingMaskIntoConstraints                                                               = false
        contentLeading.isActive                                                                                         = true
        content.topAnchor.constraint(equalTo: icon.topAnchor, constant: Sizing.verticalLabelOffset).isActive            = true
        content.widthAnchor.constraint(equalToConstant: Sizing.Timeline.contentWidth).isActive                          = true
        contentHeight.isActive                                                                                          = true
    }
    
}

//MARK: Details
extension Details {
    
    func constraints() {
        
    }
    
}

//MARK: Footer
extension Footer {
    
    func constraints() {
        blur.translatesAutoresizingMaskIntoConstraints                                                                  = false
        blur.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                  = true
        blur.topAnchor.constraint(equalTo: topAnchor).isActive                                                          = true
        blur.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                      = true
        blur.heightAnchor.constraint(equalTo: heightAnchor).isActive                                                    = true
        
        vibrancy.translatesAutoresizingMaskIntoConstraints                                                              = false
        vibrancy.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                              = true
        vibrancy.topAnchor.constraint(equalTo: topAnchor).isActive                                                      = true
        vibrancy.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                  = true
        vibrancy.heightAnchor.constraint(equalTo: heightAnchor).isActive                                                = true
        
        menu.translatesAutoresizingMaskIntoConstraints                                                                  = false
        menu.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                  = true
        menu.topAnchor.constraint(equalTo: topAnchor).isActive                                                          = true
        menu.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                      = true
        menu.heightAnchor.constraint(equalTo: heightAnchor).isActive                                                    = true
    }
    
}

//MARK: Menu
extension Menu {
    
    func constraints() {
        icon1.translatesAutoresizingMaskIntoConstraints                                                                 = false
        icon1.centerXAnchor.constraint(equalTo: label1.centerXAnchor).isActive                                          = true
        icon1.topAnchor.constraint(equalTo: topAnchor, constant: Sizing.padding/2).isActive                             = true
        icon1.widthAnchor.constraint(equalToConstant: Sizing.Menu.iconDiameter).isActive                                = true
        icon1.heightAnchor.constraint(equalToConstant: Sizing.Menu.iconDiameter).isActive                               = true
        
        label1.translatesAutoresizingMaskIntoConstraints                                                                = false
        label1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizing.padding/2).isActive                    = true
        label1.topAnchor.constraint(equalTo: icon1.bottomAnchor).isActive                                               = true
        label1.widthAnchor.constraint(equalToConstant: Sizing.Menu.textWidth).isActive                                  = true
        label1.heightAnchor.constraint(equalToConstant: Sizing.Menu.textHeight).isActive                                = true
        
        icon2.translatesAutoresizingMaskIntoConstraints                                                                 = false
        icon2.centerXAnchor.constraint(equalTo: label2.centerXAnchor).isActive                                          = true
        icon2.topAnchor.constraint(equalTo: topAnchor, constant: Sizing.padding/2).isActive                             = true
        icon2.widthAnchor.constraint(equalToConstant: Sizing.Menu.iconDiameter).isActive                                = true
        icon2.heightAnchor.constraint(equalToConstant: Sizing.Menu.iconDiameter).isActive                               = true
        
        label2.translatesAutoresizingMaskIntoConstraints                                                                = false
        label2.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                = true
        label2.topAnchor.constraint(equalTo: icon2.bottomAnchor).isActive                                               = true
        label2.widthAnchor.constraint(equalToConstant: Sizing.Menu.textWidth).isActive                                  = true
        label2.heightAnchor.constraint(equalToConstant: Sizing.Menu.textHeight).isActive                                = true
        
        icon3.translatesAutoresizingMaskIntoConstraints                                                                 = false
        icon3.centerXAnchor.constraint(equalTo: label3.centerXAnchor).isActive                                          = true
        icon3.topAnchor.constraint(equalTo: topAnchor, constant: Sizing.padding/2).isActive                             = true
        icon3.widthAnchor.constraint(equalToConstant: Sizing.Menu.iconDiameter).isActive                                = true
        icon3.heightAnchor.constraint(equalToConstant: Sizing.Menu.iconDiameter).isActive                               = true
    
        label3.translatesAutoresizingMaskIntoConstraints                                                                = false
        label3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizing.padding/2).isActive                 = true
        label3.topAnchor.constraint(equalTo: icon3.bottomAnchor).isActive                                               = true
        label3.widthAnchor.constraint(equalToConstant: Sizing.Menu.textWidth).isActive                                  = true
        label3.heightAnchor.constraint(equalToConstant: Sizing.Menu.textHeight).isActive                                = true
    }
    
}
