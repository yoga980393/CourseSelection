//
//  HomePageView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct HomePageView: View {
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
                        NavigationLink(destination: MainCourseSelectionView().navigationBarBackButtonHidden(true).navigationBarTitle("")) {
                            ImageRow(imageName: "001", name: "選課系統", location: "選課系統", width: imageRowWidth)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: GradingView().navigationBarBackButtonHidden(true).navigationBarTitle("")) {
                            ImageRow(imageName: "002", name: "成績查詢", location: "歷年成績、畢業門檻", width: imageRowWidth)
                        }
                    }
                    
                    HStack {
                        NavigationLink(destination: ScheduleView(selectedCourses: .constant([
                            Course(id: "B0001", name: "通識測試1", shortName: "通識測試1", department: "必修", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [303, 304], place: "E101", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
                            Course(id: "B0002", name: "通識測試2", shortName: "通識測試2", department: "通識", introduction: "", language: "國語", type: "藝術", credits: 2, hour: 2, schedule: [501, 502, 503], place: "E202", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0"),
                            Course(id: "B0003", name: "通識測試3", shortName: "通識測試3", department: "通識", introduction: "", language: "國語", type: "人文", credits: 2, hour: 2, schedule: [401, 402, 505], place: "E303", numberOfPeople: 50, maxOfPeople: 60, teacher: "張三", image: "test0")
                        ])).navigationBarBackButtonHidden(true).navigationBarTitle("")) {
                            ImageRow(imageName: "003", name: "目前課表", location: "課表、上課提醒", width: imageRowWidth)
                        }
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            ImageRow(imageName: "004", name: "系統設定", location: "通知設定、帳號設定", width: imageRowWidth)
                        }
                    }
                }
                .padding(.horizontal, screenWidth * 0.04)
            }
        }
    }
}


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}


