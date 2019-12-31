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
    var work_sqlWidth:   NSLayoutConstraint!
    var work_emptyWidth:   NSLayoutConstraint!
    // Objects
    let objective = UILabel()
    let originDate = UILabel()
    let personalProject = UILabel()
    let personalBar = UIView()
    let personalStats = UILabel()
    let workProject = UILabel()
    let workBar = UIView()
    let workStats = UILabel()
    
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
        
        for bar in [personalBar, workBar] {
            addSubview(bar)
            bar.backgroundColor = UI.Colors.Overview.barBackground
            bar.roundCorners(corners: [.topLeft, .bottomLeft, .topRight, .bottomRight], radius: UI.Sizing.Overview.barRadius)
        }
    }
    
    func constraints() {
        objectiveConstraints()
        originDateConstraints()
        projectConstraints()
        workProjectConstraints()
    }
    
    func buildProjectBar(for projects: [String: AnyObject], since totalDays: Int, anchoredTo anchor: UIView, withTag tagToRemove: Int) {
        
        let remove = anchor.subviews.filter { ($0 as UIView).tag == tagToRemove } as [UIView]
        print("Remove: \(remove.count) subviews from overview.bar")
        remove.forEach { subview in
            subview.removeFromSuperview()
        }
        
        // Get key for each specific language
        var projectBars: [(language: String, days: Int)] = []
        let projectKeys = Array(projects.keys).sorted()
        var projectDays = 0
        projectKeys.forEach { projectKey in
            if  let project = projects[projectKey] as? [String: AnyObject],
                let language = project[Constants.Data.Overview.language] as? String,
                let days = Int((project[Constants.Data.Overview.days] as? String)!)
            {
                let daysToAppend = (days > totalDays-projectDays) ? totalDays-projectDays : days
                projectBars.append((language: language, days: daysToAppend))
                projectDays += daysToAppend
            }
            else {
                print("Error: buildingProjectBar for can't break down projects parameter")
            }
        }
        
        // projectBars
        // [(language: "Swift", days: 42), (language: "Python", days: 42)]
        
        let colors: [UIColor] = [.blue, .green]
        var padding: CGFloat = 0.0 + UI.Sizing.Overview.padding
        
        for (i, bar) in projectBars.enumerated() {
            let tempView = UIView()
            anchor.addSubview(tempView)
            tempView.backgroundColor = colors[i]
            
            i == 0 ? tempView.roundCorners(corners: [.topLeft, .bottomLeft], radius: UI.Sizing.Overview.barRadius) : nil
            
            let width = UI.Sizing.Overview.projectWidth * (CGFloat(bar.days)/CGFloat(totalDays))
            padding += (i > 0)
                ? UI.Sizing.Overview.projectWidth * (CGFloat(projectBars[i-1].days)/CGFloat(totalDays))
                : 0.0
            
            tempView.tag = tagToRemove
            tempView.translatesAutoresizingMaskIntoConstraints                                                     = false
            tempView.widthAnchor.constraint(equalToConstant: width).isActive                                       = true
            tempView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive                  = true
            tempView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                     = true
            tempView.heightAnchor.constraint(equalTo: heightAnchor).isActive                                       = true
            
        }
    }
    
}
