//
//  GradeEnum.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 26/05/26.
//

enum GradeLevel: String, CaseIterable, Identifiable {
    case preschool    = "Preschool"
    case elementary   = "Elementary"
    case middleSchool = "Middle School"
    case highSchool   = "High School"

    var ageRange: String {
        switch self {
        case .preschool:    return "0-6 years old"
        case .elementary:   return "6-12 years old"
        case .middleSchool: return "12-14 years old"
        case .highSchool:   return "14-18 years old"
        }
    }
    
    var id: Self { self }
}
