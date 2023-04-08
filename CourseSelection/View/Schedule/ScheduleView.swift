//
//  ScheduleView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/7.
//

import SwiftUI

struct ScheduleView: View {
    @Binding var selectedCourses: [Course]
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var themeSettings: ThemeSettings
    
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
        ZStack {
            NavigationView {
                GeometryReader { geometry in
                    ZStack {
                        ScrollView {
                            ZStack {
                                Color(themeSettings.isDarkMode ? .black : .white)
                                
                                Background()
                                    .frame(height: 1200)
                                
                                courseBlocks
                            }
                        }
                    }
                    .navigationBarTitle("目前課表", displayMode: .inline)
                }
            }
            
            VStack {
                HStack {
                    CustomBackButton(action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .padding(.top, -5)
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
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(themeSettings.isDarkMode ? .white : .black, lineWidth: 1))
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
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(selectedCourses: .constant([
            Course(id: "B0001", name: "通識測試1", shortName: "通識測試1", department: "必修", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [303, 304], place: "E101", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
            Course(id: "B0002", name: "通識測試2", shortName: "通識測試2", department: "通識", introduction: "", language: "國語", type: "藝術", credits: 2, hour: 2, schedule: [501, 502, 503], place: "E202", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
            Course(id: "B0003", name: "通識測試3", shortName: "通識測試3", department: "通識", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [401, 402, 505], place: "E303", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0")
        ]))
        .environmentObject(ThemeSettings())
    }
}
