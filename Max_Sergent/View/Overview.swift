//
//  Overview.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/16/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Overview: UIView {
    
    //MARK: Definitions
    // Constraints
    var personal_swiftWidth:   NSLayoutConstraint!
    var personal_pythonWidth:   NSLayoutConstraint!
    var personal_emptyWidth:   NSLayoutConstraint!
    var work_sqlWidth:   NSLayoutConstraint!
    var work_emptyWidth:   NSLayoutConstraint!
    // Objects
    let objective = UILabel()
    let originDate = UILabel()
    let personalProject = UILabel()
    let personalStats = UILabel()
    let personal_swiftBar = UIView()
    let personal_pythonBar = UIView()
    let personal_emptyBar = UIView()
    let workProject = UILabel()
    let workStats = UILabel()
    let work_sqlBar = UIView()
    let work_emptyBar = UIView()
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = UI.Colors.Overview.background
        objectSettings()
        constraints()
    }
    
    func objectSettings() {
        addSubview(objective)
        objective.numberOfLines = 7
        objective.textAlignment = .left
        objective.backgroundColor = .clear
        objective.minimumScaleFactor = 0.1
        objective.lineBreakMode = .byClipping
        objective.adjustsFontSizeToFitWidth = true
        objective.font = UI.Fonts.Overview.objective
        objective.text = Constants.Overview.objective
        objective.textColor = UI.Colors.Overview.objective
        
        addSubview(originDate)
        originDate.numberOfLines = 1
        originDate.textAlignment = .left
        originDate.backgroundColor = .clear
        originDate.minimumScaleFactor = 0.1
        originDate.lineBreakMode = .byClipping
        originDate.adjustsFontSizeToFitWidth = true
        originDate.textColor = UI.Colors.Overview.originDate
        let largeFont = UI.Fonts.Overview.originDateMain
        let superScriptFont = UI.Fonts.Overview.originDateSuper
        let attrString = NSMutableAttributedString(string: "Since Jan 1", attributes: [.font: largeFont!])
        attrString.append(NSAttributedString(string: "st", attributes: [.font: superScriptFont!, .baselineOffset: 10]))
        attrString.append(NSAttributedString(string: " 2019", attributes: [.font: largeFont!]))
        originDate.attributedText = attrString
        
        var text = [Constants.Overview.selfProject, Constants.Overview.workProject]
        for (i, project) in [personalProject,workProject].enumerated() {
            addSubview(project)
            project.numberOfLines = 1
            project.textAlignment = .left
            project.backgroundColor = .clear
            project.minimumScaleFactor = 0.1
            project.lineBreakMode = .byClipping
            project.adjustsFontSizeToFitWidth = true
            project.font = UI.Fonts.Overview.project
            project.text = text[i]
            project.textColor = UI.Colors.Overview.project
        }
        
        text = [Constants.Overview.selfStats, Constants.Overview.workStats]
        for (i, label) in [personalStats,workStats].enumerated() {
            addSubview(label)
            label.numberOfLines = 1
            label.textAlignment = .left
            label.backgroundColor = .clear
            label.minimumScaleFactor = 0.1
            label.lineBreakMode = .byClipping
            label.adjustsFontSizeToFitWidth = true
            label.font = UI.Fonts.Overview.stat
            label.text = text[i]
            label.textColor = UI.Colors.Overview.stat
        }
        
        let colors: [UIColor] = [.lightGray, .white, .black, .lightGray, .black]
        for (i, bar) in [personal_swiftBar, personal_pythonBar, personal_emptyBar, work_sqlBar, work_emptyBar].enumerated() {
            addSubview(bar)
            bar.backgroundColor = colors[i]
        }
        personal_swiftBar.roundCorners(corners: [.topLeft,.bottomLeft], radius: UI.Sizing.Overview.barRadius)
        personal_emptyBar.roundCorners(corners: [.topRight,.bottomRight], radius: UI.Sizing.Overview.barRadius)
        work_sqlBar.roundCorners(corners: [.topLeft,.bottomLeft], radius: UI.Sizing.Overview.barRadius)
        work_emptyBar.roundCorners(corners: [.topRight,.bottomRight], radius: UI.Sizing.Overview.barRadius)
    }
    
    func constraints() {
        objectiveConstraints()
        originDateConstraints()
        projectConstraints()
        workProjectConstraints()
    }
    
}
