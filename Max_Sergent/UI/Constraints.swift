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
    
    func projectConstraints() {
        
        selfProject.translatesAutoresizingMaskIntoConstraints                                                        = false
        selfProject.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                        = true
        selfProject.topAnchor.constraint(equalTo: objective.bottomAnchor, constant: UI.Sizing.Overview.padding/2).isActive = true
        selfProject.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth).isActive                = true
        selfProject.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectHeight).isActive              = true
        
        swiftDays.translatesAutoresizingMaskIntoConstraints                                                          = false
        swiftDays.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Sizing.Overview.padding/2).isActive    = true
        swiftDays.topAnchor.constraint(equalTo: selfProject.bottomAnchor, constant: UI.Sizing.Overview.padding/2).isActive = true
        swiftDays.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth/3).isActive                  = true
        swiftDays.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive                = true
        
        pythonDays.translatesAutoresizingMaskIntoConstraints                                                          = false
        pythonDays.leadingAnchor.constraint(equalTo: swiftDays.trailingAnchor).isActive    = true
        pythonDays.topAnchor.constraint(equalTo: selfProject.bottomAnchor, constant: UI.Sizing.Overview.padding/2).isActive = true
        pythonDays.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth/3).isActive                  = true
        pythonDays.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive                = true
        
        emptySelf.translatesAutoresizingMaskIntoConstraints                                                          = false
        emptySelf.leadingAnchor.constraint(equalTo: pythonDays.trailingAnchor).isActive    = true
        emptySelf.topAnchor.constraint(equalTo: selfProject.bottomAnchor, constant: UI.Sizing.Overview.padding/2).isActive = true
        emptySelf.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth/3).isActive                  = true
        emptySelf.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive                = true
        
        selfStats.translatesAutoresizingMaskIntoConstraints                                                          = false
        selfStats.centerXAnchor.constraint(equalTo: centerXAnchor).isActive    = true
        selfStats.topAnchor.constraint(equalTo: swiftDays.bottomAnchor).isActive = true
        selfStats.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.statWidth).isActive                  = true
        selfStats.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.statHeight).isActive                = true
        
    }
    
    func workProjectConstraints() {
        
        workProject.translatesAutoresizingMaskIntoConstraints                                                        = false
        workProject.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                        = true
        workProject.topAnchor.constraint(equalTo: selfStats.bottomAnchor, constant: UI.Sizing.Overview.padding/2).isActive  = true
        workProject.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth).isActive                = true
        workProject.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectHeight).isActive              = true
        
        sqlDays.translatesAutoresizingMaskIntoConstraints                                                          = false
        sqlDays.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Sizing.Overview.padding/2).isActive  = true
        sqlDays.topAnchor.constraint(equalTo: workProject.bottomAnchor, constant: UI.Sizing.Overview.padding/2).isActive = true
        sqlDays.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth/2).isActive                  = true
        sqlDays.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive                = true
        
        emptyWork.translatesAutoresizingMaskIntoConstraints                                                          = false
        emptyWork.leadingAnchor.constraint(equalTo: sqlDays.trailingAnchor).isActive    = true
        emptyWork.topAnchor.constraint(equalTo: workProject.bottomAnchor, constant: UI.Sizing.Overview.padding/2).isActive = true
        emptyWork.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth/2).isActive                  = true
        emptyWork.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive                = true

        workStats.translatesAutoresizingMaskIntoConstraints                                                          = false
        workStats.centerXAnchor.constraint(equalTo: centerXAnchor).isActive    = true
        workStats.topAnchor.constraint(equalTo: sqlDays.bottomAnchor).isActive = true
        workStats.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.statWidth).isActive                  = true
        workStats.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.statHeight).isActive                = true
        
    }
    
}
