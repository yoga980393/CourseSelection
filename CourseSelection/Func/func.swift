//
//  func.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/3/20.
//

import Foundation

func weekToString(week: Int) -> String {
    switch week {
    case 1:
        return "一"
    case 2:
        return "二"
    case 3:
        return "三"
    case 4:
        return "四"
    case 5:
        return "五"
    case 6:
        return "六"
    case 7:
        return "日"
    default:
        return ""
    }
}

func displaySchedule(course: Course) -> [String] {

    if course.schedule.count == 2 {
        let week = course.schedule[0] / 100
        let period1 = course.schedule[0] % 100
        let period2 = course.schedule[1] % 100
        return ["星期\(weekToString(week: week)) 第\(period1),\(period2)節"]
    } else if course.schedule.count == 3 {
        let week1 = course.schedule[0] / 100
        let period1 = course.schedule[0] % 100
        let week2 = course.schedule[1] / 100
        let period2 = course.schedule[1] % 100
        let week3 = course.schedule[2] / 100
        let period3 = course.schedule[2] % 100

        if week1 == week2 && week2 == week3 {
            return ["星期\(weekToString(week: week1)) 第\(period1),\(period2),\(period3)節"]
        } else if week1 == week2 {
            return ["星期\(weekToString(week: week1)) 第\(period1),\(period2)節", "星期\(weekToString(week: week3)) 第\(period3)節"]
        } else if week2 == week3 {
            return ["星期\(weekToString(week: week1)) 第\(period1)節", "星期\(weekToString(week: week2)) 第\(period2),\(period3)節"]
        } else {
            return ["星期\(weekToString(week: week1)) 第\(period1)節", "星期\(weekToString(week: week2)) 第\(period2)節", "星期\(weekToString(week: week3)) 第\(period3)節"]
        }
    }
    return [""]
}

func textHoldUp(oldStr: String, maxLength: Int) -> String {
    var newStr: String = ""
    let paddedStr = oldStr.padding(toLength: maxLength, withPad: " ", startingAt: 0)
    
    for charStr in paddedStr {
        newStr.append(charStr)
        newStr.append("\n")
    }
    return newStr
}
