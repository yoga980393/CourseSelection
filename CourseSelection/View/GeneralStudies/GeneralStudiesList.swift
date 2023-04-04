//
//  GeneralStudiesList.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/3/31.
//

import SwiftUI

import SwiftUI

struct GeneralStudiesList: View {
    @Binding var courseList: [Course]
    @Binding var selectedCourseIndex: Int
    @Binding var selectedCourses: [Course]
    @Environment(\.presentationMode) var presentationMode
    var chosenVolunteers: [Int]

    @State private var filter = CourseFilter()
    @State private var showAlertForConflict = false
    @State private var conflictingCourse: Course?

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .top) {
                    Color(.systemGroupedBackground) // Add the same background color as the List
                        .edgesIgnoringSafeArea(.all)

                    List {
                        ForEach(courseList.filter { filter.isMatch($0) }, id: \.id) { course in
                            TextImageRow(course: course, isSelected: false, isFavorite: false)
                                .onTapGesture {
                                    let selectedIndex = courseList.firstIndex(where: { $0.id == course.id }) ?? -1
                                    if !chosenVolunteers.contains(selectedIndex) {
                                        if hasConflict(selectedCourse: course) {
                                            showAlertForConflict = true
                                        } else {
                                            selectedCourseIndex = selectedIndex
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                    }
                                }
                                .opacity(chosenVolunteers.contains(courseList.firstIndex(where: { $0.id == course.id }) ?? -1) ? 0.5 : 1.0) // Optional: Make the row semi-transparent if it's already chosen
                        }
                    }
                    .padding(.top, 30) // Add padding to the top of the list

                    CompactFilterBar(filter: $filter, courseList: $courseList)
                        .padding(.top)
                }
            }
        }
        .alert(isPresented: $showAlertForConflict) {
            Alert(title: Text("衝突警告"),
                  message: Text("所選課程與「 \(conflictingCourse?.name ?? "") 」衝堂。請選擇其他課程。"),
                  dismissButton: .default(Text("確定")))
        }
    }

    private func hasConflict(selectedCourse: Course) -> Bool {
        for existingCourse in selectedCourses {
            if selectedCourse.conflicts(with: existingCourse) {
                conflictingCourse = existingCourse
                return true
            }
        }
        return false
    }
}

extension Course {
    func conflicts(with otherCourse: Course) -> Bool {
        for time1 in schedule {
            for time2 in otherCourse.schedule {
                if time1 == time2 {
                    return true
                }
            }
        }
        return false
    }
}




