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
    
    var body: some View {
        VStack {
            HStack {
                Text("第 \(rank) 志願 :")
                Spacer()
            }
            
            if(choose < 0){
                ZStack {
                    Color.white
                        .frame(height: 118)
                    
                    Text("待選")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                }
            }else{
                TextImageRow(course: CouresList[choose], isSelected: false)
            }
        }
        .id(choose)
    }
}
