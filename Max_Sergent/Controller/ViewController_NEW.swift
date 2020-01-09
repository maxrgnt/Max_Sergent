//
//  ViewController_NEW.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/8/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class ViewController_NEW: UIViewController, Menu_NEWDelegate {
    
    let header = Header_NEW()
    
    override func viewDidLoad() {
        print("Hello World!")
        view.backgroundColor = .darkGray
        setup()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // App background color is light, whether in light or dark mode make status bar dark.
        return .darkContent
    }
    
    //MARK: Setup
    func setup() {
        objectSettings()
        constraints()
        
    }
    
    //MARK: Settings
    func objectSettings() {
        view.addSubview(header)
        header.setup()
        header.menu.customDelegate = self
    }
    
    //MARK: Functionality
    
    //MARK: Custom Delegates
    func menuSet(toPage page: Int) {
        // pass
    }
    
}
