//
//  Menu.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

protocol MenuDelegate {
    func menuSet(toPage: Int)
}

class Menu: UIView {
    
    //MARK: Definitions
    // Delegates
    var customDelegate: MenuDelegate!
    // Constraints
    // Objects
    var label1 = UILabel()
    var label2 = UILabel()
    var label3 = UILabel()
    var icon1 = UIImageView()
    var icon2 = UIImageView()
    var icon3 = UIImageView()
    lazy var pages: [AnyObject] = [label1, icon1, label2, icon2, label3, icon3]
    lazy var labels: [UILabel] = [label1, label2, label3]
    lazy var icons: [UIImageView] = [icon1, icon2, icon3]
    // Default to first page
    var currentPage = 0
    var touchPosition: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var canSetFromMenu = true
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(closure: () -> Void) {
        
        for (i, label) in labels.enumerated() {
            addSubview(label)
            label.textAlignment = .center
            label.textColor     = Colors.Menu.text
            label.tag           = i
            label.alpha         = 0.5
            label.font          = Fonts.Menu.normal
            label.isEnabled     = false
            label.text          = Constants.Menu.pages[i]
        }
        
        for (i, icon) in icons.enumerated() {
            addSubview(icon)
            icon.tag                 = i
            icon.alpha               = 0.5
            icon.clipsToBounds       = true
            icon.layer.masksToBounds = true
            icon.contentMode         = .scaleAspectFill
            icon.image               = UIImage(named: Constants.Menu.pages[i])
        }
        
        labels[0].alpha = 1.0
        labels[0].font  = Fonts.Menu.selected
        icons[0].alpha = 1.0
        
        // Declare pan gesture that will power menu bar
        let pan = UIPanGestureRecognizer(target: self, action: #selector(reactToPan(_:)))
        addGestureRecognizer(pan)
        
        closure()
    }
    
    //MARK: Adjust State
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
        pages.forEach { (page) in
            // Tag for a label assigned if it is greater than or equal to its minimum frame and less than maximum frame
            newPage = (page.frame.minX <= point.x && point.x <= page.frame.maxX) // <=
                ? page.tag
                : newPage
        }
        // Alert the scroll view to change pages based off menu input
        (currentPage != newPage && canSetFromMenu) ? self.customDelegate.menuSet(toPage: newPage) : nil
    }

    func setAlphaForPage() {
        icons.forEach { (icon) in
            icon.alpha = (icon.tag == currentPage)
                ? 1.0
                : 0.5
        }
        labels.forEach { (label) in
            label.font = (label.tag == currentPage)
                ? Fonts.Menu.selected
                : Fonts.Menu.normal
            label.alpha = (label.tag == currentPage)
                ? 1.0
                : 0.5
        }
    }
}
