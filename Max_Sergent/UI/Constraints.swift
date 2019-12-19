//
//  Constraints.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/9/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    func headerConstraints() {
        header.height = header.heightAnchor.constraint(equalToConstant: UI.Sizing.Header.expandedHeight)
        header.translatesAutoresizingMaskIntoConstraints                                                            = false
        header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                  = true
        header.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UI.Sizing.statusBar.height).isActive    = true
        header.widthAnchor.constraint(equalToConstant: UI.Sizing.Header.width).isActive                             = true
        header.height.isActive                                                                                      = true
    }
    
    func scrollConstraints() {
        scroll.translatesAutoresizingMaskIntoConstraints                                                            = false
        scroll.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                  = true
        scroll.topAnchor.constraint(equalTo: header.bottomAnchor).isActive                                          = true
        scroll.widthAnchor.constraint(equalToConstant: UI.Sizing.Scroll.width).isActive                             = true
        scroll.heightAnchor.constraint(equalToConstant: UI.Sizing.Scroll.height).isActive                           = true
    }
    
}

extension Header {
    
    func nameConstraints() {
        pictureWidth = picture.widthAnchor.constraint(equalToConstant: UI.Sizing.Header.pictureDiameter)
        pictureHeight = picture.heightAnchor.constraint(equalToConstant: UI.Sizing.Header.pictureDiameter)
        nameHeight = name.heightAnchor.constraint(equalToConstant: UI.Sizing.Header.expandedNameHeight)
        
        picture.translatesAutoresizingMaskIntoConstraints                                                           = false
        picture.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                           = true
        picture.topAnchor.constraint(equalTo: topAnchor, constant: UI.Sizing.Header.pictureTopPadding).isActive     = true
        pictureWidth.isActive                                                                                       = true
        pictureHeight.isActive                                                                                      = true
        
        name.translatesAutoresizingMaskIntoConstraints                                                              = false
        name.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                              = true
        name.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UI.Sizing.Header.nameBottomPadding).isActive  = true
        name.widthAnchor.constraint(equalToConstant: UI.Sizing.Header.nameWidth).isActive                           = true
        nameHeight.isActive                                                                                         = true
    }
    
}

extension Scroll {
    
    func pageConstraints() {
        overview.translatesAutoresizingMaskIntoConstraints                                                          = false
        overview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                          = true
        overview.topAnchor.constraint(equalTo: topAnchor).isActive                                                  = true
        overview.widthAnchor.constraint(equalTo: widthAnchor).isActive                                              = true
        overview.heightAnchor.constraint(equalTo: heightAnchor).isActive                                            = true

        page1.translatesAutoresizingMaskIntoConstraints                                                             = false
        page1.leadingAnchor.constraint(equalTo: overview.trailingAnchor).isActive                                   = true
        page1.topAnchor.constraint(equalTo: topAnchor).isActive                                                     = true
        page1.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                 = true
        page1.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
        
        page2.translatesAutoresizingMaskIntoConstraints                                                             = false
        page2.leadingAnchor.constraint(equalTo: page1.trailingAnchor).isActive                                      = true
        page2.topAnchor.constraint(equalTo: topAnchor).isActive                                                     = true
        page2.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                 = true
        page2.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
        
        page3.translatesAutoresizingMaskIntoConstraints                                                             = false
        page3.leadingAnchor.constraint(equalTo: page2.trailingAnchor).isActive                                      = true
        page3.topAnchor.constraint(equalTo: topAnchor).isActive                                                     = true
        page3.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                 = true
        page3.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
    }
    
}

extension Overview {
    
    func objectiveConstraints() {
        
        objective.translatesAutoresizingMaskIntoConstraints                                                        = false
        objective.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                        = true
        objective.topAnchor.constraint(equalTo: topAnchor).isActive                                                = true
        objective.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.objectiveWidth).isActive              = true
        objective.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.objectiveHeight).isActive            = true
        
    }
    
    func originDateConstraints() {
        
        originDate.translatesAutoresizingMaskIntoConstraints                                                        = false
        originDate.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                        = true
        originDate.topAnchor.constraint(equalTo: objective.bottomAnchor, constant: UI.Sizing.Overview.padding/2).isActive = true
        originDate.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.originDateWidth).isActive                = true
        originDate.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.originDateHeight).isActive              = true
        
    }
    
    func projectConstraints() {
        let topPadding = UI.Sizing.Overview.padding/2
        side_swiftWidth = side_swiftBar.widthAnchor.constraint(equalToConstant: 5.0)
        side_pythonWidth = side_pythonBar.widthAnchor.constraint(equalToConstant: 0.0)
        side_emptyWidth = side_emptyBar.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth-5)
        
        selfProject.translatesAutoresizingMaskIntoConstraints                                                        = false
        selfProject.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                        = true
        selfProject.topAnchor.constraint(equalTo: originDate.bottomAnchor, constant: topPadding).isActive = true
        selfProject.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth).isActive                = true
        selfProject.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectHeight).isActive              = true
        
        side_swiftBar.translatesAutoresizingMaskIntoConstraints                                                          = false
        side_swiftBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Sizing.Overview.padding).isActive    = true
        side_swiftBar.topAnchor.constraint(equalTo: selfProject.bottomAnchor, constant: topPadding).isActive = true
        side_swiftWidth.isActive                = true
        side_swiftBar.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive                = true
        
        side_pythonBar.translatesAutoresizingMaskIntoConstraints                                                          = false
        side_pythonBar.leadingAnchor.constraint(equalTo: side_swiftBar.trailingAnchor).isActive    = true
        side_pythonBar.topAnchor.constraint(equalTo: selfProject.bottomAnchor, constant: topPadding).isActive = true
        side_pythonWidth.isActive                  = true
        side_pythonBar.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive                = true
        
        side_emptyBar.translatesAutoresizingMaskIntoConstraints                                                          = false
        side_emptyBar.leadingAnchor.constraint(equalTo: side_pythonBar.trailingAnchor).isActive    = true
        side_emptyBar.topAnchor.constraint(equalTo: selfProject.bottomAnchor, constant: topPadding).isActive = true
        side_emptyWidth.isActive                  = true
        side_emptyBar.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive                = true
        
        selfStats.translatesAutoresizingMaskIntoConstraints                                                          = false
        selfStats.centerXAnchor.constraint(equalTo: centerXAnchor).isActive    = true
        selfStats.topAnchor.constraint(equalTo: side_swiftBar.bottomAnchor, constant: topPadding/2).isActive = true
        selfStats.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.statWidth).isActive                  = true
        selfStats.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.statHeight).isActive                = true
        
    }
    
    func workProjectConstraints() {
        let topPadding = UI.Sizing.Overview.padding/2
        work_sqlWidth = work_sqlBar.widthAnchor.constraint(equalToConstant: 5.0)
        work_emptyWidth = work_emptyBar.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth-5)
        
        workProject.translatesAutoresizingMaskIntoConstraints                                                        = false
        workProject.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                        = true
        workProject.topAnchor.constraint(equalTo: selfStats.bottomAnchor, constant: topPadding).isActive  = true
        workProject.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth).isActive                = true
        workProject.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectHeight).isActive              = true
        
        work_sqlBar.translatesAutoresizingMaskIntoConstraints                                                          = false
        work_sqlBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Sizing.Overview.padding).isActive  = true
        work_sqlBar.topAnchor.constraint(equalTo: workProject.bottomAnchor, constant: topPadding).isActive = true
        work_sqlWidth.isActive                  = true
        work_sqlBar.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive                = true
        
        work_emptyBar.translatesAutoresizingMaskIntoConstraints                                                          = false
        work_emptyBar.leadingAnchor.constraint(equalTo: work_sqlBar.trailingAnchor).isActive    = true
        work_emptyBar.topAnchor.constraint(equalTo: workProject.bottomAnchor, constant: topPadding).isActive = true
        work_emptyWidth.isActive                  = true
        work_emptyBar.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive                = true

        workStats.translatesAutoresizingMaskIntoConstraints                                                          = false
        workStats.centerXAnchor.constraint(equalTo: centerXAnchor).isActive    = true
        workStats.topAnchor.constraint(equalTo: work_sqlBar.bottomAnchor, constant: topPadding/2).isActive = true
        workStats.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.statWidth).isActive                  = true
        workStats.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.statHeight).isActive                = true
        
    }
    
}
