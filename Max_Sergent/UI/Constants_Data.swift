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
        static let lastUpdate       = "lastUpdate"
        static let pieOriginDate    = "pieOriginDate"
        static let futureYear       = "futureYear"
    }
    
    struct Firebase_Path {
        static let reset            = "1_reset"
        static let appInfo          = "2_appInfo"
        static let overview         = "3_overview"
        static let future           = "4_future"
        static let timeline         = "4_timeline"
        static let pie              = "5_pie"
        static let concepts         = "6_concepts"
        static let colorScheme      = "7_colorScheme"
    }
    
    struct CoreData_Entity {
        static let appInfo          = "AppInfo"
        static let overview         = "Overview"
        static let timeline         = "Timeline"
        static let future           = "Future"
        static let pie              = "PieData"
        static let concepts         = "ConceptData"
        static let colorScheme      = "ColorScheme"
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
        static let organization     = "organization"
        static let year             = "year"
        static let title            = "title"
        static let details          = "details"
        static let iconName         = "iconName"
        static let iconURL          = "iconURL"
        static let index            = "index"
        static let type             = "type"
        static let key              = "key"
        static let events           = "events"
        static let color            = "color"
        static let days             = "days"
        static let piece            = "piece"
        static let originDate       = "_originDate"
        static let experience       = "timeline_experience"
        static let education        = "timeline_education"
        static let project          = "timeline_project"
        static let background1      = "background1"
        static let background2      = "background2"
        static let background3      = "background3"
        static let effectStyle      = "effectStyle"
        static let font1            = "font1"
        static let font2            = "font2"
        static let active           = "active"
        static let gradientStart    = "gradientStart"
        static let gradientEnd      = "gradientEnd"
        static let future           = "future"
        static let futureYear       = "_year"
    }
    
    struct Image_Prefix {
        static let concept          = "concept_"
        static let timeline         = "timeline_"
        static let future           = "future_"
    }
    
    struct Placeholder {
        static let photoURL         = "placeholder"
    }
    
}
