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
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: Sizing.width, height: Sizing.Footer.height + Sizing.padding/2))
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
        
        cell.icon.image = UIImage(named: data[indexPath.section].boxes[indexPath.row].icon)
        cell.header.text = data[indexPath.section].boxes[indexPath.row].header
        cell.distinction.text = data[indexPath.section].boxes[indexPath.row].distinction
        cell.content.text  = data[indexPath.section].boxes[indexPath.row].content
        
        cell.backgroundColor = .blue
        
        let distinction = data[indexPath.section].boxes[indexPath.row].distinction
        cell.distinction.backgroundColor = (distinction == "experience") ? .blue : cell.distinction.backgroundColor
        cell.distinction.backgroundColor = (distinction == "education") ? .brown : cell.distinction.backgroundColor
        cell.distinction.backgroundColor = (distinction == "project") ? .red : cell.distinction.backgroundColor
        
        if indexPath.section == data.count-1 && indexPath.row == data[indexPath.section].boxes.count-1 {
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
        tempSection.title.text = data[section].title
        tempSection.titleCenterY.constant = (section == 0) ? Sizing.padding/4 : 0.0
        tempSection.resize()
        return tempSection
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let title = data[section].title
        let heightForLabel = Fonts.calculateLabelHeight(for: title,
                                                        withFont: Fonts.Overview.title!,
                                                        withWidth: Sizing.Overview.boxPaddedWidth,
                                                        numberOfLines: 1)
        let heightForSection = (section == 0 )
            ? heightForLabel + Sizing.padding * (3/2)
            : heightForLabel + Sizing.padding
        return heightForSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].boxes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let header = data[indexPath.section].boxes[indexPath.row].header
        let distinction = data[indexPath.section].boxes[indexPath.row].distinction
        let content = data[indexPath.section].boxes[indexPath.row].content
        let heightForHeader = Fonts.calculateLabelHeight(for: header,
                                                        withFont: Fonts.Timeline.boxHeader!,
                                                        withWidth: Sizing.Timeline.contentWidth,
                                                        numberOfLines: 1)
        let heightForDistinction = Fonts.calculateLabelHeight(for: distinction,
                                                        withFont: Fonts.Timeline.boxDistinction!,
                                                        withWidth: Sizing.Timeline.contentWidth,
                                                        numberOfLines: 1)
        let heightForContent = Fonts.calculateLabelHeight(for: content,
                                                        withFont: Fonts.Timeline.boxContent!,
                                                        withWidth: Sizing.Timeline.contentWidth,
                                                        numberOfLines: 0)
        let heightForRow = heightForHeader + heightForDistinction + heightForContent + Sizing.Timeline.vert.iconTop + Sizing.Timeline.vert.distinctionTop + Sizing.Timeline.vert.contentTop + Sizing.Timeline.vert.contentBottom + Sizing.Timeline.vert.boxTop
        
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


