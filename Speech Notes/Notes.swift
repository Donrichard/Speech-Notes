//
//  Notes.swift
//  Speech Notes
//
//  Created by Richard Richard on 02/04/18.
//  Copyright © 2018 Richard Richard. All rights reserved.
//

import Foundation

class Notes {
    var title = String()
    var detail: String?
    var lastUpdated: Date?
    
    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
        self.lastUpdated = Date()
    }
    
    public func changeTitle(title: String) {
        self.title = title
    }
    
    public func changeDetail(detail: String) {
        self.detail = detail
    }
}
