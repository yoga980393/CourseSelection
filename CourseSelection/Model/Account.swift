//
//  Account.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/8.
//

import Foundation

struct Account {
    var account: String
    var password: String
    var name: String
    
    init(account: String, password: String, name: String) {
        self.account = account
        self.password = password
        self.name = name
    }
}
