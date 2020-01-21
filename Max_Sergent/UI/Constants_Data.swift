//
//  Constants_Data.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/20/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

extension Constants {
    
    struct UserDefaults {
        static let coreData         = "CoreData"
    }
    
    struct Firebase_Path {
        static let reset            = "1_reset"
        static let appInfo          = "2_appInfo"
        static let overview         = "3_overview"
    }
    
    struct CoreData_Entity {
        static let appInfo          = "AppInfo"
        static let overview         = "Overview"
        static let timeline         = "Timeline"
        static let habit            = "Habit"
        static let concept          = "Concept"
    }

    struct Data_Key {
        static let proceed          = "proceed"
        static let watermark        = "watermark"
        static let userName         = "userName"
        static let appInfoPhotoURL  = "appInfoPhotoURL"
        static let appInfoPhoto     = "appInfoPhoto"
        static let email            = "email"
        static let email_subject    = "email_subject"
        static let email_body       = "email_body"
        static let linkedinAppURL   = "linkedinAppURL"
        static let linkedinWebURL   = "linkedinWebURL"
        static let locationBackEnd  = "locationBackEnd"
        static let locationFrontEnd = "locationFrontEnd"
        static let objective        = "objective"
    }
    
    struct Placeholder {
        static let photoURL         = "placeholder"
    }
    
}