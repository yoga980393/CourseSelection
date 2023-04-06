//
//  LoginView.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/6.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State var Count = 0

    var body: some View {
        VStack {
            VStack{
                Image("chu")
                    .resizable()
                    .scaledToFit()
                    .padding(30)
                
                HStack {
                    Text("學號：")
                    TextField(
                        "Username",
                        text: $username
                    )
                    .disableAutocorrection(true)
                }
                HStack {
                    Text("密碼：")
                    SecureField(
                        "Password",
                        text: $password
                    )
                    .disableAutocorrection(true)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            
            HStack{
                Button{
                    
                }label: {
                    Text("忘記密碼")
                }
                .frame(width: 100, height: 15)
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
                
                Button {
                    Count = 0
                } label: {
                    Text("登入")
                }
                .frame(width: 100, height: 15)
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
            }
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
