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
    func menuMoveScroll(toPage: Int)
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
    lazy var labels: [UILabel] = [page1, page2, page3]
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
        setLabels()
    }
    
    func objectSettings() {
        backgroundColor = .black
        
        for (i, page) in [page1, page2, page3].enumerated() {
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
        
        labels[0].alpha = 1.0
        labels[0].textAlignment = .left
        labels[0].font = UI_NEW.Fonts.Menu.selected
        labels[(labels.count-1)].textAlignment = .right
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(reactToPan(_:)))
        addGestureRecognizer(pan)
        
    }
    
    func setLabels() {
        var widthNeededForLabels: CGFloat = 0.0
        labels.forEach { label in
            widthNeededForLabels += frameForLabel(text: label.text!, font: label.font).width
        }
        let availableSpace = (UI_NEW.Sizing.Header.menuWidth - widthNeededForLabels) / CGFloat(labels.count-1)
        
        let page1_frame = frameForLabel(text: page1.text!, font: page1.font)
        page1_width.constant = page1_frame.width + availableSpace/2
        page1_height.constant = page1_frame.height
        
        let page2_frame = frameForLabel(text: page2.text!, font: page2.font)
        page2_width.constant = page2_frame.width + availableSpace
        page2_height.constant = page2_frame.height
        
        let page3_frame = frameForLabel(text: page3.text!, font: page3.font)
        page3_width.constant = page3_frame.width + availableSpace/2
        page3_height.constant = page3_frame.height
        
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
        updateLabels(atPoint: touchPosition)
    }
    
    @objc func reactToPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        let positionInMenu: CGPoint = CGPoint(x: touchPosition.x + translation.x, y: touchPosition.y + translation.y)
        updateLabels(atPoint: positionInMenu)
    }
    
    func updateLabels(atPoint pointInMenu: CGPoint) {
        var point = pointInMenu
        point.x = (point.x <= labels.first!.frame.minX) ? labels.first!.frame.minX : point.x
        point.x = (point.x >= labels.last!.frame.maxX) ? labels.last!.frame.maxX : point.x
        
        var tagForPoint = 0
        labels.forEach { (label) in
            tagForPoint = (label.frame.minX <= point.x && point.x <= label.frame.maxX)
                ? label.tag
                : tagForPoint
        }
        self.customDelegate.menuMoveScroll(toPage: tagForPoint)
    }

}
