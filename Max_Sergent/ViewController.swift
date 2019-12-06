//
//  ViewController.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/6/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        print("Hello World!")
        
        let ref = Database.database().reference()
        print(ref)
        
    }
    
    
}
