//
//  FavoritesView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/3.
//
import SwiftUI

struct FavoritesView: View {
    @Binding var selectedCourses: [Course]
    @Binding var favoriteCourses: [Course]
    @State private var showingFavoriteCoursesSheet = false
    
    let rowHeight: CGFloat = 80
    private let courseColors: [Color] = [
        Color(red: 255/255, green: 227/255, blue: 227/255),
        Color(red: 217/255, green: 255/255, blue: 227/255),
        Color(red: 217/255, green: 232/255, blue: 255/255),
        Color(red: 255/255, green: 255/255, blue: 217/255),
        Color(red: 255/255, green: 217/255, blue: 242/255),
        Color(red: 244/255, green: 217/255, blue: 255/255),
        Color(red: 217/255, green: 255/255, blue: 255/255)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    ZStack {
                        Color.white
                        
                        Background()
                            .frame(height: 1200)
                        
                        courseBlocks
                    }
                }
                favoriteCoursesButton(geometry: geometry) // 传递 geometry 参数
            }
            .sheet(isPresented: $showingFavoriteCoursesSheet) {
                FavoriteCoursesList(favoriteCourses: $favoriteCourses, selectedCourses: $selectedCourses)
            }
        }
    }
    
    private var courseBlocks: some View {
        ForEach(selectedCourses) { course in
            courseBlocksForCourse(course: course)
        }
    }
    
    private func courseBlocksForCourse(course: Course) -> some View {
        ForEach(Array(course.schedule.sorted().enumerated()), id: \.offset) { index, schedule in
            let showText = index == 0 || course.schedule[index - 1] != schedule - 1
            if let nextSchedule = course.schedule.first(where: { $0 == schedule + 1 }) {
                courseBlock(course: course, startSchedule: schedule, endSchedule: nextSchedule, showText: showText)
            } else {
                courseBlock(course: course, startSchedule: schedule, endSchedule: nil, showText: showText)
            }
        }
    }
    
    private func courseBlock(course: Course, startSchedule: Int, endSchedule: Int?, showText: Bool) -> some View {
        let day = (startSchedule / 100) - 1
        let classIndex = (startSchedule % 100) - 1
        let padding: CGFloat = 2
        
        var blockHeight = rowHeight - padding * 2
        if let endSchedule = endSchedule {
            let endIndex = (endSchedule % 100) - 1
            blockHeight = (CGFloat(endIndex - classIndex) + 1) * rowHeight - padding * 2
        }
        
        let maxTextLength = 8
        let singleBlock = blockHeight == rowHeight - padding * 2
        
        return ZStack {
            if let courseIndex = selectedCourses.firstIndex(of: course) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(courseColors[courseIndex % courseColors.count])
                    .frame(width: ((UIScreen.main.bounds.width * 0.9) / 6) - padding * 2, height: blockHeight)
                    .zIndex(0)
            } else {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray)
                    .frame(width: ((UIScreen.main.bounds.width * 0.9) / 6) - padding * 2, height: blockHeight)
                    .zIndex(0)
            }
            
            if showText {
                ZStack {
                    if singleBlock {
                        Text(textHoldUp(oldStr: course.shortName, maxLength: maxTextLength))
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .position(x: UIScreen.main.bounds.width * 0.46, y: 628)
                        
                        Text(textHoldUp(oldStr: course.place, maxLength: maxTextLength))
                            .font(.system(size: 10))
                            .foregroundColor(.black)
                            .position(x: UIScreen.main.bounds.width * 0.55, y: 620)
                    } else {
                        Text(textHoldUp(oldStr: course.shortName, maxLength: maxTextLength))
                            .font(.system(size: 13))
                            .foregroundColor(.black)
                            .position(x: UIScreen.main.bounds.width * 0.46, y: 595)
                            .zIndex(1)
                        
                        Text(textHoldUp(oldStr: course.place, maxLength: maxTextLength))
                            .font(.system(size: 10))
                            .foregroundColor(.black)
                            .position(x: UIScreen.main.bounds.width * 0.55, y: 580)
                    }
                }
                .zIndex(1)
            }
        }
        .position(x: ((UIScreen.main.bounds.width * 0.9) / 6) * CGFloat(day + 1) + ((UIScreen.main.bounds.width * 0.9) / 7.17), y: 25 + rowHeight * CGFloat(classIndex) + (blockHeight / 2) + padding)
    }
    
    private func favoriteCoursesButton(geometry: GeometryProxy) -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    // 按钮点击事件
                    showFavoriteCourses()
                }) {
                    Image(systemName: "list.bullet")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding(.trailing, geometry.size.width * 0.05) // 从屏幕右侧留出一定空间
                .padding(.bottom, geometry.safeAreaInsets.bottom) // 从屏幕底部留出一定空间
            }
        }
    }
    
    private func showFavoriteCourses() {
        showingFavoriteCoursesSheet = true
    }
}

struct FavoriteCoursesList: View {
    @Binding var favoriteCourses: [Course]
    @Binding var selectedCourses: [Course]
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAlert = false
    @State private var selectedCourse: Course?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favoriteCourses) { course in
                    Button(action: {
                        selectedCourse = course
                        showingAlert = true
                    }) {
                        TextImageRow(course: course, isSelected: false, isFavorite: false)
                    }
                }
            }
            .navigationTitle("收藏課程")
            .navigationBarItems(trailing: Button("關閉") {
                dismiss()
            })
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("加選確認"),
                    message: Text("是否加選\(selectedCourse?.name ?? "")?"),
                    primaryButton: .default(Text("確認"), action: {
                        addToSelectedCourses(course: selectedCourse!)
                    }),
                    secondaryButton: .cancel(Text("取消"))
                )
            }
        }
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func addToSelectedCourses(course: Course) {
        if let index = favoriteCourses.firstIndex(of: course) {
            favoriteCourses.remove(at: index)
            selectedCourses.append(course)
            dismiss()
        }
    }
}



struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(selectedCourses: .constant([
            Course(id: "B0001", name: "通識測試1", shortName: "通識測試1", department: "必修", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [303, 304], place: "E101", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
            Course(id: "B0002", name: "通識測試2", shortName: "通識測試2", department: "通識", introduction: "", language: "國語", type: "藝術", credits: 2, hour: 2, schedule: [501, 502, 503], place: "E202", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
            Course(id: "B0003", name: "通識測試3", shortName: "通識測試3", department: "通識", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [401, 402, 505], place: "E303", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0")
        ]), favoriteCourses: Binding.constant([]))
    }
}