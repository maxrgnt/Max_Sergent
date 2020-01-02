//
//  WorkTable.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/23/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

protocol SchoolTableDelegate {
    
}

class SchoolTable: UITableView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
        
    //MARK: Definitions
    // Delegate object
    var customDelegate : SchoolTableDelegate!
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
        register(SchoolCell.self, forCellReuseIdentifier: Constants.School.cellReuseId)
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
        let id = Constants.School.cellReuseId
        let cell: SchoolCell = tableView.dequeueReusableCell(withIdentifier: id) as! SchoolCell
        
        if  let school = Data.school[Data.schoolNameKeys[indexPath.section]] as? [String: AnyObject],
            let classes = school[Constants.Data.School.classes] as? [String: AnyObject]
        {
            let classKeys = Array(classes.keys.sorted().reversed())
            if  let aClass = classes[classKeys[indexPath.row]] as? [String: AnyObject],
                let nameOfClass = aClass[Constants.Data.School.nameOfClass] as? String,
                let startDate = aClass[Constants.Data.School.startDate] as? String,
                let stuffLearned = aClass[Constants.Data.School.stuffLearned] as? String
            {
                cell.nameOfClass.text = nameOfClass
                cell.startDate.text = startDate
                cell.stuffLearned.text = stuffLearned
                
                let x = heightForLabel(text: "\(nameOfClass) | \(startDate)", font: UI.Fonts.Experience.cellHeader!, width: UI.Sizing.widthObjectPadding)
                cell.positionHeight.constant = x + 5.0
                cell.startDateHeight.constant = x + 5.0
                
                let y = heightForLabel(text: stuffLearned, font: UI.Fonts.Experience.cellBody!, width: UI.Sizing.widthObjectPadding)
                cell.workCompletedHeight.constant = y + 5.0
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
        let sectionVar = SchoolSection()
        sectionVar.setup()
        if  let school = Data.school[Data.schoolNameKeys[section]] as? [String: AnyObject],
            let name = school[Constants.Data.School.schoolName] as? String
        {
            sectionVar.school.text = name
        }
        return sectionVar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UI.Sizing.School.sectionHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Data.school.keys.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if  let school = Data.school[Data.schoolNameKeys[section]] as? [String: AnyObject],
            let classes = school[Constants.Data.School.classes]?.count {
            rows = classes
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        
        if  let school = Data.school[Data.schoolNameKeys[indexPath.section]] as? [String: AnyObject],
            let classes = school[Constants.Data.School.classes] as? [String: AnyObject]
        {
            let classKeys = Array(classes.keys.sorted().reversed())
            if  let aClass = classes[classKeys[indexPath.row]] as? [String: AnyObject],
                let nameOfClass = aClass[Constants.Data.School.nameOfClass] as? String,
                let startDate = aClass[Constants.Data.School.startDate] as? String,
                let stuffLearned = aClass[Constants.Data.School.stuffLearned] as? String
            {
                x = heightForLabel(text: "\(nameOfClass) | \(startDate)", font: UI.Fonts.Experience.cellBody!, width: UI.Sizing.widthObjectPadding)
                y = heightForLabel(text: stuffLearned, font: UI.Fonts.Experience.cellBody!, width: UI.Sizing.widthObjectPadding)
            }
        }
        
        return x + y + 5.0 + 5.0 + 5.0
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

