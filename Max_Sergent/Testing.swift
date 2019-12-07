//
//  Testing.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/7/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import UIKit

class Testing: UIView {
    
    //MARK: Definitions
    // Objects
    let addToFirebase = UIButton()
    let displayFirebase = UILabel()
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup
    func setup() {
        backgroundColor = .darkGray
        objectSettings()
        constraints()
    }
    
    func objectSettings() {
        addSubview(addToFirebase)
        addToFirebase.backgroundColor = .lightGray
        addToFirebase.alpha = 0.7
        addToFirebase.isUserInteractionEnabled = true
        addSubview(displayFirebase)
        displayFirebase.textAlignment = .left
        displayFirebase.font = UIFont(name: "Arvo", size: 14)
    }
    
    //MARK: Constraints
    func constraints() {
        addToFirebase.translatesAutoresizingMaskIntoConstraints                                                     = false
        addToFirebase.leadingAnchor.constraint(equalTo: leadingAnchor).isActive                                     = true
        addToFirebase.trailingAnchor.constraint(equalTo: trailingAnchor).isActive                                   = true
        addToFirebase.topAnchor.constraint(equalTo: topAnchor).isActive                                             = true
        addToFirebase.heightAnchor.constraint(equalToConstant: 300).isActive                                        = true
        
        displayFirebase.translatesAutoresizingMaskIntoConstraints                                                   = false
        displayFirebase.leadingAnchor.constraint(equalTo: leadingAnchor).isActive                                   = true
        displayFirebase.trailingAnchor.constraint(equalTo: trailingAnchor).isActive                                 = true
        displayFirebase.topAnchor.constraint(equalTo: addToFirebase.bottomAnchor).isActive                          = true
        displayFirebase.heightAnchor.constraint(equalToConstant: 300).isActive                                      = true
    }
    
    //MARK: Animations
    func animate (to state: String) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut
            , animations: ({
                self.layoutIfNeeded()
            }), completion: { (completed) in
                // pass
            }
        )
    }
    
}
