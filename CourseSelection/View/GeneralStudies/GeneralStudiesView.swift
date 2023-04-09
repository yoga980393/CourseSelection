//
//  GeneralStudiesView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/3/31.
//

import SwiftUI

struct GeneralStudiesView: View {
    @Binding var courseList: [Course]
    @Binding var selectedCourses: [Course]
    @State private var chosenVolunteers: [Int] = [-1]
    @State private var currentlySelectedVolunteerIndex: Int?
    @State private var showGeneralStudiesList = false
    @State private var showAlertForDelete = false
    @State private var showAlertForConflict = false
    @State private var conflictCourse: Course?

    var body: some View {
        NavigationView{
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0..<chosenVolunteers.count, id: \.self) { index in
                        VolunteerView(CouresList: $courseList, rank: index + 1, choose: $chosenVolunteers[index])
                            .padding(.bottom, 10)
                            .onTapGesture {
                                currentlySelectedVolunteerIndex = index
                                showGeneralStudiesList = true
                            }
                            .onLongPressGesture {
                                showAlertForDelete = true
                                currentlySelectedVolunteerIndex = index
                            }
                    }
                }
                .padding()
            }
            .navigationBarTitle("通識課程", displayMode: .inline)
        }
        .sheet(isPresented: $showGeneralStudiesList) {
            GeneralStudiesList(courseList: $courseList, selectedCourseIndex: Binding(
                get: { currentlySelectedVolunteerIndex != nil ? chosenVolunteers[currentlySelectedVolunteerIndex!] : -1 },
                set: { newIndex in
                    if let currentIndex = currentlySelectedVolunteerIndex {
                        let selectedCourse = courseList[newIndex]
                        if let existingCourse = selectedCourses.first(where: { $0.conflicts(with: selectedCourse) }) {
                            conflictCourse = existingCourse
                            showAlertForConflict = true
                        } else {
                            chosenVolunteers[currentIndex] = newIndex
                            if currentIndex == chosenVolunteers.count - 1 && chosenVolunteers.count < 10 {
                                chosenVolunteers.append(-1)
                            }
                        }
                    }
                    currentlySelectedVolunteerIndex = nil
                }
            ), selectedCourses: $selectedCourses, chosenVolunteers: chosenVolunteers) // Pass the chosenVolunteers array
        }
        .alert(isPresented: $showAlertForDelete) {
            Alert(title: Text("確認刪除"),
                  message: Text("確定要刪除第 \(currentlySelectedVolunteerIndex! + 1) 志願嗎？"),
                  primaryButton: .destructive(Text("刪除")) {
                      deleteVolunteer(at: currentlySelectedVolunteerIndex!)
                  },
                  secondaryButton: .cancel(Text("取消")))
        }
    }
    
    private func deleteVolunteer(at index: Int) {
        chosenVolunteers.remove(at: index)
        if chosenVolunteers.last != -1 {
            chosenVolunteers.append(-1)
        }
    }
}


struct GeneralStudiesView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralStudiesView(courseList: .constant([
            Course(id: "B0001", name: "通識測試1", shortName: "通識測試1", department: "必修", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [303, 304], place: "", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
            Course(id: "B0002", name: "通識測試2", shortName: "通識測試2", department: "通識", introduction: "", language: "國語", type: "藝術", credits: 2, hour: 2, schedule: [501, 502, 503], place: "", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
            Course(id: "B0003", name: "通識測試3", shortName: "通識測試2", department: "通識", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [501, 502, 201], place: "", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0")
        ]),selectedCourses: Binding.constant([]))
        .environmentObject(ThemeSettings())
    }
}
