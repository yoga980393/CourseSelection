//
//  GradingView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct GradingView: View {
    @State var score: [Score] = []
    @State private var selectedTab = 0
    @State var switch1: Bool = false
    @State var switch2: Bool = false
    @State var switch3: Bool = false
    @State var temp = 0
    @State var got: [Int] = [0, 0, 0, 0, 0, 0, 0, 0]
    @State var GeneralStudies: [Int] = [0, 0, 0, 0, 0, 0, 0, 0]
    @State var PE: [String] = ["", "", "", ""]
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                CreditsView(switch1: $switch1, switch2: $switch2, got: $got)
                    .tabItem {
                        Label("學分查詢", systemImage: "graduationcap.fill")
                    }
                    .tag(0)
                
                GradesView(score: $score, temp: $temp, switch3: $switch3)
                    .tabItem {
                        Label("成績查詢", systemImage: "chart.bar.fill")
                    }
                    .tag(1)
            }
            .accentColor(themeSettings.accentColor)
            .opacity(switch1 || switch2 || switch3 ? 0.5 : 1)
            .onAppear {
                fetchData()
                fetchData_score()
            }
            
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
            
            CourseSelection.GeneralStudies(GeneralStudies: $GeneralStudies)
                .cornerRadius(5)
                .opacity(!switch1 ? 0 : 1)
            
            CourseSelection.PhysicalEducation(PE: $PE)
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
    
    func fetchData() {
        guard let url = URL(string: "https://raw.githubusercontent.com/yoga980393/jsonTest/main/credit.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(CreditInfo.self, from: data)
                
                DispatchQueue.main.async {
                    self.got = creditInfoToArray(gotJson: decodedData)
                    self.GeneralStudies = generalEducationToArray(gotJson: decodedData)
                    self.PE = physicalEducationToArray(gotJson: decodedData)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func fetchData_score() {
        guard let url = URL(string: "https://raw.githubusercontent.com/yoga980393/jsonTest/main/Scores.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Score].self, from: data)
                
                DispatchQueue.main.async {
                    self.score = decodedData
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}


struct GradingView_Previews: PreviewProvider {
    static var previews: some View {
        GradingView()
            .environmentObject(ThemeSettings())
    }
}
