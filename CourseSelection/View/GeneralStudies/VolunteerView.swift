//
//  VolunteerView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/3/31.
//

import SwiftUI

struct VolunteerView: View {
    @Binding var CouresList: [Course]
    @State var rank: Int
    @Binding var choose: Int
    @EnvironmentObject var themeSettings: ThemeSettings
    
    var body: some View {
        VStack {
            HStack {
                Text("第 \(rank) 志願 :")
                Spacer()
            }
            
            if(choose < 0){
                ZStack {
                    Color(themeSettings.isDarkMode ? UIColor.systemGray6 : UIColor.systemBackground)
                        .frame(height: 120)
                    
                    Text("待選")
                        .font(.system(size: 30))
                        .foregroundColor(themeSettings.isDarkMode ? .white : .gray)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }else{
                TextImageRow(course: CouresList[choose], isSelected: false, isFavorite: false)
            }
        }
        .id(choose)
        .frame(height: 160)
    }
}
