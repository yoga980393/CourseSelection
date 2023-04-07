//
//  SchoolWebsite.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/7.
//
import SwiftUI

struct SchoolWebsiteView: View {
    var information = [
        Information(name: "中華大學官網", type: "學校", image: "chu01", url: "https://www.chu.edu.tw/"),
        Information(name: "CHU Moodle", type: "學校", image: "chu02", url: "https://elearn.chu.edu.tw/"),
        Information(name: "中華大學授權軟體", type: "學校", image: "none", url: "https://download.chu.edu.tw/")
    ]

    @State private var showContents: [Bool] = Array(repeating: false, count: 3)
    @State private var offsetY: [CGFloat] = Array(repeating: 0, count: 3)
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollViewReader { scrollView in
                ScrollView {
                    VStack {
                        ForEach(information.indices, id: \.self) { index in
                            CardView(information: information[index], isShowContent: self.$showContents[index])
                                .overlay(
                                    GeometryReader(content: { geometry in
                                        Color.clear
                                            .onAppear(perform: {
                                                offsetY[index] = geometry.frame(in: .named("custom")).origin.y
                                            })
                                        })
                                )
                                .offset(y: self.showContents[index] ? -offsetY[index] - 110 : 0)
                                .padding(.bottom, 20)
                                .padding(.horizontal, self.showContents[index] ? 0 : 20)
                                .opacity(self.showContents.contains(true) && !self.showContents[index] ? 0 : 1)
                                .id(index)
                                .onTapGesture {
                                    withAnimation {
                                        scrollView.scrollTo(
                                            showContents[index] ? index : 0, anchor: .center
                                        )
                                        self.showContents[index].toggle()
                                    }
                                }
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
            .coordinateSpace(name: "custom") // 添加此修饰符来创建自定义坐标空间

            VStack {
                HStack {
                    Color.white
                        .frame(width: 80, height: 30)
                        .cornerRadius(10)
                        .overlay(
                            CustomBackButton(action: {
                                presentationMode.wrappedValue.dismiss()
                            })
                        )
                    Spacer()
                    Color.white
                        .frame(width: 180, height: 30)
                        .cornerRadius(10)
                        .overlay(
                            Text("\(Date().getFormattedWeekday()), \(Date().getFormattedDate())")
                                .font(.headline)
                                .foregroundColor(.gray)
                        )
                }
                Spacer()
            }
            .padding()
            .padding(.top, -5)
            .opacity(showContents.allSatisfy({ !$0 }) ? 1 : 0)
        }
    }
}

extension Date {
    func getFormattedWeekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}

struct SchoolWebsiteView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolWebsiteView()
    }
}
