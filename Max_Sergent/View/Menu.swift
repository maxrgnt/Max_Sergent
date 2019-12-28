//
//  Menu.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/27/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

protocol MenuDelegate {
    func moveScroll(toPage: Int)
}

class Menu: UIView {
    
    //MARK: Definitions
    // Delegate
    var customDelegate : MenuDelegate!
    // Constraints
    var page1_width:   NSLayoutConstraint!
    var page2_width:   NSLayoutConstraint!
    var page3_width:   NSLayoutConstraint!
    var page4_width:   NSLayoutConstraint!
    var page5_width:   NSLayoutConstraint!
    // Objects
    let page1 = UILabel()
    let page2 = UILabel()
    let page3 = UILabel()
    let page4 = UILabel()
    let page5 = UILabel()
    lazy var labels: [UILabel] = [page1, page2, page3, page4, page5]
    var touchPosition: CGPoint = CGPoint(x: 0.0, y: 0.0)
    
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
    }
    
    func objectSettings() {
        backgroundColor = .black
        
        for (i, page) in [page1, page2, page3, page4, page5].enumerated() {
            addSubview(page)
            page.textAlignment = .center
            page.backgroundColor = .black
            page.textColor = .white
            page.tag = i
            page.alpha = 0.7
            page.font = UI.Fonts.Menu.normal
            page.isEnabled = false
        }
        
        labels[0].alpha = 1.0
        labels[0].textAlignment = .left
        labels[0].font = UI.Fonts.Menu.selected
        labels[(labels.count-1)].textAlignment = .right
        
        page1.text = Constants.Menu.page1
        page2.text = Constants.Menu.page2
        page3.text = Constants.Menu.page3
        page4.text = Constants.Menu.page4
        page5.text = Constants.Menu.page5
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(reactToPan(_:)))
        addGestureRecognizer(pan)
        
    }
    
    func constraints() {
        page1Constraints()
        setLabels()
    }
    
    func setLabels() {
        var widthNeededForLabels: CGFloat = 0.0
        labels.forEach { (label) in
            widthNeededForLabels += widthForLabel(text: label.text!, font: label.font)
        }
        let availableSpace = (UI.Sizing.Menu.barWidth - widthNeededForLabels) / CGFloat(labels.count-1)
        page1_width.constant = widthForLabel(text: page1.text!, font: page1.font) + availableSpace/2
        page2_width.constant = widthForLabel(text: page2.text!, font: page2.font) + availableSpace
        page3_width.constant = widthForLabel(text: page3.text!, font: page3.font) + availableSpace
        page4_width.constant = widthForLabel(text: page4.text!, font: page4.font) + availableSpace
        page5_width.constant = widthForLabel(text: page5.text!, font: page5.font) + availableSpace/2
        layoutIfNeeded()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchPosition = touch.location(in: self)
            updateLabels(atPoint: touchPosition)
        }
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
            label.font = (label.frame.minX <= point.x && point.x <= label.frame.maxX)
                ? UI.Fonts.Menu.selected
                : UI.Fonts.Menu.normal
            label.alpha = (label.frame.minX <= point.x && point.x <= label.frame.maxX)
                ? 1.0
                : 0.7
            tagForPoint = (label.frame.minX <= point.x && point.x <= label.frame.maxX)
                ? label.tag
                : tagForPoint
        }
        self.customDelegate.moveScroll(toPage: tagForPoint)
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
