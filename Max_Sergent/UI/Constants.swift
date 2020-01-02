//
//  Constants.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/9/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Header {
        static let name = "Max\nSergent"
    }
    
    struct Menu {
        static let page1 = "Overview"
        static let page2 = "Work"
        static let page3 = "School"
        static let page4 = "Projects"
        static let page5 = "Achievements"
    }
    
    struct Overview {
        static let objective  = """
                                Having spent the past two years designing and developing iOS applications in my spare time, I am determined to join an organization that understands the value of continued learning, intentional design, and selfless collaboration.
                                """
        static let originDate = "Since Jan 1st, 2019"
        static let selfProject = "Personal projects:"
        static let selfStats = "Swift: 0 days | Python: 0 days"
        static let workProject = "Work projects:"
        static let workStats = "SQL: 0 days"
    }
    
    struct Experience {
        static let header = "Experience"
        static let cellReuseId = "ExperienceCell"
        static let company = "Capital One"
    }
    
    struct Data {
        
        struct Firebase {
            static let reset = "_reset"
            static let profile = "profile"
            static let overview = "overview"
            static let work = "work"
        }
        
        struct CoreData {
            static let Profile = "ProfileData"
            static let Overview = "OverviewData"
            static let OverviewProject = "OverviewProject"
            static let Work = "WorkData"
            static let WorkPosition = "WorkPosition"
        }
        
        struct Reset {
            static let proceed = "proceed"
        }
        
        struct Profile {
            static let name = "name"
            static let picture = "picture"
            static let placeholder = "placeholder.jpg"
        }
        
        struct Overview {
            static let statement = "statement"
            static let originDate = "originDate"
            static let personalProjects = "personalProjects"
            static let workProjects = "workProjects"
            static let language = "language"
            static let days = "days"
            static let color = "color"
            static let type = "type"
            static let manyToOne = "overview"
            static let key = "key"
        }
        
        struct Work {
            static let company = "company"
            static let positions = "positions"
            static let startDate = "startDate"
            static let title = "title"
            static let workCompleted = "workCompleted"
            static let manyToOne = "work"
            static let key = "key"
        }
        
    }
    
}
