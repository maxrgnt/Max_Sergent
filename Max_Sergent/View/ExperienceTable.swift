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
        return cell
    }
        
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let indexTitles: [String]? = []
        return indexTitles
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView()
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 //Data.headers.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 //Data.matrix[Data.headers[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20.0 //UI.Sizing.DrinkLibrary.Row.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let DeleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, success) in
            // pass
        })
        DeleteAction.backgroundColor = .red // UI.Color.begonia
        return UISwipeActionsConfiguration(actions: [DeleteAction])
    }
 
    //MARK: Functions
    func scrollToFirstRow() {
        let indexPath = NSIndexPath(row: 0, section: 0)
        self.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
    }
    
    // MARK: - ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {

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

