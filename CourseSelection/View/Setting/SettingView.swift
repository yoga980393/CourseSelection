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
    let colors: [String: Color] = ["藍色": .blue, "綠色": .green, "紅色": .red, "橙色": .orange, "紫色": .purple]
    @Binding var user: Account
    @Binding var isLoggedIn: Bool

    
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
                            
                            Spacer() // 新增 Spacer
                                .frame(width: 20) // 調整間隔寬度
                            
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
                        
                        HStack {
                            Text("系統顏色設定")
                            Spacer()
                            Picker("Accent Color", selection: $themeSettings.accentColor) {
                                ForEach(colors.keys.sorted(), id: \.self) { key in
                                    Text(key)
                                        .foregroundColor(colors[key])
                                        .tag(colors[key]!) // 添加 tag 修飾符
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                    
                    Section {
                        Button("登出") {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                user = Account(account: "", password: "", name: "")
                                isLoggedIn = false
                            }
                        }
                        .foregroundColor(themeSettings.accentColor)
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

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(user: Binding.constant(Account(account: "", password: "", name: "")), isLoggedIn: Binding.constant(true))
            .environmentObject(ThemeSettings())
    }
}

extension Color {
    var id: String {
        "\(self.description)"
    }
}
