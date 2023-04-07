//
//  GraduationThreshold.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct GraduationThreshold: View {
    let SCwidth: CGFloat = UIScreen.main.bounds.width - 10
    let x: [CGFloat] = [
        5,
        (UIScreen.main.bounds.width - 10) * 0.2 + 5,
        (UIScreen.main.bounds.width - 10) * 0.4 + 5,
        (UIScreen.main.bounds.width - 10) * 0.7 + 5,
        UIScreen.main.bounds.width - 10 + 5
    ]
    @State var y: [CGFloat] = [10, 35, 115, 275, 595, 675]
    @State var wordY: [CGFloat] = [75, 155, 235, 315, 395, 475, 555, 635]
    @State var title: [String] = ["名稱", "已得", "應得"]
    @State var detail: [String] = ["必修", "選修", "共同必修", "本系", "外系", "通識", "英文", "體育", "軍訓", "總學分數"]
    
    var body: some View {
        Path { path in
            for i in 0...4 {
                path.addRects([CGRect(x: 5, y: y[i], width: SCwidth, height: y[i+1] - y[i])])
            }
            path.move(to: CGPoint(x:x[1], y:y[2]))
            path.addLine(to:CGPoint(x:x[1], y:y[4]))
            path.move(to: CGPoint(x:x[2], y:y[0]))
            path.addLine(to:CGPoint(x:x[2], y:y[5]))
            path.move(to: CGPoint(x:x[3], y:y[0]))
            path.addLine(to:CGPoint(x:x[3], y:y[5]))
            path.move(to: CGPoint(x:x[1], y:195))
            path.addLine(to:CGPoint(x:x[4], y:195))
            path.move(to: CGPoint(x:x[1], y:355))
            path.addLine(to:CGPoint(x:x[4], y:355))
            path.move(to: CGPoint(x:x[1], y:435))
            path.addLine(to:CGPoint(x:x[4], y:435))
            path.move(to: CGPoint(x:x[1], y:515))
            path.addLine(to:CGPoint(x:x[4], y:515))
        }
        .stroke(.gray, lineWidth: 1)
        .overlay {
            ZStack {
                Text(title[0])
                    .position(x: x[0] + (x[2] - x[0]) / 2, y: 22.5)
                Text(title[1])
                    .position(x: x[2] + (x[3] - x[2]) / 2, y: 22.5)
                Text(title[2])
                    .position(x: x[3] + (x[4] - x[3]) / 2, y: 22.5)
                Text(detail[0])
                    .position(x: x[0] + (x[2] - x[0]) / 2, y: y[1] + 40)
                Text(detail[1])
                    .position(x: x[0] + (x[1] - x[0]) / 2, y: y[2] + 80)
                Text(detail[2])
                    .position(x: x[0] + (x[1] - x[0]) / 2, y: y[3] + 160)
                ForEach(3..<7) { index in
                    Text(detail[index])
                        .position(x: x[1] + (x[2] - x[1]) / 2, y: wordY[index - 2])
                }
                Text("   \(detail[7])\n (0學分)")
                    .fixedSize()
                    .position(x: x[1] + (x[2] - x[1]) / 2, y: wordY[5])
                Text("   \(detail[8])\n (0學分)")
                    .position(x: x[1] + (x[2] - x[1]) / 2, y: wordY[6])
                Text(detail[9])
                    .position(x: x[0] + (x[2] - x[0]) / 2, y: y[4] + 40)
            }
        }
    }
}

struct GraduationThreshold_Previews: PreviewProvider {
    static var previews: some View {
        GraduationThreshold()
    }
}
