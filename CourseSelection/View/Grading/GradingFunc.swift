//
//  GradingFunc.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/7.
//

import Foundation

func creditInfoToArray(gotJson: CreditInfo) -> [Int] {
    let required_credits = gotJson.required_credits
    let elective_major = gotJson.elective_major
    let elective_minor = gotJson.elective_minor
    let general_education_total = gotJson.general_education.total
    let english_credits = gotJson.english_credits
    let physical_education_total = gotJson.physical_education.total + gotJson.physical_education.required
    let military_training = gotJson.military_training
    let total_credits = gotJson.total_credits
    
    let creditInfoArray = [
        required_credits,
        elective_major,
        elective_minor,
        general_education_total,
        english_credits,
        physical_education_total,
        military_training,
        total_credits
    ]
    
    return creditInfoArray
}

func generalEducationToArray(gotJson: CreditInfo) -> [Int] {
    let humanities = gotJson.general_education.humanities
    let social_sciences = gotJson.general_education.social_sciences
    let arts = gotJson.general_education.arts
    let sciences = gotJson.general_education.sciences
    let self_credits = gotJson.general_education.self_credits
    let biomedical = gotJson.general_education.biomedical
    let total = humanities + social_sciences + arts + sciences + self_credits + biomedical
    let diversity = gotJson.general_education.diversity

    let generalEducationArray = [
        humanities,
        social_sciences,
        arts,
        sciences,
        self_credits,
        biomedical,
        total,
        diversity
    ]

    return generalEducationArray
}

func physicalEducationToArray(gotJson: CreditInfo) -> [String] {
    let total = String(gotJson.physical_education.total)
    let required = String(gotJson.physical_education.required)
    let fitness = gotJson.physical_education.fitness ? "通過" : "未通過"
    let swimming = gotJson.physical_education.swimming ? "通過" : "未通過"

    let physicalEducationArray = [
        total,
        required,
        fitness,
        swimming
    ]

    return physicalEducationArray
}
