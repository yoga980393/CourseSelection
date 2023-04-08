//
//  PhysicalEducation.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct PhysicalEducation: View {
    @State var x: [CGFloat] = [5, 105, 205]
    @State var y: [CGFloat] = [5, 30, 100, 125, 195]
    @State var wordX: [CGFloat] = [55, 155, 55, 155]
    @State var wordY: [CGFloat] = [65, 65, 160, 160]
    @State var title: [String] = ["體育(一)(二)", "體育必修", "體適能", "游泳"]
    @Binding var PE: [String]
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var body: some View {
        Color(themeSettings.isDarkMode ? .black : .white)
            .frame(width: 210, height: 200)
            .overlay {
                Path { path in
                    path.addRects([CGRect(x: x[0], y: y[0], width: 200, height: 190)])
                    path.move(to: CGPoint(x:x[0], y:y[1]))
                    path.addLine(to:CGPoint(x:x[2], y:y[1]))
                    path.move(to: CGPoint(x:x[0], y:y[2]))
                    path.addLine(to:CGPoint(x:x[2], y:y[2]))
                    path.move(to: CGPoint(x:x[0], y:y[3]))
                    path.addLine(to:CGPoint(x:x[2], y:y[3]))
                    path.move(to: CGPoint(x:x[1], y:y[0]))
                    path.addLine(to:CGPoint(x:x[1], y:y[4]))
                }
                .stroke(.gray, lineWidth: 1)
                .overlay {
                    ForEach(title.indices, id: \.self) { index in
                        Text(title[index])
                            .position(x: wordX[index], y: wordY[index] - 47.5)
                    }
                    Text("\(PE[0]) 門課")
                        .position(x: wordX[0], y: wordY[0])
                    Text("\(PE[1]) 門課")
                        .position(x: wordX[1], y: wordY[1])
                    Text("\(PE[2])")
                        .position(x: wordX[2], y: wordY[2])
                    Text("\(PE[3])")
                        .position(x: wordX[3], y: wordY[3])
                }
            }
    }
}
