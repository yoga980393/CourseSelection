//
//  CreditsView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct CreditsView: View {
    let SCwidth: CGFloat = UIScreen.main.bounds.width - 10
    let wordX: [CGFloat] = [
        (UIScreen.main.bounds.width - 10) * 0.55 + 5,
        (UIScreen.main.bounds.width - 10) * 0.85 + 5
    ]
    let wordY: [CGFloat] = [75, 155, 235, 315, 395, 475, 555, 635]
    
    @State var due: [Int] = [43, 48, 9, 22, 6, 4, 2, 128]
    @State var GeneralStudies: [Int] = [2, 2, 2, 0, 2, 2, 10, 6]
    @State var PE: [String] = ["2", "2", "通過", "未通過"]
    @Binding var switch1: Bool
    @Binding var switch2: Bool
    @Binding var got: [Int]
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var body: some View {
        GraduationThreshold()
            .overlay {
                ZStack {
                    ForEach(0..<8) { index in
                        if(index == 5 || index == 6) {
                            Text("\(got[index]) 門課")
                                .position(x: wordX[0], y: wordY[index])
                            Text("\(due[index]) 門課")
                                .position(x: wordX[1], y: wordY[index])
                        }else{
                            Text("\(got[index]) 學分")
                                .position(x: wordX[0], y: wordY[index])
                            Text("\(due[index]) 學分")
                                .position(x: wordX[1], y: wordY[index])
                        }
                    }
                    
                    Text(textHoldUp(oldStr: "", maxLength: 0))
                        .foregroundColor(.black.opacity(0.1))
                        .frame(width: SCwidth * 0.2 - 5, height: 75)
                        .background(themeSettings.isDarkMode ? .white.opacity(0.2):.gray.opacity(0.2))
                        .cornerRadius(5)
                        .position(x: SCwidth * 0.3 + 5, y: wordY[3])
                        .onTapGesture {
                            withAnimation {
                                switch1.toggle()
                            }
                        }
                    
                    Text(textHoldUp(oldStr: "", maxLength: 0))
                        .foregroundColor(.black.opacity(0.1))
                        .frame(width: SCwidth * 0.2 - 5, height: 75)
                        .background(themeSettings.isDarkMode ? .white.opacity(0.2):.gray.opacity(0.2))
                        .cornerRadius(5)
                        .position(x: SCwidth * 0.3 + 5, y: wordY[5])
                        .onTapGesture {
                            withAnimation {
                                switch2.toggle()
                            }
                        }
                }
            }
            .offset(y: 40)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView(switch1: Binding.constant(false), switch2: Binding.constant(false), got: Binding.constant([0, 0, 0, 0, 0, 0, 0, 0]))
            .environmentObject(ThemeSettings())
    }
}
