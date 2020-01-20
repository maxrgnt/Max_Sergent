//
//  Concepts.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/20/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Concepts: UIView {
    
    //MARK: Definitions
    // Delegates
    // Constraints
    var headerHeight: NSLayoutConstraint!
    // Objects
    var header = UILabel()
    
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(closure: () -> Void) {
        backgroundColor = .clear
        
        addSubview(header)
        header.numberOfLines   = 1
        header.textAlignment   = .left
        header.backgroundColor = .clear
        header.lineBreakMode   = .byWordWrapping
        header.text            = Constants.Concepts.header
        header.font            = Fonts.Concepts.header
        header.textColor       = Colors.Concepts.header
        
        closure()
    }
        
    func resize() {
        let headerFrame = header.frameForLabel(text: header.text!,
                                               font: header.font!,
                                               numberOfLines: header.numberOfLines,
                                               width: Sizing.paddedWidth)
        headerHeight.constant = headerFrame.height
        layoutIfNeeded()
    }
    
}
