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
        NavigationView {
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
                .navigationBarTitle("收藏夾", displayMode: .inline)
                .sheet(isPresented: $showingFavoriteCoursesSheet) {
                    FavoriteCoursesList(favoriteCourses: $favoriteCourses, selectedCourses: $selectedCourses)
                }
            }
        }
    }
    
    
    private var courseBlocks: some View {
        ForEach(selectedCourses) { course in
            courseBlocksForCourse(course: course)
        }
    }
    
    private func courseBlocksForCourse(course: Course) -> some View {
        let sortedSchedules = course.schedule.sorted()
        var startSchedule = sortedSchedules[0]
        var endSchedule: Int?
        var courseBlocks = [AnyView]()

        for i in 1..<sortedSchedules.count {
            let schedule = sortedSchedules[i]
            let prevSchedule = sortedSchedules[i - 1]

            if schedule != prevSchedule + 1 {
                endSchedule = prevSchedule
                let showText = true
                courseBlocks.append(AnyView(courseBlock(course: course, startSchedule: startSchedule, endSchedule: endSchedule, showText: showText)))
                startSchedule = schedule
                endSchedule = nil
            }
        }

        endSchedule = sortedSchedules.last
        let showText = true
        courseBlocks.append(AnyView(courseBlock(course: course, startSchedule: startSchedule, endSchedule: endSchedule, showText: showText)))

        return Group {
            ForEach(courseBlocks.indices, id: \.self) { index in
                courseBlocks[index]
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
        
        let length = (endSchedule.map { ($0 % 100) - 1 } ?? classIndex) - classIndex
        let yOffset: CGFloat
        switch length {
        case 0:
            yOffset = 0
        case 1:
            yOffset = 20
        case 2:
            yOffset = 60
        default:
            yOffset = 100
        }
        let shortNameFontSize: CGFloat
        let placeFontSize: CGFloat
        switch length {
        case 0:
            shortNameFontSize = 12
            placeFontSize = 10
        case 1:
            shortNameFontSize = 15
            placeFontSize = 13
        case 2:
            shortNameFontSize = 15
            placeFontSize = 13
        default:
            shortNameFontSize = 15
            placeFontSize = 13
        }
        
        return ZStack {
            let courseIndex = selectedCourses.firstIndex(of: course)!
            RoundedRectangle(cornerRadius: 5)
                .fill(courseColors[courseIndex % courseColors.count])
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
                .frame(width: ((UIScreen.main.bounds.width * 0.95) / 6) - padding * 2, height: blockHeight)

            
            if showText {
                ZStack {
                    Text(textHoldUp(oldStr: course.shortName, maxLength: maxTextLength))
                        .font(.system(size: shortNameFontSize))
                        .foregroundColor(.black)
                        .position(x: UIScreen.main.bounds.width * 0.46, y: 628 - yOffset)

                    Text(textHoldUp(oldStr: course.place, maxLength: maxTextLength))
                        .font(.system(size: placeFontSize))
                        .foregroundColor(.black)
                        .position(x: UIScreen.main.bounds.width * 0.55, y: 620 - yOffset)
                }
            }
        }
        .position(x: ((UIScreen.main.bounds.width * 0.95) / 6) * CGFloat(day + 1) + ((UIScreen.main.bounds.width * 0.95) / 9.1), y: 25 + rowHeight * CGFloat(classIndex) + (blockHeight / 2) + padding)
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
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertPrimaryButton: Alert.Button = .default(Text(""))
    @State private var secondaryButtonSwitch = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favoriteCourses) { course in
                    Button(action: {
                        addToSelectedCourses(course: course)
                    }) {
                        TextImageRow(course: course, isSelected: false, isFavorite: false)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                }
            }
            .navigationTitle("收藏課程")
            .navigationBarItems(trailing: Button("關閉") {
                dismiss()
            })
        }
        .alert(isPresented: $showAlert) {
            secondaryButtonCtrl()
        }
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func addToSelectedCourses(course: Course) {
        if let index = favoriteCourses.firstIndex(of: course) {
            if hasTimeConflict(course: course, selectedCourses: selectedCourses) {
                if let conflictingCourse = getConflictingCourse(course: course, selectedCourses: selectedCourses) {
                    showAlert = true
                    alertTitle = "衝堂提醒"
                    alertMessage = "課程「\(course.name)」與已選課程「\(conflictingCourse.name)」衝堂。"
                    alertPrimaryButton = .default(Text("確認"))
                    secondaryButtonSwitch = false
                }
            } else {
                showAlert = true
                alertTitle = "加選確認"
                alertMessage = "是否加選\(course.name)?"
                secondaryButtonSwitch = true
                alertPrimaryButton = .default(Text("確認"), action: {
                    favoriteCourses.remove(at: index)
                    selectedCourses.append(course)
                    dismiss()
                })
            }
        }
    }
    
    private func hasTimeConflict(course: Course, selectedCourses: [Course]) -> Bool {
        for selectedCourse in selectedCourses {
            if !Set(course.schedule).isDisjoint(with: Set(selectedCourse.schedule)) {
                return true
            }
        }
        return false
    }
    
    private func getConflictingCourse(course: Course, selectedCourses: [Course]) -> Course? {
        for selectedCourse in selectedCourses {
            if !Set(course.schedule).isDisjoint(with: Set(selectedCourse.schedule)) {
                return selectedCourse
            }
        }
        return nil
    }
    
    private func secondaryButtonCtrl() -> Alert{
        if(secondaryButtonSwitch){
            return Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                primaryButton: alertPrimaryButton,
                secondaryButton: .cancel(Text("取消"))
            )
        }
        else{
            return Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: alertPrimaryButton
            )
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(selectedCourses: .constant([
            Course(id: "B0001", name: "通識測試1", shortName: "通識測試1", department: "必修", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [303, 304], place: "E101", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
            Course(id: "B0002", name: "通識測試2", shortName: "通識測試2", department: "通識", introduction: "", language: "國語", type: "藝術", credits: 2, hour: 2, schedule: [501, 502, 503], place: "E202", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
            Course(id: "B0003", name: "通識測試3", shortName: "通識測試3", department: "通識", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [401, 402, 505], place: "E303", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0")
        ]), favoriteCourses: Binding.constant([Course(id: "B0001", name: "通識測試1", shortName: "通識測試1", department: "必修", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [303, 304], place: "E101", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
                                               Course(id: "B0002", name: "通識測試2", shortName: "通識測試2", department: "通識", introduction: "", language: "國語", type: "藝術", credits: 2, hour: 2, schedule: [501, 502, 503], place: "E202", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
                                               Course(id: "B0003", name: "通識測試3", shortName: "通識測試3", department: "通識", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [401, 402, 505], place: "E303", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0")]))
    }
}
