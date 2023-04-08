//
//  ThemeSettings.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/8.
//

import SwiftUI
import Combine

class ThemeSettings: ObservableObject {
    @Published var isDarkMode: Bool = false
    @Published var accentColor: Color = Color.blue
}
