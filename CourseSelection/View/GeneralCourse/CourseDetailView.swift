//
//  CourseDetailView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/3/26.
//

import SwiftUI

struct CourseDetailView: View {
    var course: Course
    @Binding var selectedCourses: [Course]
    @State private var showAlert = false
    
    var body: some View {
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        CourseImageHeader(course: course)
                        Text(course.introduction)
                            .padding()

                        CourseInfo(course: course)
                            .padding(.horizontal)
                    }
                }
                .edgesIgnoringSafeArea(.top)
                .alert(isPresented: $showAlert) {
                            Alert(title: Text("確認退選"),
                                  message: Text("您確定要退選這門課程嗎？"),
                                  primaryButton: .destructive(Text("確認")) {
                                      selectedCourses.removeAll(where: { $0 == course })
                                  },
                                  secondaryButton: .cancel(Text("取消")))
                        }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            toggleEnrollment()
                        }) {
                            Text(selectedCourses.contains(course) ? "退選" : "加選")
                                .frame(width: 120, height: 44)
                                .background(selectedCourses.contains(course) ? Color.red : Color.blue)
                                .foregroundColor(.white)
                                .font(.system(size: 20, design: .rounded))
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                }
            }
        }
    
    private func toggleEnrollment() {
        if selectedCourses.contains(course) {
            showAlert = true
        } else {
            selectedCourses.append(course)
        }
    }
}

struct CourseImageHeader: View {
    var course: Course
    
    var body: some View {
        Image(course.image)
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 445)
            .overlay(
                VStack(alignment: .leading, spacing: 5) {
                    Spacer()
                    Text(course.name)
                        .font(.custom("Nunito-Regular", size: 35, relativeTo: .largeTitle))
                        .bold()
                    Text(course.id)
                        .font(.custom("Nunito-Regular", size: 20, relativeTo: .largeTitle))
                        .bold()
                    HStack {
                        CourseInfoTag(text: course.department)
                        CourseInfoTag(text: course.type)
                        CourseInfoTag(text: course.language)
                        CourseInfoTag(text: "\(course.credits)學分")
                    }
                }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .foregroundColor(.white)
            )
    }
}


struct CourseInfoTag: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(.headline, design: .rounded))
            .padding(.all, 5)
            .background(Color.black)
    }
}

struct CourseInfo: View {
    var course: Course
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("時間/地點")
                    .font(.system(.headline, design: .rounded))
                
                ForEach(displaySchedule(course: course), id: \.self) { scheduleText in
                    Text(scheduleText)
                }
                
                Text(course.place)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading) {
                Text("教師")
                    .font(.system(.headline, design: .rounded))
                Text("\(course.teacher) 老師")
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
    }
}



struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailView(course: Course(id: "B0001", name: "通識測試1", shortName: "通識測試1", department: "必修", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [501, 502], place: "123", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"), selectedCourses: Binding.constant([]))
    }
}
