//
//  CustomBackButton.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct CustomBackButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.blue)
                Text("Back")
                    .foregroundColor(.blue)
            }
            .background(Color.clear)
        }
    }
}
