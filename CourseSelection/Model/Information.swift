//
//  Information.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/7.
//

import Foundation

struct Information {
    var name: String
    var type: String
    var image: String
    var url: String
    
    init(name: String, type: String, image: String, url: String){
        self.name = name
        self.type = type
        self.image = image
        self.url = url
    }
    
    init() {
        self.init(name: "", type: "", image: "", url: "")
    }
}
