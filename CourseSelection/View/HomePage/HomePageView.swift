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
                let imageHeight = screenHeight * 0.30
                
                VStack {
                    Button {
                        
                    } label: {
                        FullImageRow(imageName: "000", name: "中華大學", location: "學校資訊、常用網站", height: imageHeight)
                    }
                    
                    HStack {
                        NavigationLink(destination: MainCourseSelectionView().navigationBarBackButtonHidden(true).navigationBarTitle("")) {
                            ImageRow(imageName: "001", name: "選課系統", location: "選課系統", width: imageRowWidth)
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            ImageRow(imageName: "002", name: "成績查詢", location: "歷年成績、畢業門檻", width: imageRowWidth)
                        }
                    }
                    
                    HStack {
                        Button {
                            
                        } label: {
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


