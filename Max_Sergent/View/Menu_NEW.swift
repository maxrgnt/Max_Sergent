//
//  Menu_NEW.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/8/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

protocol Menu_NEWDelegate {
    func menuSet(toPage: Int)
}

class Menu_NEW: UIView {
    
    //MARK: Definitions
    // Delegate
    var customDelegate : Menu_NEWDelegate!
    // Constraints
    // Need width and height constraints to center label vertically and evenly space horizontally
    // Can't just size to fit each label because we want them spaced horizontally a certain way.
    var page1_width :   NSLayoutConstraint!
    var page2_width :   NSLayoutConstraint!
    var page3_width :   NSLayoutConstraint!
    var page1_height:   NSLayoutConstraint!
    var page2_height:   NSLayoutConstraint!
    var page3_height:   NSLayoutConstraint!
    // Objects
    let page1 = UILabel()
    let page2 = UILabel()
    let page3 = UILabel()
    lazy var pages: [UILabel] = [page1, page2, page3]
    // Default to first page
    var currentPage = 0
    var touchPosition: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var canSetFromMenu = true
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        objectSettings()
        constraints()
        updatePageConstraints()
    }
    
    func objectSettings() {
        // Setting all shared characteristics for each page label
        for (i, page) in pages.enumerated() {
            addSubview(page)
            page.textAlignment = .center
            page.textColor = .white
            page.tag = i
            page.alpha = 0.7
            page.font = UI_NEW.Fonts.Menu.normal
            page.isEnabled = false
            page.text = Constants_NEW.Header.pages[i]
        }
        // Set first page to "selected"
        pages[0].alpha = 1.0
        pages[0].font = UI_NEW.Fonts.Menu.selected
        // Set first and last page buttons to align properly
        pages[0].textAlignment = .left
        pages[(pages.count-1)].textAlignment = .right
        // Declare pan gesture that will power menu bar
        let pan = UIPanGestureRecognizer(target: self, action: #selector(reactToPan(_:)))
        addGestureRecognizer(pan)
    }
    
    func updatePageConstraints() {
        // Building width needed for labels to determine available space for even spacing horizontally
        var widthNeededForLabels: CGFloat = 0.0
        pages.forEach { label in
            widthNeededForLabels += frameForLabel(text: label.text!, font: label.font).width
        }
        // Available space for each page is equal to
        // (width of menu itself) minus (width of sum of text label widths) divided by (number of labels) minus (one)
        // This ensures even spacing within each label (ignoring padding to edge of screen for first and last label)
        let availableSpace = (UI_NEW.Sizing.Header.menuWidth - widthNeededForLabels) / CGFloat(pages.count-1)
        let widths = [page1_width, page2_width, page3_width]
        let heights = [page1_height, page2_height, page3_height]
        // Set the width and height for each page dependent on text of label
        // WidthPadding = availableSpace/2 for first and last label to only alter padding between labels
        // Remember, we are ignoring padding to the edge of the screen
        for (i, page) in pages.enumerated() {
            let pageFrame = frameForLabel(text: page.text!, font: page.font)
            let widthPadding = (i == 0 || i == pages.count-1) ? availableSpace/2 : availableSpace
            widths[i]!.constant = pageFrame.width + widthPadding
            heights[i]!.constant = pageFrame.height
        }
        // Layout the changes made to page constraints
        layoutIfNeeded()
    }
    
    func frameForLabel(text:String, font:UIFont) -> (width: CGFloat, height: CGFloat) {
        // Setting max variable for readability in next line
        let max = CGFloat.greatestFiniteMagnitude
        // Create temp label to calculate size to fit
        // Can't just size to fit each label because we want them spaced horizontally a certain way.
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: max, height: max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        // Return the width and height of label to center vertically in menu and space evenly horizontally
        return (width: label.frame.width, height: label.frame.height)
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Registered with first touch on menu bar
        guard let touch = touches.first else {
            return
        }
        touchPosition = touch.location(in: self)
        // If just a tap, change page as if button
        setNewPage(atPoint: touchPosition)
    }
    
    @objc func reactToPan(_ sender: UIPanGestureRecognizer) {
        // Set temp variable as translation or movement of finger within menu view
        let translation = sender.translation(in: self)
        // Get the position within menu by applying the translation to the original first touch position
        let positionInMenu: CGPoint = CGPoint(x: touchPosition.x + translation.x, y: touchPosition.y + translation.y)
        // Set new page based off where in menu bar finger currently is panning (or ends panning)
        setNewPage(atPoint: positionInMenu)
    }
    
    func setNewPage(atPoint pointInMenu: CGPoint) {
        // Declare temp variable as selected point in menu view
        var point = pointInMenu
        // If the menu point is smaller than minimium point for first label, make it first page (far left of screen)
        point.x = (point.x <= pages.first!.frame.minX) ? pages.first!.frame.minX : point.x
        // If the menu point is larger than maximum point for last label, make it last page (far right of screen)
        point.x = (point.x >= pages.last!.frame.maxX) ? pages.last!.frame.maxX : point.x
        // Declare temp variable to determine tag of label for given point in menu view
        var newPage = 0
        pages.forEach { (label) in
            // Tag for a label assigned if it is greater than or equal to its minimum frame and less than maximum frame
            newPage = (label.frame.minX <= point.x && point.x <= label.frame.maxX) // <=
                ? label.tag
                : newPage
        }
        // Alert the scroll view to change pages based off menu input
        (currentPage != newPage && canSetFromMenu) ? self.customDelegate.menuSet(toPage: newPage) : nil
    }

    func setAlphaForPage() {
        pages.forEach { (label) in
            label.font = (label.tag == currentPage)
                ? UI_NEW.Fonts.Menu.selected
                : UI_NEW.Fonts.Menu.normal
            label.alpha = (label.tag == currentPage)
                ? 1.0
                : 0.7
        }
    }
    
}
