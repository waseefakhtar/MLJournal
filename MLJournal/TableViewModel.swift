//
//  TableViewModel.swift
//  MLJournal
//
//  Created by Waseef Akhtar on 7/21/17.
//  Copyright © 2017 Waseef Akhtar. All rights reserved.
//

import Foundation
import UIKit

struct TableViewModel {
    var title: String
    var article: String
    var subtitle: String
    
    init(json: [String: Any]) {
        
        // Initialize stored properties.
        self.title = json["title"] as! String
        self.article = json["article"] as! String
        self.subtitle = json["subtitle"] as! String

    }
}
