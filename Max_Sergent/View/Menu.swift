//
//  Menu.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/27/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Menu: UIView {
    
    //MARK: Definitions
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
        backgroundColor = .white
        
        addSubview(page1)
        page1.text = Constants.Menu.page1
        page1.textAlignment = .center
        page1.backgroundColor = .black
        page1.textColor = .white
        page1.tag = 0
        page1.font = UI.Fonts.Menu.selected
        page1.isEnabled = false
        
        addSubview(page2)
        page2.text = Constants.Menu.page2
        page2.textAlignment = .center
        page2.backgroundColor = .black
        page2.textColor = .white
        page2.tag = 1
        page2.font = UI.Fonts.Menu.normal
        page2.isEnabled = false
        
        addSubview(page3)
        page3.text = Constants.Menu.page3
        page3.textAlignment = .center
        page3.backgroundColor = .black
        page3.textColor = .white
        page3.tag = 2
        page3.font = UI.Fonts.Menu.normal
        page3.isEnabled = false
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(reactToPan(_:)))
        addGestureRecognizer(pan)
        
    }
    
    func constraints() {
        page1Constraints()
        page1_width.constant = widthForLabel(text: page1.text!, font: page1.font) + UI.Sizing.Menu.padding
        page2_width.constant = widthForLabel(text: page2.text!, font: page2.font) + UI.Sizing.Menu.padding
        page3_width.constant = widthForLabel(text: page3.text!, font: page3.font) + UI.Sizing.Menu.padding
        layoutIfNeeded()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            touchPosition = touch.location(in: self)
            labels.forEach { (label) in
                if label.frame.contains(touchPosition) {
                    label.font = UI.Fonts.Menu.selected
                }
                else {
                    label.font = UI.Fonts.Menu.normal
                }
            }
        }
    }
    
    @objc func reactToPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        let positionInMenu: CGPoint = CGPoint(x: touchPosition.x + translation.x, y: touchPosition.y + translation.y)
        print(positionInMenu)
        labels.forEach { (label) in
            if label.frame.contains(positionInMenu) {
                label.font = UI.Fonts.Menu.selected
            }
            else {
                label.font = UI.Fonts.Menu.normal
            }
        }
        if sender.state == UIPanGestureRecognizer.State.ended {
            print("Ended: \(positionInMenu)")
            labels.forEach { (label) in
                if label.frame.contains(positionInMenu) {
                    label.font = UI.Fonts.Menu.selected
                }
                else {
                    label.font = UI.Fonts.Menu.normal
                }
            }
        }
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
