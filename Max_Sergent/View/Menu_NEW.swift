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
    var page1_width :   NSLayoutConstraint!
    var page1_height:   NSLayoutConstraint!
    var page2_width :   NSLayoutConstraint!
    var page2_height:   NSLayoutConstraint!
    var page3_width :   NSLayoutConstraint!
    var page3_height:   NSLayoutConstraint!
    // Objects
    let page1 = UILabel()
    let page2 = UILabel()
    let page3 = UILabel()
    lazy var pages: [UILabel] = [page1, page2, page3]
    var touchPosition: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var pageSelected = false
    
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
        
        for (i, page) in pages.enumerated() {
            addSubview(page)
            page.textAlignment = .center
            page.backgroundColor = .black
            page.textColor = .white
            page.tag = i
            page.alpha = 0.7
            page.font = UI_NEW.Fonts.Menu.normal
            page.isEnabled = false
            page.text = Constants_NEW.Header.pages[i]
        }
        
        pages[0].alpha = 1.0
        pages[0].textAlignment = .left
        pages[0].font = UI_NEW.Fonts.Menu.selected
        pages[(pages.count-1)].textAlignment = .right
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(reactToPan(_:)))
        addGestureRecognizer(pan)
        
    }
    
    func updatePageConstraints() {
        var widthNeededForLabels: CGFloat = 0.0
        pages.forEach { label in
            widthNeededForLabels += frameForLabel(text: label.text!, font: label.font).width
        }
        let availableSpace = (UI_NEW.Sizing.Header.menuWidth - widthNeededForLabels) / CGFloat(pages.count-1)
        let widths = [page1_width, page2_width, page3_width]
        let heights = [page1_height, page2_height, page3_height]
        for (i, page) in pages.enumerated() {
            let pageFrame = frameForLabel(text: page.text!, font: page.font)
            let widthPadding = (i == 0 || i == pages.count-1) ? availableSpace/2 : availableSpace
            widths[i]!.constant = pageFrame.width + widthPadding
            heights[i]!.constant = pageFrame.height
        }
        layoutIfNeeded()
    }
    
    func frameForLabel(text:String, font:UIFont) -> (width: CGFloat, height: CGFloat) {
        let max = CGFloat.greatestFiniteMagnitude
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: max, height: max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return (width: label.frame.width, height: label.frame.height)
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        touchPosition = touch.location(in: self)
        setNewPage(atPoint: touchPosition)
    }
    
    @objc func reactToPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        let positionInMenu: CGPoint = CGPoint(x: touchPosition.x + translation.x, y: touchPosition.y + translation.y)
        setNewPage(atPoint: positionInMenu)
    }
    
    func setNewPage(atPoint pointInMenu: CGPoint) {
        var point = pointInMenu
        point.x = (point.x <= pages.first!.frame.minX) ? pages.first!.frame.minX : point.x
        point.x = (point.x >= pages.last!.frame.maxX) ? pages.last!.frame.maxX : point.x
        
        var tagForPoint = 0
        pages.forEach { (label) in
            tagForPoint = (label.frame.minX <= point.x && point.x <= label.frame.maxX)
                ? label.tag
                : tagForPoint
        }
        self.customDelegate.menuSet(toPage: tagForPoint)
    }

}
