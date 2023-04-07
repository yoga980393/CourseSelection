//
//  GeneralCourseView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/3/20.
//
import SwiftUI

struct GeneralCourseView: View {
    @Binding var courseList: [Course]
    @Binding var selectedCourses: [Course]
    @Binding var favoriteCourses: [Course]
    @State private var searchText = ""
    @State private var filter = CourseFilter()
    @State private var isFilterBarExpanded = false
    @State private var showAlert = false
    @State private var courseToUnenroll: Course?
    @State private var courseConflict: Course? = nil
    @Binding var isThirdLevelViewActive: Bool
    @Binding var CoursesAlreadyInTheSchedule: [Course]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack(alignment: .top) {
                    List {
                        ForEach(courseList.filter {
                            (searchText.isEmpty || $0.name.localizedStandardContains(searchText)) &&
                            filter.isMatch($0, selectedCourses: selectedCourses, favoriteCourses: favoriteCourses)
                        }) { course in
                            courseRow(course: course)
                        }
                        
                        Color.white
                            .frame(height: 70)
                    }
                    .listStyle(.plain)
                    .padding(.top, isFilterBarExpanded ? 160 : 60)
                    
                    VStack {
                        HStack {
                            SearchBar(text: $searchText)
                                .frame(width: geometry.size.width * 0.77)
                            
                            Button(action: {
                                isFilterBarExpanded.toggle()
                            }) {
                                Text("篩選")
                                    .fontWeight(.bold)
                                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                    .background(Color(.systemGray6))
                                    .foregroundColor(.blue)
                                    .cornerRadius(10)
                            }
                        }
                        
                        HStack {
                            Spacer()
                            FilterBar(filter: $filter, courseList: $courseList, selectedCourses: $selectedCourses, favoriteCourses: $favoriteCourses, isExpanded: $isFilterBarExpanded)
                            Spacer()
                        }
                    }
                    
                    Color(red: 247/255, green: 248/255, blue: 247/255)
                        .frame(width: 1000, height: 100)
                        .position(y: 800)
                }
                .background(Color.white)
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarTitle("普通課程", displayMode: .inline)
            }
            .onAppear {
                for course in CoursesAlreadyInTheSchedule {
                    if selectedCourses.firstIndex(where: { $0 == course }) == nil {
                        selectedCourses.append(course)
                    }
                }
            }
            .navigationViewStyle(.stack)
        }
    }
    
    // 新增一個方法用於顯示課程行
    private func courseRow(course: Course) -> some View {
        let isSelected = selectedCourses.contains(course)
        let isFavorite = favoriteCourses.contains(course) // 檢查課程是否已經被收藏
        
        return HStack {
            NavigationLink(destination: CourseDetailView(course: course, selectedCourses: $selectedCourses).navigationBarBackButtonHidden(true).navigationBarTitle(""), isActive: $isThirdLevelViewActive) {
                TextImageRow(course: course, isSelected: isSelected, isFavorite: isFavorite)
            }
            .isDetailLink(false)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                if isSelected {
                    Button(action: {
                        courseToUnenroll = course
                        showAlert = true
                    }) {
                        Label("退選", systemImage: "minus")
                    }
                    .tint(.red)
                } else {
                    Button(action: {
                        addSelectedCourse(course)
                    }) {
                        Label("加選", systemImage: "plus")
                    }
                    .tint(.green)
                }

                if isFavorite {
                    Button(action: {
                        removeFavoriteCourse(course)
                    }) {
                        Label("取消收藏", systemImage: "star.slash")
                    }
                    .tint(.yellow)
                } else {
                    Button(action: {
                        addFavoriteCourse(course)
                    }) {
                        Label("收藏", systemImage: "star")
                    }
                    .tint(.yellow)
                }
            }
        .alert(isPresented: $showAlert) {
            if let conflictCourse = courseConflict {
                return Alert(title: Text("衝堂警告"),
                             message: Text("課程「\(course.name)」與已選課程「\(conflictCourse.name)」衝堂。"),
                             dismissButton: .default(Text("確認")))
            } else {
                return Alert(title: Text("確認退選"),
                             message: Text("您確定要退選這門課程嗎？"),
                             primaryButton: .destructive(Text("退選")) {
                    removeSelectedCourse(courseToUnenroll!)
                },
                             secondaryButton: .cancel())
            }
        }
    }

    
    private func hasCourseConflict(_ newCourse: Course) -> (Bool, Course?) {
        for selectedCourse in selectedCourses {
            for newCourseTime in newCourse.schedule {
                if selectedCourse.schedule.contains(newCourseTime) {
                    return (true, selectedCourse)
                }
            }
        }
        return (false, nil)
    }
    
    // 新增一個方法用於添加選定的課程
    private func addSelectedCourse(_ course: Course) {
        let (hasConflict, conflictCourse) = hasCourseConflict(course)
        if hasConflict {
            showAlert = true
            courseConflict = conflictCourse
        } else {
            if selectedCourses.firstIndex(where: { $0 == course }) == nil {
                selectedCourses.append(course)
            }
        }
    }
    
    private func removeSelectedCourse(_ course: Course) {
        if let index = selectedCourses.firstIndex(where: { $0 == course }) {
            selectedCourses.remove(at: index)
        }
    }
    
    private func addFavoriteCourse(_ course: Course) {
        if favoriteCourses.firstIndex(where: { $0 == course }) == nil {
            favoriteCourses.append(course)
        }
    }
    
    private func removeFavoriteCourse(_ course: Course) {
        if let index = favoriteCourses.firstIndex(where: { $0 == course }) {
            favoriteCourses.remove(at: index)
        }
    }
}


struct GeneralCourseView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralCourseView(courseList: .constant([
            Course(id: "B0001", name: "通識測試1", shortName: "通識測試1", department: "必修", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [303, 304], place: "", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
            Course(id: "B0002", name: "通識測試2", shortName: "通識測試2", department: "通識", introduction: "", language: "國語", type: "藝術", credits: 2, hour: 2, schedule: [501, 502, 503], place: "", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
            Course(id: "B0003", name: "通識測試3", shortName: "通識測試2", department: "通識", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [501, 502, 201], place: "", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0")
        ]),selectedCourses: Binding.constant([]), favoriteCourses: Binding.constant([]), isThirdLevelViewActive: Binding.constant(false), CoursesAlreadyInTheSchedule: Binding.constant([]))
    }
}
