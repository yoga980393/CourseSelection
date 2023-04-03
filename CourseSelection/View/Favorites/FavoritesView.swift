//
//  FavoritesView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/3.
//
import SwiftUI

struct FavoritesView: View {
    @Binding var selectedCourses: [Course]
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
        ScrollView{
            ZStack {
                Color.white
                
                Background()
                    .frame(height: 1200)
                
                courseBlocks
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
}
struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(selectedCourses: .constant([
            Course(id: "B0001", name: "通識測試1", shortName: "通識測試1", department: "必修", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [303, 304], place: "E101", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
            Course(id: "B0002", name: "通識測試2", shortName: "通識測試2", department: "通識", introduction: "", language: "國語", type: "藝術", credits: 2, hour: 2, schedule: [501, 502, 503], place: "E202", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
            Course(id: "B0003", name: "通識測試3", shortName: "通識測試3", department: "通識", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [401, 402, 505], place: "E303", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0")
        ]))
    }
}
