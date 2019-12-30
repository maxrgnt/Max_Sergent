//
//  ExperienceTable.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/23/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

protocol ExperienceTableDelegate {
    
}

class ExperienceTable: UITableView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
        
    //MARK: Definitions
    // Delegate object
    var customDelegate : ExperienceTableDelegate!
    // Variables
    
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
        backgroundColor = .clear //UI.Color.alculatePurpleLite
        register(ExperienceCell.self, forCellReuseIdentifier: Constants.Experience.cellReuseId)
        delegate                     = self
        dataSource                   = self
        tableHeaderView              = nil
        separatorStyle               = .none
        alwaysBounceHorizontal       = false
        showsVerticalScrollIndicator = false
        //sectionIndexColor            = UI.Color.Font.standard
        //sectionIndexBackgroundColor  = UIColor.clear
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = Constants.Experience.cellReuseId
        let cell: ExperienceCell = tableView.dequeueReusableCell(withIdentifier: id) as! ExperienceCell
        
        if  let company = Data.work[Data.companyKeys[indexPath.section]] as? [String: AnyObject],
            let positions = company[Constants.Data.Work.positions] as? [String: AnyObject]
        {
            let positionKeys = Array(positions.keys).sorted()
            if  let position = positions[positionKeys[indexPath.row]] as? [String: AnyObject],
                let title = position[Constants.Data.Work.title] as? String,
                let startDate = position[Constants.Data.Work.startDate] as? String,
                let workCompleted = position[Constants.Data.Work.workCompleted] as? String
            {
                cell.position.text = "\(title) | \(startDate)"
                cell.accomplishments.text = workCompleted
                
                let x = heightForLabel(text: "\(title) | \(startDate)", font: UI.Fonts.Experience.cellBody!, width: UI.Sizing.widthObjectPadding)
                cell.positionHeight.constant = x
                
                let y = heightForLabel(text: workCompleted, font: UI.Fonts.Experience.cellBody!, width: UI.Sizing.widthObjectPadding)
                cell.accomplishmentsHeight.constant = y
            }
        }

        return cell
    }
    
    func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    
        
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let indexTitles: [String]? = []
        return indexTitles
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionVar = ExperienceSection()
        sectionVar.setup()
        if  let company = Data.work[Data.companyKeys[section]] as? [String: AnyObject],
            let name = company[Constants.Data.Work.company] as? String
        {
            sectionVar.company.text = name
        }
        return sectionVar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UI.Sizing.Experience.sectionHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Data.work.keys.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if  let jobs = Data.work[Data.companyKeys[section]] as? [String: AnyObject],
            let positions = jobs[Constants.Data.Work.positions]?.count {
            rows = positions
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        
        if  let company = Data.work[Data.companyKeys[indexPath.section]] as? [String: AnyObject],
            let positions = company[Constants.Data.Work.positions] as? [String: AnyObject]
        {
            let positionKeys = Array(positions.keys).sorted()
            if  let position = positions[positionKeys[indexPath.row]] as? [String: AnyObject],
                let title = position[Constants.Data.Work.title] as? String,
                let startDate = position[Constants.Data.Work.startDate] as? String,
                let workCompleted = position[Constants.Data.Work.workCompleted] as? String
            {
                x = heightForLabel(text: "\(title) | \(startDate)", font: UI.Fonts.Experience.cellBody!, width: UI.Sizing.widthObjectPadding)
                y = heightForLabel(text: workCompleted, font: UI.Fonts.Experience.cellBody!, width: UI.Sizing.widthObjectPadding)
            }
        }
        
        return x + y
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let DeleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, success) in
//            // pass
//        })
//        DeleteAction.backgroundColor = .red // UI.Color.begonia
//        return UISwipeActionsConfiguration(actions: [DeleteAction])
//    }
 
    //MARK: Functions
    func scrollToFirstRow() {
        let indexPath = NSIndexPath(row: 0, section: 0)
        self.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
    }
    
    // MARK: - ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset.y = 0
        }
        if scrollView.contentOffset.y > 0 {

        }
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        // pass
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // pass
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // pass
    }

}

