//
//  cardView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/7.
//

import SwiftUI

struct CardView: View {
    @State var information: Information
    @Binding var isShowContent: Bool
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                VStack(alignment: .leading) {
                    Image(information.image)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 445)
                        .cornerRadius(15)
                        .overlay(
                            SummaryView(information: information, isShowContent: $isShowContent)
                                .cornerRadius(self.isShowContent ? 0 : 15)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(themeSettings.isDarkMode ? Color.white : Color.clear, lineWidth: 1)
                        )
                    
                    if self.isShowContent {
                        Text("內容")
                            .foregroundColor(Color(.darkGray))
                            .font(.system(.body, design: .rounded))
                            .padding(.horizontal)
                            .padding(.bottom, 50)
                            .transition(.move(edge: .top))
                            .animation(.linear, value: 0)
                    }
                }
            }
            .shadow(color: Color(.sRGB, red: 64 / 255, green: 64 / 255, blue: 64 / 255, opacity: 0.3), radius: self.isShowContent ? 0 : 5)
            
            if self.isShowContent {
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            self.isShowContent.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 26))
                            .foregroundColor(.white)
                            .opacity(0.7)
                    }
                }
                .padding(.top, 50)
                .padding(.trailing)
            }
        }
        .offset(y: 50)
    }
}

struct SummaryView: View {
    @State var information: Information
    @Binding var isShowContent: Bool
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Rectangle()
                .frame(minHeight: 100, maxHeight: 120)
                .overlay(
                    HStack {
                        VStack(alignment: .leading) {
                            Text(information.type)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            Text(information.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .minimumScaleFactor(0.1)
                                .lineLimit(2)
                                .padding(.bottom, 5)
                                
                        if !self.isShowContent {
                                Text("詳情")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .minimumScaleFactor(0.1)
                                    .lineLimit(3)
                            }
                        }
                        .padding()
                        Spacer()
                    }
                )
        }
        .foregroundColor(themeSettings.isDarkMode ? .black:.white)
    }
}

struct cardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(information: Information(name: "中華大學官網", type: "學校", image: "chu01", url: "https://www.chu.edu.tw/"), isShowContent: Binding.constant(false))
            .environmentObject(ThemeSettings())
    }
}
