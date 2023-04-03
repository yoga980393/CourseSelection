//
//  Time.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/3.
//

import Foundation

struct Time {
    var clause: String
    var period: String
    
    init(clause: String, period: String) {
        self.clause = clause
        self.period = period
    }
    
    init() {
        self.init(clause: "", period: "")
    }
}
