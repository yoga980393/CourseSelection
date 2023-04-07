//
//  GradesView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct GradesView: View {
    @State var score: [Score]
    let titles = ["學期", "名稱", "學分", "成績"]
    @Binding var temp: Int
    @Binding var switch3: Bool
    
    var body: some View {
        ZStack {
            List {
                HStack {
                    ForEach(titles, id: \.self) { title in
                        Text(title)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }

                ForEach(score.indices, id: \.self) { index in
                    HStack {
                        Group {
                            Text("\(score[index].year) \(score[index].semester)")
                                .foregroundColor(.black)
                            Text(score[index].name)
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                            Text("\(score[index].credits)")
                                .foregroundColor(.black)
                            Text("\(score[index].score)")
                                .foregroundColor(score[index].score > 60 ? .green : .red)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .listRowBackground(index % 2 == 0 ? Color("light grey") : Color.white)
                    .onTapGesture {
                        temp = index
                        withAnimation {
                            switch3.toggle()
                        }
                    }
                }
            }
            .listStyle(.grouped)
        }
    }
}

struct GradesView_Previews: PreviewProvider {
    static var previews: some View {
        GradesView(score: [
            Score(year: 109, semester: "上", number: "104B02117", department: "資訊工程學系", name: "程式設計實習(一)", type: "必修", credits: 1, score: 92),
            Score(year: 109, semester: "下", number: "094B02208", department: "資訊工程學系", name: "C++程式設計", type: "必修", credits: 3, score: 92),
            Score(year: 110, semester: "上", number: "105B02307", department: "資訊工程學系", name: "軟體工程", type: "必修", credits: 3, score: 10),
            Score(year: 110, semester: "下", number: "106B91X03", department: "通識教育中心", name: "社會習查：城市旅行", type: "核心通識", credits: 2, score: 83),
            Score(year: 110, semester: "下", number: "110B02302", department: "資訊工程學系", name: "互動設計", type: "選修", credits: 3, score: 96),
        ],temp: Binding.constant(0), switch3: Binding.constant(false))
    }
}
