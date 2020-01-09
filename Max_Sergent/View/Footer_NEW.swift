//
//  Footer_NEW.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/9/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Footer_NEW: UIView {
    
    //MARK: Definitions
    let menu = Menu_NEW()
    let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
    let vibrancy = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: UIBlurEffect.Style.dark)))
    
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
        // Blur object settings
        addSubview(blur)
        // Vibrancy object settings
        blur.contentView.addSubview(vibrancy)
        vibrancy.contentView.addSubview(menu)
        menu.setup()
    }

}
