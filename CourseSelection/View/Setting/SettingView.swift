//
//  Settingview.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/8.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var themeSettings: ThemeSettings
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    Section(header: Text("帳號")) {
                        HStack {
                            Image("profile_picture")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("姓名")
                                    .font(.headline)
                                Text("帳號資料")
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                    Section(header: Text("顯示設定")) {
                        Toggle(isOn: $themeSettings.isDarkMode) { // 修改此行
                                                Text("黑夜模式")
                                            }
                        
                        NavigationLink(destination: ColorSettingView()) {
                            Text("系統顏色設定")
                        }
                    }
                    
                    Section {
                        Button("登出") {
                            // 登出功能
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("設定")
            }
            .environment(\.colorScheme, themeSettings.isDarkMode ? .dark : .light)
            
            VStack {
                HStack {
                    CustomBackButton(action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .padding(.top, -5)
        }
    }
}

struct ColorSettingView: View {
    var body: some View {
        Text("系統顏色設定")
            .navigationTitle("顏色設定")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(ThemeSettings())
    }
}
