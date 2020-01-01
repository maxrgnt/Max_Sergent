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
    
    func menuConstraints() {
        menu.translatesAutoresizingMaskIntoConstraints                                                            = false
        menu.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                  = true
        menu.topAnchor.constraint(equalTo: header.bottomAnchor).isActive                                          = true
        menu.widthAnchor.constraint(equalToConstant: UI.Sizing.Menu.width).isActive                             = true
        menu.heightAnchor.constraint(equalToConstant: UI.Sizing.Menu.height).isActive                           = true
    }
    
    func scrollConstraints() {
        scroll.translatesAutoresizingMaskIntoConstraints                                                            = false
        scroll.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                  = true
        scroll.topAnchor.constraint(equalTo: menu.bottomAnchor).isActive                                          = true
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

extension Menu {
    
    func page1Constraints() {
        page1_width = page1.widthAnchor.constraint(equalToConstant: UI.Sizing.Menu.barWidth/4)
        page2_width = page2.widthAnchor.constraint(equalToConstant: UI.Sizing.Menu.barWidth/4)
        page3_width = page3.widthAnchor.constraint(equalToConstant: UI.Sizing.Menu.barWidth/4)
        page4_width = page4.widthAnchor.constraint(equalToConstant: UI.Sizing.Menu.barWidth/4)
        page5_width = page5.widthAnchor.constraint(equalToConstant: UI.Sizing.Menu.barWidth/4)
        
        page1.translatesAutoresizingMaskIntoConstraints                                                          = false
        page1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UI.Sizing.Menu.padding).isActive           = true
        page1.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        page1_width.isActive                                                                                     = true
        page1.heightAnchor.constraint(equalTo: heightAnchor).isActive                                    = true
        
        page2.translatesAutoresizingMaskIntoConstraints                                                          = false
        page2.leadingAnchor.constraint(equalTo: page1.trailingAnchor).isActive                          = true
        page2.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        page2_width.isActive                                                                                     = true
        page2.heightAnchor.constraint(equalTo: heightAnchor).isActive                                      = true
        
        page3.translatesAutoresizingMaskIntoConstraints                                                          = false
        page3.leadingAnchor.constraint(equalTo: page2.trailingAnchor).isActive                          = true
        page3.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        page3_width.isActive                                                                                     = true
        page3.heightAnchor.constraint(equalTo: heightAnchor).isActive                                      = true
        
        page4.translatesAutoresizingMaskIntoConstraints                                                          = false
        page4.leadingAnchor.constraint(equalTo: page3.trailingAnchor).isActive                          = true
        page4.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        page4_width.isActive                                                                                     = true
        page4.heightAnchor.constraint(equalTo: heightAnchor).isActive                                      = true
        
        page5.translatesAutoresizingMaskIntoConstraints                                                          = false
        page5.leadingAnchor.constraint(equalTo: page4.trailingAnchor).isActive                          = true
        page5.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        page5_width.isActive                                                                                     = true
        page5.heightAnchor.constraint(equalTo: heightAnchor).isActive                                      = true
    }
    
}

extension Scroll {
    
    func pageConstraints() {
        overview.translatesAutoresizingMaskIntoConstraints                                                          = false
        overview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                          = true
        overview.topAnchor.constraint(equalTo: topAnchor).isActive                                                  = true
        overview.widthAnchor.constraint(equalTo: widthAnchor).isActive                                              = true
        overview.heightAnchor.constraint(equalTo: heightAnchor).isActive                                            = true

        work.translatesAutoresizingMaskIntoConstraints                                                        = false
        work.leadingAnchor.constraint(equalTo: overview.trailingAnchor).isActive                              = true
        work.topAnchor.constraint(equalTo: topAnchor).isActive                                                = true
        work.widthAnchor.constraint(equalTo: widthAnchor).isActive                                            = true
        work.heightAnchor.constraint(equalTo: heightAnchor).isActive                                          = true
        
        page3.translatesAutoresizingMaskIntoConstraints                                                             = false
        page3.leadingAnchor.constraint(equalTo: work.trailingAnchor).isActive                                   = true
        page3.topAnchor.constraint(equalTo: topAnchor).isActive                                                     = true
        page3.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                 = true
        page3.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
        
        page4.translatesAutoresizingMaskIntoConstraints                                                             = false
        page4.leadingAnchor.constraint(equalTo: page3.trailingAnchor).isActive                                      = true
        page4.topAnchor.constraint(equalTo: topAnchor).isActive                                                     = true
        page4.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                 = true
        page4.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
        
        page5.translatesAutoresizingMaskIntoConstraints                                                             = false
        page5.leadingAnchor.constraint(equalTo: page4.trailingAnchor).isActive                                   = true
        page5.topAnchor.constraint(equalTo: topAnchor).isActive                                                     = true
        page5.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                 = true
        page5.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
        
    }
    
}

extension Overview {
    
    func objectiveConstraints() {
        objective.translatesAutoresizingMaskIntoConstraints                                                         = false
        objective.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                         = true
        objective.topAnchor.constraint(equalTo: topAnchor).isActive                                                 = true
        objective.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.objectiveWidth).isActive               = true
        objective.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.objectiveHeight).isActive             = true
    }
    
    func originDateConstraints() {
        let topPadding = UI.Sizing.Overview.topPadding
        originDate.translatesAutoresizingMaskIntoConstraints                                                        = false
        originDate.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                        = true
        originDate.topAnchor.constraint(equalTo: objective.bottomAnchor, constant: topPadding).isActive             = true
        originDate.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.originDateWidth).isActive             = true
        originDate.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.originDateHeight).isActive           = true
    }
    
    func projectConstraints() {
        let topPadding = UI.Sizing.Overview.topPadding
        let padding = UI.Sizing.Overview.padding
        
        personalProject.translatesAutoresizingMaskIntoConstraints                                                       = false
        personalProject.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                       = true
        personalProject.topAnchor.constraint(equalTo: originDate.bottomAnchor, constant: topPadding).isActive           = true
        personalProject.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth).isActive               = true
        personalProject.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectHeight).isActive             = true
        
        personalBar.translatesAutoresizingMaskIntoConstraints                                                       = false
        personalBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive                    = true
        personalBar.topAnchor.constraint(equalTo: personalProject.bottomAnchor, constant: topPadding).isActive          = true
        personalBar.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth).isActive               = true
        personalBar.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive                 = true
        
        personalStats.translatesAutoresizingMaskIntoConstraints                                                         = false
        personalStats.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                         = true
        personalStats.topAnchor.constraint(equalTo: personalBar.bottomAnchor, constant: topPadding/2).isActive        = true
        personalStats.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.statWidth).isActive                    = true
        personalStats.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.statHeight).isActive                  = true
        
    }
    
    func workProjectConstraints() {
        let topPadding = UI.Sizing.Overview.topPadding
        let padding = UI.Sizing.Overview.padding
        
        workProject.translatesAutoresizingMaskIntoConstraints                                                       = false
        workProject.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                       = true
        workProject.topAnchor.constraint(equalTo: personalStats.bottomAnchor, constant: topPadding).isActive            = true
        workProject.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth).isActive               = true
        workProject.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectHeight).isActive             = true
        
        workBar.translatesAutoresizingMaskIntoConstraints                                                       = false
        workBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive                    = true
        workBar.topAnchor.constraint(equalTo: workProject.bottomAnchor, constant: topPadding).isActive          = true
        workBar.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth).isActive               = true
        workBar.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive                 = true

        workStats.translatesAutoresizingMaskIntoConstraints                                                         = false
        workStats.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                         = true
        workStats.topAnchor.constraint(equalTo: workBar.bottomAnchor, constant: topPadding/2).isActive          = true
        workStats.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.statWidth).isActive                    = true
        workStats.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.statHeight).isActive                  = true
        
    }
    
}

extension Work {
    func tableConstraints() {
        let topPadding = UI.Sizing.Overview.topPadding
        
        table.translatesAutoresizingMaskIntoConstraints                                                             = false
        table.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                             = true
        table.topAnchor.constraint(equalTo: topAnchor, constant: topPadding/2).isActive                   = true
        table.widthAnchor.constraint(equalToConstant: UI.Sizing.Experience.paddedWidth).isActive                    = true
        table.heightAnchor.constraint(equalToConstant: UI.Sizing.Experience.tableHeight).isActive                   = true
    }
}

extension WorkSection {
    
    func companyConstraints() {
        company.translatesAutoresizingMaskIntoConstraints                                                          = false
        company.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                          = true
        company.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                              = true
        company.widthAnchor.constraint(equalToConstant: UI.Sizing.Experience.paddedWidth).isActive                 = true
        company.heightAnchor.constraint(equalTo: heightAnchor).isActive                                            = true
    }
    
}

extension WorkCell {
        
    func positionConstraints() {
        positionHeight = position.heightAnchor.constraint(equalToConstant: UI.Sizing.Experience.positionHeight)
        
        position.translatesAutoresizingMaskIntoConstraints                                                          = false
        position.leadingAnchor.constraint(equalTo: leadingAnchor).isActive                                          = true
        position.topAnchor.constraint(equalTo: topAnchor).isActive                                                  = true
        position.widthAnchor.constraint(equalToConstant: UI.Sizing.Experience.positionWidth).isActive                 = true
        positionHeight.isActive                                                                                     = true
    }

    func startDateConstraints() {
        startDateHeight = startDate.heightAnchor.constraint(equalToConstant: UI.Sizing.Experience.startDateHeight)
        
        startDate.translatesAutoresizingMaskIntoConstraints                                                          = false
        startDate.trailingAnchor.constraint(equalTo: trailingAnchor).isActive                                          = true
        startDate.topAnchor.constraint(equalTo: topAnchor).isActive                                                  = true
        startDate.widthAnchor.constraint(equalToConstant: UI.Sizing.Experience.startDateWidth).isActive                 = true
        startDateHeight.isActive                                                                                     = true
    }
    
    func workCompletedConstraints() {
        workCompletedHeight = workCompleted.heightAnchor.constraint(equalToConstant: UI.Sizing.Experience.workCompletedHeight)
        
        workCompleted.translatesAutoresizingMaskIntoConstraints                                                          = false
        workCompleted.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                          = true
        workCompleted.topAnchor.constraint(equalTo: position.bottomAnchor).isActive                                      = true
        workCompleted.widthAnchor.constraint(equalToConstant: UI.Sizing.Experience.paddedWidth).isActive                 = true
        workCompletedHeight.isActive                                                                                     = true
    }
    
}
