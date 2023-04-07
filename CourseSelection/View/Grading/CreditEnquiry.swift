//
//  CreditEnquiry.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct CreditEnquiry: View {
    @State var x: [CGFloat] = [5, 105, 155, 205, 85, 145]
    @State var y: [CGFloat] = [5, 30, 100, 125, 195, 220, 290, 315, 385]
    @State var wordX: [CGFloat] = [55, 155, 105, 105, 45, 115, 175]
    @State var wordY: [CGFloat] = [65, 65, 160, 255, 350, 350, 350]
    @State var title: [String] = ["學年/學期", "課規課號", "開課系所", "課程名稱", "課程類別", "學分數", "成績"]
    @State var score: Score
    
    var body: some View {
        Color.white
            .frame(width: 210, height: 390)
            .overlay {
                Path { path in
                    path.addRects([CGRect(x: x[0], y: y[0], width: 200, height: 380)])
                    for i in 1...7 {
                        path.move(to: CGPoint(x:x[0], y:y[i]))
                        path.addLine(to:CGPoint(x:x[3], y:y[i]))
                    }
                    path.move(to: CGPoint(x:x[1], y:y[0]))
                    path.addLine(to:CGPoint(x:x[1], y:y[2]))
                    path.move(to: CGPoint(x:x[4], y:y[6]))
                    path.addLine(to:CGPoint(x:x[4], y:y[8]))
                    path.move(to: CGPoint(x:x[5], y:y[6]))
                    path.addLine(to:CGPoint(x:x[5], y:y[8]))
                }
                .stroke(.gray, lineWidth: 1)
                .overlay {
                    ForEach(title.indices, id: \.self) { index in
                        Text(title[index])
                            .position(x: wordX[index], y: wordY[index] - 47.5)
                    }
                    Text("\(score.year) \(score.semester)")
                        .position(x: wordX[0], y: wordY[0])
                    Text(score.number)
                        .position(x: wordX[1], y: wordY[1])
                    Text(score.department)
                        .position(x: wordX[2], y: wordY[2])
                    Text(score.name)
                        .position(x: wordX[3], y: wordY[3])
                    Text(score.type)
                        .position(x: wordX[4], y: wordY[4])
                    Text("\(score.credits)")
                        .position(x: wordX[5], y: wordY[5])
                    Text("\(score.score)")
                        .position(x: wordX[6], y: wordY[6])
                        .foregroundColor(score.score > 60 ? .green : .red)
                }
            }
    }
}

struct CreditEnquiry_Previews: PreviewProvider {
    static var previews: some View {
        CreditEnquiry(score: Score(year: 109, semester: "上", number: "104B02117", department: "資訊工程學系", name: "程式設計實習(一)", type: "必修", credits: 1, score: 92))
    }
}
