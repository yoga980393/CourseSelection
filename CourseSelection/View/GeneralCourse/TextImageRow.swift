//
//  TextImageRow.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/3/20.
//

import SwiftUI

struct TextImageRow: View {
    @State var course: Course
    var isSelected: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            CourseImage(image: course.image)
            
            VStack(alignment: .leading) {
                CourseBasicInfo(course: course)
                
                ForEach(displaySchedule(course: course), id: \.self) { scheduleText in
                    Text(scheduleText)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                CourseTags(course: course)
            }
            
            
            if isSelected { // 在此添加條件標記
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
        }
        .frame(width: .infinity, height: 105)
    }
}


struct CourseImage: View {
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 120, height: 118)
            .cornerRadius(20)
    }
}

struct CourseBasicInfo: View {
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(course.name)
                .font(.system(size: 20))
            
            Text("\(course.teacher) 老師")
                .font(.system(size: 15))
                .foregroundColor(.gray)
        }
    }
}

struct CourseTags: View {
    let course: Course
    
    var body: some View {
        HStack{
            TagText(text: course.department)
            TagText(text: course.type)
            TagText(text: course.language)
            TagText(text: "\(course.credits)學分")
        }
    }
}

struct TagText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: text.count > 3 ? 14 : 15))
            .foregroundColor(.white)
            .padding(.all, text.count > 3 ? 4 : 3)
            .background(Color.black)
            .cornerRadius(5)
    }
}


struct TextImageRow_Previews: PreviewProvider {
    static var previews: some View {
        TextImageRow(course: Course(id: "B0001", name: "通識測試2", shortName: "通識測試1", department: "通識", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [501, 502, 201], place: "", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),isSelected: true)
    }
}
