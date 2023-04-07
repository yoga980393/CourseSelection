//
//  GeneralStudies.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct GeneralStudies: View {
    @State var x: [CGFloat] = [5, 85, 165, 245, 325]
    @State var y: [CGFloat] = [5, 55, 105, 155, 205, 255]
    @State var list1: [String] = ["社會關懷", "創新創意", "健康促進", "合計"]
    @State var list2: [String] = ["人文涵養", "藝術感知", "自我探索", "社會習查", "科學探究", "生醫衛保"]
    @State var GeneralStudies: [Int]
    
    var body: some View {
        Color.white
            .frame(width: 330, height: 260)
            .overlay {
                Path { path in
                    path.addRects([CGRect(x: x[0], y: y[0], width: 80, height: 200)])
                    path.addRects([CGRect(x: x[1], y: y[0], width: 240, height: 50)])
                    path.addRects([CGRect(x: x[1], y: y[1], width: 240, height: 50)])
                    path.addRects([CGRect(x: x[1], y: y[2], width: 240, height: 50)])
                    path.addRects([CGRect(x: x[1], y: y[3], width: 240, height: 50)])
                    path.addRects([CGRect(x: x[1], y: y[4], width: 240, height: 50)])
                    path.addRects([CGRect(x: x[0], y: y[4], width: 80, height: 50)])
                    path.move(to: CGPoint(x:x[2], y:y[0]))
                    path.addLine(to:CGPoint(x:x[2], y:y[4]))
                    path.move(to: CGPoint(x:x[3], y:y[0]))
                    path.addLine(to:CGPoint(x:x[3], y:y[3]))
                    path.move(to: CGPoint(x:x[2], y:y[0] + 25))
                    path.addLine(to:CGPoint(x:x[4], y:y[0] + 25))
                    path.move(to: CGPoint(x:x[2], y:y[1] + 25))
                    path.addLine(to:CGPoint(x:x[4], y:y[1] + 25))
                    path.move(to: CGPoint(x:x[2], y:y[2] + 25))
                    path.addLine(to:CGPoint(x:x[4], y:y[2] + 25))
                }
                .stroke(.gray, lineWidth: 1)
                .overlay {
                    ZStack {
                        Text("核心通識")
                            .position(x: x[0] + 40, y: y[2])
                        Text("多元通識")
                            .position(x: x[0] + 40, y: y[4] + 25)
                        ForEach(0..<4) { index in
                            Text(list1[index])
                                .position(x: x[1] + 40, y: y[index] + 25)
                        }
                        ForEach(0..<3) { index in
                            Text(list2[index])
                                .font(.system(size: 15))
                                .position(x: x[2] + 40, y: y[index] + 12.5)
                        }
                        ForEach(3..<6) { index in
                            Text(list2[index])
                                .font(.system(size: 15))
                                .position(x: x[3] + 40, y: y[index - 3] + 12.5)
                        }
                        ForEach(0..<3) { index in
                            Text("\(GeneralStudies[index]) 學分")
                                .font(.system(size: 15))
                                .position(x: x[2] + 40, y: y[index] + 37.5)
                        }
                        ForEach(3..<6) { index in
                            Text("\(GeneralStudies[index]) 學分")
                                .font(.system(size: 15))
                                .position(x: x[3] + 40, y: y[index - 3] + 37.5)
                        }
                        Text("\(GeneralStudies[6]) 學分")
                            .position(x: x[3], y: y[3] + 25)
                        Text("\(GeneralStudies[7]) 學分")
                            .position(x: x[2] + 40, y: y[4] + 25)
                    }
                }

            }
    }
}

struct GeneralStudies_Previews: PreviewProvider {
    static var previews: some View {
        GeneralStudies(GeneralStudies: [2, 2, 2, 0, 2, 2, 10, 6])
    }
}
