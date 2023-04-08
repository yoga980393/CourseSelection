//
//  FilterBar.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/2.
//

import SwiftUI

struct CourseFilter {
    var department: String? = nil
    var type: String? = nil
    var credits: Int? = nil
    var hour: Int? = nil
    var dayOfWeek: Int? = nil
    var period: Int? = nil
    var showEnrolled: Bool? = nil
    var showFavorite: Bool? = nil
    
    func isMatch(_ course: Course, selectedCourses: [Course]? = nil, favoriteCourses: [Course]? = nil) -> Bool {
        let departmentMatch = department == nil || course.department == department
        let typeMatch = type == nil || course.type == type
        let creditsMatch = credits == nil || course.credits == credits
        let hourMatch = hour == nil || course.hour == hour
        
        let dayOfWeekMatch = dayOfWeek == nil || course.schedule.contains { $0 / 100 == dayOfWeek }
        let periodMatch = period == nil || course.schedule.contains { $0 % 100 == period }
        
        let enrolledMatch = selectedCourses == nil || showEnrolled == nil || (showEnrolled! == selectedCourses!.contains(course))
        let favoriteMatch = favoriteCourses == nil || showFavorite == nil || (showFavorite! == favoriteCourses!.contains(course))
        
        return departmentMatch && typeMatch && creditsMatch && hourMatch && dayOfWeekMatch && periodMatch && enrolledMatch && favoriteMatch
    }
}


struct FilterBar: View {
    @Binding var filter: CourseFilter
    @Binding var courseList: [Course]
    @Binding var selectedCourses: [Course]
    @Binding var favoriteCourses: [Course]
    @Binding var isExpanded: Bool
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var body: some View {
        if isExpanded {
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    HStack {
                        Picker(selection: $filter.department, label: Text("Department")) {
                            Text("開課系所").tag(String?.none)
                            ForEach(Array(Set(courseList.map(\.department))).sorted(), id: \.self) { department in
                                Text(department).tag(String?(department))
                            }
                        }.pickerStyle(.menu)
                            .frame(width: geometry.size.width * 0.3)
                            .padding(.horizontal, -15)
                        
                        Picker(selection: $filter.type, label: Text("Type")) {
                            Text("開課類別").tag(String?.none)
                            ForEach(Array(Set(courseList.map(\.type))).sorted(), id: \.self) { type in
                                Text(type).tag(String?(type))
                            }
                        }.pickerStyle(.menu)
                            .frame(width: geometry.size.width * 0.3)
                            .padding(.horizontal, -15)
                        
                        Picker(selection: $filter.credits, label: Text("Credits")) {
                            Text("學分").tag(Int?.none)
                            ForEach(Array(Set(courseList.map(\.credits))).sorted(), id: \.self) { credits in
                                Text("\(credits) 學分").tag(Int?(credits))
                            }
                        }.pickerStyle(.menu)
                            .frame(width: geometry.size.width * 0.3)
                            .padding(.horizontal, -15)
                        
                        Picker(selection: $filter.hour, label: Text("Hour")) {
                            Text("上課時間").tag(Int?.none)
                            ForEach(Array(Set(courseList.map(\.hour))).sorted(), id: \.self) { hour in
                                Text("\(hour) 小時").tag(Int?(hour))
                            }
                        }.pickerStyle(.menu)
                            .frame(width: geometry.size.width * 0.3)
                            .padding(.horizontal, -15)
                    }
                    .frame(width: geometry.size.width)
                    
                    HStack {
                        Picker(selection: $filter.dayOfWeek, label: Text("Day of Week")) {
                            Text("星期").tag(Int?.none)
                            ForEach(1..<6, id: \.self) { day in
                                Text("星期\(weekToString(week: day))").tag(Int?(day))
                            }
                        }.pickerStyle(.menu)
                            .frame(width: geometry.size.width * 0.3)
                            .padding(.horizontal, -15)
                        
                        Picker(selection: $filter.period, label: Text("Period")) {
                            Text("節數").tag(Int?.none)
                            ForEach(1..<13, id: \.self) { period in
                                Text("第\(period)節").tag(Int?(period))
                            }
                        }.pickerStyle(.menu)
                            .frame(width: geometry.size.width * 0.3)
                            .padding(.horizontal, -15)
                        Picker(selection: $filter.showEnrolled, label: Text("Enrolled")) {
                            Text("已加選").tag(Bool?.none)
                            Text("是").tag(Bool?(true))
                            Text("否").tag(Bool?(false))
                        }.pickerStyle(.menu)
                            .frame(width: geometry.size.width * 0.3)
                            .padding(.horizontal, -15)
                        
                        Picker(selection: $filter.showFavorite, label: Text("Favorite")) {
                            Text("已收藏").tag(Bool?.none)
                            Text("是").tag(Bool?(true))
                            Text("否").tag(Bool?(false))
                        }.pickerStyle(.menu)
                            .frame(width: geometry.size.width * 0.3)
                            .padding(.horizontal, -15)
                    }
                    .frame(width: geometry.size.width)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(themeSettings.accentColor, lineWidth: 2)
                )
                .frame(width: geometry.size.width)
                .background(themeSettings.isDarkMode ? Color(red: 87/255, green: 88/255, blue: 87/255) : Color.white)
                .cornerRadius(16)
            }
        }
    }
}

