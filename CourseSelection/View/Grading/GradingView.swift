//
//  GradingView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct GradingView: View {
    @State var score: [Score] = [
        Score(year: 109, semester: "上", number: "104B02117", department: "資訊工程學系", name: "程式設計實習(一)", type: "必修", credits: 1, score: 92),
        Score(year: 109, semester: "下", number: "094B02208", department: "資訊工程學系", name: "C++程式設計", type: "必修", credits: 3, score: 92),
        Score(year: 110, semester: "上", number: "105B02307", department: "資訊工程學系", name: "軟體工程", type: "必修", credits: 3, score: 10),
        Score(year: 110, semester: "下", number: "106B91X03", department: "通識教育中心", name: "社會習查：城市旅行", type: "核心通識", credits: 2, score: 83),
        Score(year: 110, semester: "下", number: "110B02302", department: "資訊工程學系", name: "互動設計", type: "選修", credits: 3, score: 96),
    ]
    
    @State private var selectedTab = 0
    @State var switch1: Bool = false
    @State var switch2: Bool = false
    @State var switch3: Bool = false
    @State var temp = 0
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                CreditsView(switch1: $switch1, switch2: $switch2)
                    .tabItem {
                        Label("學分查詢", systemImage: "graduationcap.fill")
                    }
                    .tag(0)

                GradesView(score: score, temp: $temp, switch3: $switch3)
                    .tabItem {
                        Label("成績查詢", systemImage: "chart.bar.fill")
                    }
                    .tag(1)
            }
            .opacity(switch1 || switch2 || switch3 ? 0.5 : 1) // Change the opacity based on the switch values

            if(switch1 || switch2 || switch3) {
                Color.black
                    .opacity(0.1)
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            switch1 = false
                            switch2 = false
                            switch3 = false
                        }
                    }
            }
            
            CourseSelection.GeneralStudies(GeneralStudies: [2, 2, 2, 0, 2, 2, 10, 6])
                .cornerRadius(5)
                .opacity(!switch1 ? 0 : 1)
            
            CourseSelection.PhysicalEducation(PE: ["2", "2", "通過", "未通過"])
                .cornerRadius(5)
                .opacity(!switch2 ? 0 : 1)
            
            ForEach(score.indices, id: \.self) { index in
                if(index == temp) {
                    CourseSelection.CreditEnquiry(score: score[index])
                        .cornerRadius(5)
                        .opacity(!switch3 ? 0 : 1)
                }
            }
            
            VStack {
                HStack {
                    if(!switch1 && !switch2 && !switch3) {
                        CustomBackButton(action: {
                            presentationMode.wrappedValue.dismiss()
                        })
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .padding(.top, -5)
        }
    }
}


struct GradingView_Previews: PreviewProvider {
    static var previews: some View {
        GradingView()
    }
}
