//
//  ImageRow.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct ImageRow: View {
    var imageName: String
    var name: String
    var location: String
    var width: CGFloat
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: width)
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(name)
                    .foregroundColor(themeSettings.isDarkMode ? .white : .black)
                    .font(.system(.title2, design: .rounded))
                
                Text(location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}

