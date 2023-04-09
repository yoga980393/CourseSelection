//
//  GeneralStudiesImageRow.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/9.
//

import SwiftUI

struct GeneralStudiesImageRow: View {
    @State var course: Course
    @EnvironmentObject var themeSettings: ThemeSettings
    
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
        }
        .frame(width: UIScreen.main.bounds.width - 10,height: 105)
        .environment(\.colorScheme, themeSettings.isDarkMode ? .dark : .light)
    }
}

struct GeneralStudiesImageRow_Previews: PreviewProvider {
    static var previews: some View {
        GeneralStudiesImageRow(course: Course(id: "B0001", name: "通識測試2", shortName: "通識測試1", department: "通識", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [501, 502, 201], place: "", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"))
            .environmentObject(ThemeSettings())
    }
}
