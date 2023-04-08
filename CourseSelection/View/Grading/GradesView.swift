//
//  GradesView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct GradesView: View {
    @Binding var score: [Score]
    @Binding var temp: Int
    @Binding var switch3: Bool
    
    @State private var selectedSemester: String? = nil
    
    private var uniqueSemesters: [String] {
        var semesters: [String] = []
        for item in score {
            let semester = "\(item.year) \(item.semester)"
            if !semesters.contains(semester) {
                semesters.append(semester)
            }
        }
        return semesters
    }
    
    private var filteredScoreIndices: [Int] {
        score.indices.filter { selectedSemester == nil || selectedSemester == "\(score[$0].year) \(score[$0].semester)" }
    }
    
    var body: some View {
        ZStack {
            List {
                GradesHeaderView(uniqueSemesters: uniqueSemesters, selectedSemester: $selectedSemester)

                ForEach(filteredScoreIndices, id: \.self) { index in
                    GradeRow(grade: score[index], temp: $temp, switch3: $switch3, index: index)
                }
            }
            .listStyle(.grouped)
        }
    }
}


struct GradesHeaderView: View {
    let uniqueSemesters: [String]
    @Binding var selectedSemester: String?
    @EnvironmentObject var themeSettings: ThemeSettings

    var body: some View {
        HStack {
            Menu {
                ForEach(uniqueSemesters, id: \.self) { semester in
                    Button(action: {
                        selectedSemester = semester
                    }) {
                        Text(semester)
                    }
                }
                Button(action: {
                    selectedSemester = nil
                }) {
                    Text("全部")
                }
            } label: {
                HStack {
                    Text("學期")
                    Image(systemName: "chevron.down")
                }
                .foregroundColor(themeSettings.accentColor)
            }
            .frame(minWidth: 0, maxWidth: .infinity)

            Text("名稱")
                .frame(minWidth: 0, maxWidth: .infinity)
            Text("學分")
                .frame(minWidth: 0, maxWidth: .infinity)
            Text("成績")
                .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

struct GradeRow: View {
    let grade: Score
    @Binding var temp: Int
    @Binding var switch3: Bool
    let index: Int
    @EnvironmentObject var themeSettings: ThemeSettings

    var body: some View {
        HStack {
            Group {
                Text("\(grade.year) \(grade.semester)")
                Text(grade.name)
                    .font(.system(size: 15))
                Text("\(grade.credits)")
                Text("\(grade.score)")
                    .foregroundColor(grade.score > 60 ? .green : .red)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .listRowBackground(index % 2 == 0 ? themeSettings.isDarkMode ? Color.gray : Color("light grey") : themeSettings.isDarkMode ? Color.black : Color.white)
        .onTapGesture {
            temp = index
            withAnimation {
                switch3.toggle()
            }
        }
    }
}


struct GradesView_Previews: PreviewProvider {
    static var previews: some View {
        GradesView(score: Binding.constant([Score(year: 109, semester: "上", number: "104B02117", department: "資訊工程學系", name: "程式設計實習(一)", type: "必修", credits: 1, score: 92),Score(year: 109, semester: "下", number: "094B02208", department: "資訊工程學系", name: "C++程式設計", type: "必修", credits: 3, score: 92),Score(year: 110, semester: "上", number: "105B02307", department: "資訊工程學系", name: "軟體工程", type: "必修", credits: 3, score: 10),Score(year: 110, semester: "下", number: "106B91X03", department: "通識教育中心", name: "社會習查：城市旅行", type: "核心通識", credits: 2, score: 83),Score(year: 110, semester: "下", number: "110B02302", department: "資訊工程學系", name: "互動設計", type: "選修", credits: 3, score: 96)]), temp: Binding.constant(0), switch3: Binding.constant(false))
            .environmentObject(ThemeSettings())
//            .preferredColorScheme(.dark)
    }
}
