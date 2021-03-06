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
    var lineColor:              UIColor!
    var sectionBackgroundColor: UIColor!
    var titleTextColor:         UIColor!
    var contentTextColor:       UIColor!
    var boxColor:               UIColor!
    var eduColor:               UIColor!
    var expColor:               UIColor!
    var projColor:              UIColor!
    
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
        footer.backgroundColor = .clear
        tableFooterView = footer
        
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = .clear
        refreshControl?.tintColor = .clear
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
        
        let data = dataForRow(inSection: indexPath.section)
        
        guard let dir = try?
            FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else
        {
            return cell
        }
        let iconName = data[indexPath.row][Constants.Data_Key.iconName] as! String
        let urlFromCoreData = URL(fileURLWithPath: dir.absoluteString).appendingPathComponent("\(iconName).png")
        let photo = UIImage(contentsOfFile: urlFromCoreData.path)!
        let scaledPhoto = resizeImage(image: photo, newHeight: Sizing.Timeline.iconDiameter)
        
        cell.icon.image = scaledPhoto
        cell.header.text = data[indexPath.row][Constants.Data_Key.organization] as? String
        cell.distinction.text = data[indexPath.row][Constants.Data_Key.type] as? String
        cell.content.text  = data[indexPath.row][Constants.Data_Key.details] as? String
         
        cell.content.textColor     = contentTextColor
        cell.distinction.textColor = titleTextColor
        cell.header.textColor      = titleTextColor
        cell.box.backgroundColor   = boxColor
        cell.line.backgroundColor  = lineColor
        
        let distinction = data[indexPath.row][Constants.Data_Key.type] as? String
        cell.boxHeader.backgroundColor = (Constants.Data_Key.experience.hasSuffix(distinction!))
            ? expColor : cell.boxHeader.backgroundColor
        cell.boxHeader.backgroundColor = (Constants.Data_Key.education.hasSuffix(distinction!))
            ? eduColor : cell.boxHeader.backgroundColor
        cell.boxHeader.backgroundColor = (Constants.Data_Key.project.hasSuffix(distinction!))
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
        tempSection.backgroundColor         = sectionBackgroundColor
        tempSection.node.backgroundColor    = lineColor
        tempSection.line.backgroundColor    = lineColor
        tempSection.title.textColor         = titleTextColor
        tempSection.title.text = Data.timelineTable[section][Constants.Data_Key.year] as? String
        tempSection.titleCenterY.constant = (section == 0) ? Sizing.Timeline.padding/4 : 0.0
        tempSection.resize()
        return tempSection
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let title = Data.timelineTable[section][Constants.Data_Key.year] as? String
        let heightForLabel = Fonts.calculateLabelHeight(for: title!,
                                                        withFont: Fonts.Timeline.title!,
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
    
    func dataForRow(inSection section: Int) -> [[String: Any]] {
        return Data.timelineTable[section][Constants.Data_Key.events] as! [[String: Any]]
    }
    
    
//    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage {
//        let scale = newHeight / image.size.height
//        let newWidth = image.size.width * scale
//        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
//        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
//    }
    
    func resizeImage(image: UIImage, newHeight: CGFloat) -> (UIImage) {

       let newRect = CGRect(x: 0, y: 0, width: newHeight, height: newHeight).integral
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newHeight, height: newHeight), false, 0)
       let context = UIGraphicsGetCurrentContext()

       // Set the quality level to use when rescaling
       context!.interpolationQuality = CGInterpolationQuality.default
       let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newHeight)

       context!.concatenate(flipVertical)
       // Draw into the context; this scales the image
       context?.draw(image.cgImage!, in: CGRect(x: 0.0,y: 0.0, width: newRect.width, height: newRect.height))

       let newImageRef = context!.makeImage()! as CGImage
       let newImage = UIImage(cgImage: newImageRef)

       // Get the resized image from the context and a UIImage
       UIGraphicsEndImageContext()

       return newImage
    }
    
}


