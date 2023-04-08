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
    @Binding var isLoggedIn: Bool
    @State var Accounts: [Account] = [
        Account(account: "B10802204", password: "123", name: "張祐嘉"),
        Account(account: "B10802222", password: "345", name: "ABC")
    ]
    @Binding var user:Account
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
                    if let url = URL(string: "https://lis.chu.edu.tw/p/404-1052-23350.php?Lang=zh-tw") {
                        UIApplication.shared.open(url)
                    }
                }label: {
                    Text("忘記密碼")
                }
                .frame(width: 100, height: 15)
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
                
                Button {
                    checkCredentials()
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("錯誤"), message: Text(alertMessage), dismissButton: .default(Text("確定")))
        }
    }
    
    private func checkCredentials() {
        if username.isEmpty {
            alertMessage = "請輸入帳號"
            showAlert = true
            return
        }
        
        if password.isEmpty {
            alertMessage = "請輸入密碼"
            showAlert = true
            return
        }
        
        if let account = Accounts.first(where: { $0.account == username }) {
            if account.password == password {
                withAnimation(.easeInOut(duration: 0.5)) {
                    user = account
                    password = ""
                    isLoggedIn = true
                }
            } else {
                alertMessage = "密碼錯誤"
                showAlert = true
            }
        } else {
            alertMessage = "無此帳號"
            showAlert = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: Binding.constant(false), user: Binding.constant(Account(account: "", password: "", name: "")))
    }
}
