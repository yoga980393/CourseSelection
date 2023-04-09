//
//  CustomBackButton.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct CustomBackButton: View {
    let action: () -> Void
    @EnvironmentObject var themeSettings: ThemeSettings

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(themeSettings.accentColor)
                Text("Back")
                    .foregroundColor(themeSettings.accentColor)
            }
            .background(Color.clear)
        }
    }
}


