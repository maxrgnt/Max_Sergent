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
    var page1_width:   NSLayoutConstraint!
    var page2_width:   NSLayoutConstraint!
    var page3_width:   NSLayoutConstraint!
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
        labels.forEach { (label) in
            widthNeededForLabels += widthForLabel(text: label.text!, font: label.font)
        }
        let availableSpace = (UI_NEW.Sizing.Header.menuWidth - widthNeededForLabels) / CGFloat(labels.count-1)
        page1_width.constant = widthForLabel(text: page1.text!, font: page1.font) + availableSpace/2
        page2_width.constant = widthForLabel(text: page2.text!, font: page2.font) + availableSpace
        page3_width.constant = widthForLabel(text: page3.text!, font: page3.font) + availableSpace/2
        layoutIfNeeded()
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
    
    func widthForLabel(text:String, font:UIFont) -> CGFloat {
        let max = CGFloat.greatestFiniteMagnitude
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: max, height: max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.width
    }

}
