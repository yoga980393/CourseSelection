//
//  Course.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/3/20.
//
import Foundation

struct Course: Codable, Identifiable, Equatable {
    var id: String
    var name: String
    var shortName: String
    var department: String
    var introduction: String
    var language: String
    var type: String
    var credits: Int
    var hour: Int
    var schedule: [Int]
    var place: String
    var numberOfPeople: Int
    var maxOfPeople: Int
    var teacher: String
    var image: String

    init(id: String, name: String, shortName: String, department: String, introduction: String, language: String, type: String, credits: Int, hour: Int, schedule: [Int], place: String, numberOfPeople: Int, maxOfPeople: Int, teacher: String, image: String) {
        self.id = id
        self.name = name
        self.shortName = shortName
        self.department = department
        self.introduction = introduction
        self.language = language
        self.type = type
        self.credits = credits
        self.hour = hour
        self.schedule = schedule
        self.place = place
        self.numberOfPeople = numberOfPeople
        self.maxOfPeople = maxOfPeople
        self.teacher = teacher
        self.image = image
    }
    
    init() {
        self.init(id: "", name: "", shortName: "", department: "", introduction: "", language: "", type: "", credits: 0, hour: 0, schedule: [], place: "", numberOfPeople: 0, maxOfPeople: 0, teacher: "", image: "")
    }
    
    static func ==(lhs: Course, rhs: Course) -> Bool {
            return lhs.id == rhs.id
        }
}

