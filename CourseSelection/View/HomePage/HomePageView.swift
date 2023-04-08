//
//  HomePageView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct HomePageView: View {
    @State var CoursesAlreadyInTheSchedule: [Course] = []
    @Binding var user: Account
    @EnvironmentObject var themeSettings: ThemeSettings
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height
                let imageRowWidth = screenWidth * 0.45
                let imageHeight = screenHeight * 0.28
                
                VStack {
                    NavigationLink(destination: SchoolWebsiteView().navigationBarBackButtonHidden(true).navigationBarTitle("")) {
                        FullImageRow(imageName: "000", name: "中華大學", location: "學校資訊、常用網站", height: imageHeight)
                    }
                    
                    HStack {
                        NavigationLink(destination: MainCourseSelectionView(CoursesAlreadyInTheSchedule: $CoursesAlreadyInTheSchedule).navigationBarBackButtonHidden(true).navigationBarTitle("")) {
                            ImageRow(imageName: "001", name: "選課系統", location: "選課系統", width: imageRowWidth)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: GradingView().navigationBarBackButtonHidden(true).navigationBarTitle("")) {
                            ImageRow(imageName: "002", name: "成績查詢", location: "歷年成績、畢業門檻", width: imageRowWidth)
                        }
                    }
                    
                    HStack {
                        NavigationLink(destination: ScheduleView(selectedCourses: $CoursesAlreadyInTheSchedule).navigationBarBackButtonHidden(true).navigationBarTitle("")) {
                            ImageRow(imageName: "003", name: "目前課表", location: "課表、上課提醒", width: imageRowWidth)
                        }
                        Spacer()
                        
                        NavigationLink(destination: SettingView(user: $user, isLoggedIn: $isLoggedIn).navigationBarBackButtonHidden(true).navigationBarTitle("")) {
                            ImageRow(imageName: "004", name: "系統設定", location: "通知設定、帳號設定", width: imageRowWidth)
                        }
                    }
                }
                .padding(.horizontal, screenWidth * 0.04)
            }
        }
        .environment(\.colorScheme, themeSettings.isDarkMode ? .dark : .light)
        .onAppear {
            fetchData()
        }
    }
    
    func fetchData() {
        guard let url = URL(string: "https://raw.githubusercontent.com/yoga980393/jsonTest/main/CoursesAlreadyInTheSchedule.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Course].self, from: data)
                
                DispatchQueue.main.async {
                    self.CoursesAlreadyInTheSchedule = decodedData
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(user: Binding.constant(Account(account: "", password: "", name: "")), isLoggedIn: Binding.constant(true))
            .environmentObject(ThemeSettings())
    }
}


