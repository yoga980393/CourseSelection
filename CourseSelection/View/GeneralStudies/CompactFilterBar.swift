//
//  CompactFilterBar.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/3.
//

import SwiftUI

struct CompactFilterBar: View {
    @Binding var filter: CourseFilter
    @Binding var courseList: [Course]
    @EnvironmentObject var themeSettings: ThemeSettings

    var body: some View {
        HStack {
            Picker(selection: $filter.dayOfWeek, label: Text("Day of Week")) {
                Text("星期").tag(Int?.none)
                ForEach(1...5, id: \.self) { day in
                    Text("星期\(weekToString(week: day))").tag(Int?(day))
                }
            }.pickerStyle(.menu).accentColor(themeSettings.accentColor)

            Picker(selection: $filter.period, label: Text("Period")) {
                Text("節數").tag(Int?.none)
                ForEach(1...14, id: \.self) { period in
                    Text("第\(period)節").tag(Int?(period))
                }
            }.pickerStyle(.menu).accentColor(themeSettings.accentColor)

            Picker(selection: $filter.type, label: Text("Type")) {
                Text("開課類別").tag(String?.none)
                ForEach(Array(Set(courseList.map(\.type))).sorted(), id: \.self) { type in
                    Text(type).tag(String?(type))
                }
            }.pickerStyle(.menu).accentColor(themeSettings.accentColor)
        }
        .padding(.horizontal)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(themeSettings.accentColor, lineWidth: 2)
        )
        .background(themeSettings.isDarkMode ? Color.black : Color.white)
        .cornerRadius(16)
    }
}

