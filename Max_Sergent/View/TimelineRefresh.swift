//
//  TimelineRefresh.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/16/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import UIKit

class TimelineRefresh: UIView {

    //MARK: Definitions
    // Delegates
    // Constraints
    // Objects
    var icon = UIImageView()
    var title = UILabel()
    var line = UILabel()
    var node = UILabel()
    var isAnimating = false
    var iconIndex = 0
    let icons = ["capitalOne","apple","amazon"]
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    //MARK: Settings
    func setup(closure: () -> Void) {
                
        backgroundColor = .clear
        
        addSubview(line)
        addSubview(node)
        node.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: Sizing.Timeline.nodeRadius)
        node.alpha = 0.0
        
        addSubview(title)
        title.numberOfLines   = 1
        title.textAlignment   = .left
        title.backgroundColor = .clear
        title.lineBreakMode   = .byWordWrapping
        title.font            = Fonts.Timeline.title
        title.text            = Constants.Timeline.refreshTitle
        title.alpha = 0.0
        
        addSubview(icon)
        icon.clipsToBounds       = true
        icon.layer.masksToBounds = true
        icon.contentMode         = .scaleAspectFill
        icon.alpha = 0
        self.icon.image = UIImage(named: icons[0])
        
        closure()
    }
    
    func refreshAlpha(to newAlpha: CGFloat) {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [.curveLinear],
                   animations: {
                    self.node.alpha = newAlpha
                    self.title.alpha = newAlpha
               }, completion: { (done: Bool) in
                   // pass
                   }
               )
    }
        
    func animateIcon(toAlpha newAlpha: CGFloat) {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [.curveLinear],
            animations: {
                self.icon.alpha = newAlpha
        }, completion: { (done: Bool) in
            if newAlpha == 0.0 {
                self.iconIndex += 1
                self.iconIndex = (self.iconIndex == self.icons.count) ? 0 : self.iconIndex
                self.icon.image = UIImage(named: self.icons[self.iconIndex])
            }
            let nextAlpha: CGFloat = (newAlpha == 0.0) ? 1.0 : 0.0
            self.isAnimating ? self.animateIcon(toAlpha: nextAlpha) : nil
            }
        )
    }
    
    func nukeAnimations() {
        subviews.forEach({$0.layer.removeAllAnimations()})
        layer.removeAllAnimations()
        isAnimating = false
        refreshAlpha(to: 0.0)
    }
    
}
