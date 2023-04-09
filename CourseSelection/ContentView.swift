//
//  ContentView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/3/20.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    @State var user:Account = Account(account: "", password: "", name: "")
    @StateObject var themeSettings = ThemeSettings()

    var body: some View {
        ZStack {
            HomePageView(user: $user, isLoggedIn: $isLoggedIn)
                .environmentObject(themeSettings)
                .opacity(isLoggedIn ? 1 : 0)
                .zIndex(isLoggedIn ? 1 : 0)

            LoginView(isLoggedIn: $isLoggedIn, user: $user)
                .opacity(isLoggedIn ? 0 : 1)
                .zIndex(isLoggedIn ? 0 : 1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ThemeSettings())
    }
}
