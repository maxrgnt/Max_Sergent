//
//  Overview2.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/14/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

protocol OverviewDelegate {
    func openMaps()
    func sendEmail()
    func openLinkedIn()
}

class OverviewTable: UITableView, UITableViewDelegate, UITableViewDataSource {
        
    //MARK: Definitions
    // Delegates
    var customDelegate: OverviewDelegate!
    // Constraints
    // Objects
    var titleTextColor:     UIColor!
    var contentTextColor:   UIColor!
    var boxBackgroundColor: UIColor!
    
    //MARK: - Initialization
    override init (frame: CGRect, style: UITableView.Style) {
        // Initialize views frame prior to setting constraints
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup
    func setup() {
        
        register(OverviewCell.self, forCellReuseIdentifier: Constants.Overview.cellReuseId)
        delegate                        = self
        dataSource                      = self
        tableHeaderView                 = nil
        separatorStyle                  = .none
        alwaysBounceHorizontal          = false
        alwaysBounceVertical            = false
        showsVerticalScrollIndicator    = false
        showsHorizontalScrollIndicator  = false
        
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = Constants.Overview.cellReuseId
        let cell: OverviewCell = tableView.dequeueReusableCell(withIdentifier: id) as! OverviewCell
    
        cell.box.backgroundColor = boxBackgroundColor
        cell.setIcon(withName: Data.overviewTable[indexPath.section].boxes[indexPath.row].icon)
        cell.content.text  = Data.overviewTable[indexPath.section].boxes[indexPath.row].content
        cell.content.textColor = contentTextColor
        
        cell.resize(forIndex: indexPath.row)
        
        return cell
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let indexTitles: [String]? = []
        return indexTitles
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tempSection = OverviewSection()
        tempSection.setup() {
            tempSection.constraints()
        }
        tempSection.title.textColor = titleTextColor
        tempSection.title.text = Data.overviewTable[section].title
        tempSection.titleCenterY.constant = (section == 0) ? Sizing.Overview.padding/2 : 0.0
        tempSection.resize()
        
        return tempSection
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let title = Data.overviewTable[section].title
        let heightForLabel = Fonts.calculateLabelHeight(for: title,
                                                        withFont: Fonts.Overview.title!,
                                                        withWidth: Sizing.Overview.boxPaddedWidth,
                                                        numberOfLines: 1)
        
        let heightForSection = (section == 0)
            ? heightForLabel + Sizing.Overview.padding
            : heightForLabel
        return heightForSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Data.overviewTable.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.overviewTable[section].boxes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let content = Data.overviewTable[indexPath.section].boxes[indexPath.row].content
        let heightForLabel = Fonts.calculateLabelHeight(for: content,
                                                        withFont: Fonts.Overview.content!,
                                                        withWidth: Sizing.Overview.boxPaddedWidth,
                                                        numberOfLines: 0)
        let multiplier: CGFloat = (indexPath.row == 0) ? 2.0 : 1.5
        let heightForRow = heightForLabel + (Sizing.Overview.padding * multiplier)
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            indexPath.row == 0 ? self.customDelegate.openMaps() : nil
            indexPath.row == 1 ? self.customDelegate.sendEmail() : nil
            indexPath.row == 2 ? self.customDelegate.openLinkedIn() : nil
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

