//
//  Footer.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Footer: UIView {
    
    //MARK: Definitions
    // Delegates
    // Constraints
    // Objects
    var blur = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var vibrancy = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: .dark)))
    let menu = Menu()
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(closure: () -> Void) {
        roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: Sizing.Footer.radius)
        
        // Blur object settings
        addSubview(blur)
        // Vibrancy object settings
        blur.contentView.addSubview(vibrancy)
        vibrancy.contentView.addSubview(menu)
        menu.setup() {
            menu.constraints()
        }
        
        closure()
    }
    
}
