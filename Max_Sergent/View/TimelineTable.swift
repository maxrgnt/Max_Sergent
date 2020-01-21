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
    var timelineRefresh = TimelineRefresh()
    var eduColor: UIColor = .black
    var expColor: UIColor = .black
    var projColor: UIColor = .black
    
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
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: Sizing.width, height: Sizing.Menu.scrollOffset))
        footer.backgroundColor = Colors.Timeline.background
        tableFooterView = footer
        
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = Colors.Timeline.background
        //refreshControl?.tintColor = .white
        //refreshControl?.attributedTitle = NSAttributedString(string: "What am I, psychic?")
        refreshControl?.addTarget(self, action: #selector(findNewJob), for: .valueChanged)
        
        refreshControl?.addSubview(timelineRefresh)
        timelineRefresh.translatesAutoresizingMaskIntoConstraints                                                        = false
        timelineRefresh.leadingAnchor.constraint(equalTo: refreshControl!.leadingAnchor).isActive                        = true
        timelineRefresh.trailingAnchor.constraint(equalTo: refreshControl!.trailingAnchor).isActive                      = true
        timelineRefresh.topAnchor.constraint(equalTo: refreshControl!.topAnchor).isActive                                = true
        timelineRefresh.bottomAnchor.constraint(equalTo: refreshControl!.bottomAnchor).isActive                          = true
        timelineRefresh.setup {
            timelineRefresh.constraints()
        }
        
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = Constants.Timeline.cellReuseId
        let cell: TimelineCell = tableView.dequeueReusableCell(withIdentifier: id) as! TimelineCell
        
        let data = Data.timelineTable[indexPath.section][Constants.Data_Key.events] as! [[String: Any]]
        
        cell.icon.image = UIImage(named: data[indexPath.row][Constants.Data_Key.iconName] as! String)
        cell.header.text = data[indexPath.row][Constants.Data_Key.organization] as? String
        cell.distinction.text = "+"+(data[indexPath.row][Constants.Data_Key.type] as? String)!
        cell.content.text  = data[indexPath.row][Constants.Data_Key.details] as? String

        let distinction = data[indexPath.row][Constants.Data_Key.type] as? String
        cell.boxHeader.backgroundColor = (Constants.Data_Key.exp.hasSuffix(distinction!))
            ? expColor : cell.boxHeader.backgroundColor
        cell.boxHeader.backgroundColor = (Constants.Data_Key.edu.hasSuffix(distinction!))
            ? eduColor : cell.boxHeader.backgroundColor
        cell.boxHeader.backgroundColor = (Constants.Data_Key.proj.hasSuffix(distinction!))
            ? projColor : cell.boxHeader.backgroundColor
        
        let maxSection = Data.timelineTable.count-1
        let events = Data.timelineTable[maxSection][Constants.Data_Key.events] as! [[String: Any]]
        let maxRow = events.count-1
        if indexPath.section == maxSection && indexPath.row == maxRow {
            cell.line.roundCorners(corners: [.bottomLeft,.bottomRight], radius: Sizing.Timeline.lineWidth/2)
        }
        else {
            cell.line.roundCorners(corners: [], radius: 0.0)
        }
        
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
        tempSection.title.text = Data.timelineTable[section][Constants.Data_Key.year] as? String
        tempSection.titleCenterY.constant = (section == 0) ? Sizing.Timeline.padding/4 : Sizing.Timeline.padding/4 // 0.0
        tempSection.resize()
        return tempSection
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let title = Data.timelineTable[section][Constants.Data_Key.year] as? String
        let heightForLabel = Fonts.calculateLabelHeight(for: title!,
                                                        withFont: Fonts.Overview.title!,
                                                        withWidth: Sizing.Overview.boxPaddedWidth,
                                                        numberOfLines: 1)
        let heightForSection = (section == 0 )
            ? heightForLabel + Sizing.Timeline.padding * (3/2)
            : heightForLabel + Sizing.Timeline.padding
        return heightForSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Data.timelineTable.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let events = Data.timelineTable[section][Constants.Data_Key.events] as! [[String: Any]]
        return events.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = Data.timelineTable[indexPath.section][Constants.Data_Key.events] as! [[String: Any]]
        let header = data[indexPath.row][Constants.Data_Key.organization] as? String
        let content = data[indexPath.row][Constants.Data_Key.details] as? String
        let heightForHeader = Fonts.calculateLabelHeight(for: header!,
                                                        withFont: Fonts.Timeline.boxHeader!,
                                                        withWidth: Sizing.Timeline.contentWidth,
                                                        numberOfLines: 1)
        let heightForContent = Fonts.calculateLabelHeight(for: content!,
                                                        withFont: Fonts.Timeline.boxContent!,
                                                        withWidth: Sizing.Timeline.contentWidth,
                                                        numberOfLines: 0)
        let heightForRow = heightForHeader + heightForContent + Sizing.Timeline.padding*2.5
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        contentOffset.x = (contentOffset.x < 0.0) ? 0.0 : contentOffset.x
    }

    @objc func findNewJob() {
        print("searching...")
        timelineRefresh.isAnimating = true
        timelineRefresh.refreshAlpha(to: 1.0)
        timelineRefresh.animateIcon(toAlpha: 1.0)
        self.perform(#selector(finishRefreshing), with: nil, afterDelay: 3.0)
    }
    
    @objc func finishRefreshing() {
        refreshControl!.endRefreshing()
        timelineRefresh.nukeAnimations()
    }
    
}


