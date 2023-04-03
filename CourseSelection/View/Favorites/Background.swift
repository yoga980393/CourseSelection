//
//  Background.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/3.
//

import SwiftUI

struct Background: View {
    let rowHeight: CGFloat = 80
    let daysOfWeek: [String] = ["一", "二", "三", "四", "五"]
    let time: [Time] = [Time(clause: "一", period: "8:30~9:20"), Time(clause: "二", period: "9:25~10:25"), Time(clause: "三", period: "10:25~11:15"), Time(clause: "四", period: "11:20~12:10"), Time(clause: "五", period: "13:10~14:00"), Time(clause: "六", period: "14:10~15:00"), Time(clause: "七", period: "15:10~16:00"), Time(clause: "八", period: "16:10~17:00"), Time(clause: "九", period: "17:05~17:55"), Time(clause: "Ａ", period: "18:00~18:45"), Time(clause: "Ｂ", period: "18:45~19:30"), Time(clause: "Ｃ", period: "19:40~20:25"), Time(clause: "Ｄ", period: "20:25~21:10"), Time(clause: "Ｅ", period: "21:15~22:00")]
    
    var body: some View {
        GeometryReader { geometry in
            let tableWidth = geometry.size.width * 0.9
            let cellWidth = tableWidth / CGFloat(daysOfWeek.count + 1)
            let firstRowHeight: CGFloat = 25
            let cellHeight = rowHeight
            
            HStack{
                Spacer()
                ZStack {
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                    
                    verticalLines(tableWidth: tableWidth, cellWidth: cellWidth, firstRowHeight: firstRowHeight)
                    daysOfWeekLabels(tableWidth: tableWidth, cellWidth: cellWidth, firstRowHeight: firstRowHeight)
                    horizontalLines(tableWidth: tableWidth, firstRowHeight: firstRowHeight, cellHeight: cellHeight)
                    timeLabels(tableWidth: tableWidth, cellWidth: cellWidth, firstRowHeight: firstRowHeight, cellHeight: cellHeight)
                    
                    Path { path in
                        path.addRect(CGRect(x: 0, y: 0, width: tableWidth, height: firstRowHeight + cellHeight * CGFloat(time.count)))
                    }
                    .stroke(Color.gray, lineWidth: 1)
                }
                .frame(width: tableWidth)
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func verticalLines(tableWidth: CGFloat, cellWidth: CGFloat, firstRowHeight: CGFloat) -> some View {
        ForEach(0..<daysOfWeek.count) { index in
            Path { path in
                let xOffset = cellWidth * CGFloat(index + 1)
                path.move(to: CGPoint(x: xOffset, y: 0))
                path.addLine(to: CGPoint(x: xOffset, y: firstRowHeight + CGFloat(time.count) * rowHeight))
            }
            .stroke(Color.gray)
        }
    }
    
    @ViewBuilder
    private func daysOfWeekLabels(tableWidth: CGFloat, cellWidth: CGFloat, firstRowHeight: CGFloat) -> some View {
        ForEach(0..<daysOfWeek.count) { index in
            Text(daysOfWeek[index])
                .position(x: cellWidth * CGFloat(index + 1) + cellWidth / 2, y: firstRowHeight / 2)
        }
    }
    
    @ViewBuilder
    private func horizontalLines(tableWidth: CGFloat, firstRowHeight: CGFloat, cellHeight: CGFloat) -> some View {
        ForEach(0..<time.count + 1) { index in
            Path { path in
                let yOffset = firstRowHeight + cellHeight * CGFloat(index)
                path.move(to: CGPoint(x: 0, y: yOffset))
                path.addLine(to: CGPoint(x: tableWidth, y: yOffset))
            }
            .stroke(Color.gray)
        }
    }
    
    @ViewBuilder
    private func timeLabels(tableWidth: CGFloat, cellWidth: CGFloat, firstRowHeight: CGFloat, cellHeight: CGFloat) -> some View {
        ForEach(0..<time.count) { index in
            VStack {
                Text("第\(time[index].clause)節")
                Text(time[index].period)
                    .font(.system(size: 11))
            }
            .position(x: cellWidth / 2, y: firstRowHeight + cellHeight * CGFloat(index) + cellHeight / 2)
        }
    }
}



struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
