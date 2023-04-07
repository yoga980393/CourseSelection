//
//  Score.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import Foundation

struct Score: Codable {
    var year: Int
    var semester: String
    var number: String
    var department: String
    var name: String
    var type: String
    var credits: Int
    var score: Int
    
    init(year: Int, semester: String, number: String, department: String, name: String, type: String, credits: Int, score: Int) {
        self.year = year
        self.semester = semester
        self.number = number
        self.department = department
        self.name = name
        self.type = type
        self.credits = credits
        self.score = score
    }
    
    init() {
        self.init(year: 0, semester: "", number: "", department: "", name: "", type: "", credits: 0, score: 0)
    }
}
