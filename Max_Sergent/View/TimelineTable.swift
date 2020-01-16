//
//  TimelineTable.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/15/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

protocol TimelineDelegate {
    func openMaps()
    func sendEmail()
    func openLinkedIn()
}

class TimelineTable: UITableView, UITableViewDelegate, UITableViewDataSource {
        
    //MARK: Definitions
    // Delegates
    var customDelegate: OverviewDelegate!
    // Constraints
    // Objects
    let data = Constants.Timeline.clusters
    
    //MARK: - Initialization
    override init (frame: CGRect, style: UITableView.Style) {
        // Initialize views frame prior to setting constraints
        super.init(frame: frame, style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup
    func setup() {
    
        register(TimelineCell.self, forCellReuseIdentifier: Constants.Timeline.cellReuseId)
        delegate                        = self
        dataSource                      = self
        tableHeaderView                 = nil
        
        separatorStyle                  = .none
        alwaysBounceHorizontal          = false
        alwaysBounceVertical            = true
        showsVerticalScrollIndicator    = false
        showsHorizontalScrollIndicator  = false
        
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = Constants.Timeline.cellReuseId
        let cell: TimelineCell = tableView.dequeueReusableCell(withIdentifier: id) as! TimelineCell
        
        cell.setup() {
            cell.constraints()
        }
        
        cell.setIcon(withName: data[indexPath.section].boxes[indexPath.row].icon)
        cell.content.text  = data[indexPath.section].boxes[indexPath.row].content
        
        cell.resize(forIndex: indexPath.row)
        
        return cell
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let indexTitles: [String]? = []
        return indexTitles
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tempSection = TimelineSection()
        tempSection.setup() {
            tempSection.constraints()
        }
        tempSection.title.text = data[section].title
        tempSection.resize()
        return tempSection
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let title = data[section].title
        let heightForLabel = Fonts.calculateLabelHeight(for: title,
                                                        withFont: Fonts.Overview.title!,
                                                        withWidth: Sizing.Overview.boxPaddedWidth,
                                                        numberOfLines: 1)
        let heightForSection = heightForLabel + Sizing.Overview.padding
        return heightForSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].boxes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let content = data[indexPath.section].boxes[indexPath.row].content
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
