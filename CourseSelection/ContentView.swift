//
//  ContentView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/3/20.
//

import SwiftUI

struct ContentView: View {
    @State var couresList = [Course]()
    @State private var tabBarHidden: Bool = false
    @State var selectedCourses: [Course] = []

    var body: some View {
        TabView {
            GeneralCourseView(courseList: $couresList, selectedCourses: $selectedCourses)
                .tabItem {
                    Label("普通課程", systemImage: "tag")
                }
            GeneralStudiesView(courseList: $couresList)
                .tabItem {
                    Label("通識課程", systemImage: "person.circle")
                }
            FavoritesView(selectedCourses: $selectedCourses)
                .tabItem {
                    Label("收藏夾", systemImage: "folder")
                }
        }
        .onAppear {
            fetchData()
        }
    }

    func fetchData() {
        guard let url = Bundle.main.url(forResource: "course", withExtension: "json") else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }

            do {
                let decodedData = try JSONDecoder().decode([Course].self, from: data)

                DispatchQueue.main.async {
                    self.couresList = decodedData
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
