//
//  GeneralStudiesList.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/3/31.
//

import SwiftUI

struct GeneralStudiesList: View {
    @Binding var CouresList: [Course]
    @Binding var selectedCourseIndex: Int
    @Environment(\.presentationMode) var presentationMode
    var chosenVolunteers: [Int]
    
    @State private var filter = CourseFilter()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .top) {
                    Color(.systemGroupedBackground) // Add the same background color as the List
                        .edgesIgnoringSafeArea(.all)
                    
                    List {
                        ForEach(CouresList.filter { filter.isMatch($0) }, id: \.id) { course in
                            TextImageRow(course: course, isSelected: false)
                                .onTapGesture {
                                    let selectedIndex = CouresList.firstIndex(where: { $0.id == course.id }) ?? -1
                                    if !chosenVolunteers.contains(selectedIndex) {
                                        selectedCourseIndex = selectedIndex
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                                .opacity(chosenVolunteers.contains(CouresList.firstIndex(where: { $0.id == course.id }) ?? -1) ? 0.5 : 1.0) // Optional: Make the row semi-transparent if it's already chosen
                        }
                    }
                    .padding(.top, 30) // Add padding to the top of the list
                    
                    CompactFilterBar(filter: $filter, courseList: $CouresList)
                        .padding(.top)
                }
            }
        }
    }
}





