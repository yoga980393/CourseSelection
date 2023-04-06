//
//  FullImageRow.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct FullImageRow: View {
    var imageName: String
    var name: String
    var location: String
    var height: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: height)
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(name)
                    .foregroundColor(.black)
                    .font(.system(.title2, design: .rounded))
                
                Text(location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .frame(maxWidth: .infinity)
    }
}
