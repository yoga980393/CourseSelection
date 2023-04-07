//
//  CreditInfo.swift
//  CourseSelection
//
//  Created by 張祐嘉 on 2023/4/7.
//

import Foundation

struct CreditInfo: Codable {
    let required_credits: Int
    let elective_major: Int
    let elective_minor: Int
    let general_education: GeneralEducation
    let english_credits: Int
    let physical_education: PhysicalEducation
    let military_training: Int
    let total_credits: Int

    struct GeneralEducation: Codable {
        let humanities: Int
        let social_sciences: Int
        let arts: Int
        let sciences: Int
        let self_credits: Int
        let biomedical: Int
        let diversity: Int
        let total: Int

        enum CodingKeys: String, CodingKey {
            case humanities
            case social_sciences
            case arts
            case sciences
            case self_credits = "self"
            case biomedical
            case diversity
            case total
        }
    }

    struct PhysicalEducation: Codable {
        let total: Int
        let required: Int
        let fitness: Bool
        let swimming: Bool
    }
    
    init() {
            required_credits = 0
            elective_major = 0
            elective_minor = 0
            general_education = GeneralEducation(
                humanities: 0,
                social_sciences: 0,
                arts: 0,
                sciences: 0,
                self_credits: 0,
                biomedical: 0,
                diversity: 0,
                total: 0
            )
            english_credits = 0
            physical_education = PhysicalEducation(
                total: 0,
                required: 0,
                fitness: false,
                swimming: false
            )
            military_training = 0
            total_credits = 0
        }
}
